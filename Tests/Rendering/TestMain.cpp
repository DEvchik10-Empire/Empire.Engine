/*
 * Тест рендеринга: Platform (окно) + Rendering (Vulkan) + шейдеры (Shaders/).
 *
 * Что проверяет:
 *   1. Окно создаётся через фабрику (Wayland или X11) БЕЗ собственной отрисовки.
 *   2. Из окна достаётся NativeWindowHandle (мост Platform -> Rendering).
 *   3. Vulkan: Instance -> Surface -> Device -> SwapChain -> RenderTarget.
 *   4. Каждый кадр: небо (HLSL, полноэкранный треугольник) и поверх -
 *      вращающийся куб с "дышащим" цветом (те же синусы, что раньше
 *      закрашивали окно целиком).
 *   5. Ресайз окна пересоздаёт swapchain и рендер-таргет.
 *   6. Закрытие окна (крестик) корректно всё разбирает.
 *
 * Шейдеры: Shaders/Hlsl/*.hlsl компилируются в .spv при сборке (цель
 * Empire.Shaders), здесь грузятся как готовые файлы.
 *
 * Запуск:
 *   Empire.Rendering.Test.Vulkan [auto|wayland|legasy]
 *       [--frames=N] [--no-validation] [--shaders=PATH]
 */

#include <chrono>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <exception>
#include <iostream>
#include <memory>
#include <string>
#include <thread>

#include "Empire.Window/IWindowImpl.hpp"
#include "Empire.Window/WindowBackend.hpp"
#include "Empire.Window/WindowConfig.hpp"
#include "Empire.Window/WindowImplFactory.hpp"

#include "Empire.Device/Vulkan/VkDevice.hpp"
#include "Empire.Device/Vulkan/VkInstance.hpp"
#include "Empire.SwapChain/Vulkan/VkSurface.hpp"
#include "Empire.SwapChain/Vulkan/VkSwapChain.hpp"
#include "Empire.SwapChain/Vulkan/VkRenderTarget.hpp"
#include "Empire.CommandBuffer/Vulkan/VkFrameContext.hpp"
#include "Empire.Pipeline/Vulkan/VkPipeline.hpp"
#include "Empire.Mesh/Vulkan/VkMesh.hpp"

#include "Engine/Math/Math.hpp"
#include "Engine/Math/Matrix/Matrix4.hpp"
#include "Engine/Math/Vector/Vector3.hpp"
#include "Engine/Math/Vector/Vector4.hpp"

namespace Platform = Engine::Platform;
namespace Vulkan = Engine::Rendering::Vulkan;
namespace Math = Engine::Math;

namespace
{
    /*
     * Зеркала push-констант из Shaders/Hlsl/*.hlsl.
     * Порядок и размер полей обязаны совпадать с шейдером.
     */
    struct CubeConstants
    {
        float mvp[16];
        float lightAndTime[4];  // xyz - свет в объектных координатах, w - время
        float baseColor[4];
    };

    struct SkyConstants
    {
        float cameraRight[4];    // w - tan(fov/2)
        float cameraUp[4];       // w - aspect ratio
        float cameraForward[4];  // w - время
        float sunDirection[4];   // w - яркость звёзд
        float topColor[4];       // w - плотность облаков
        float bottomColor[4];
        float sunScatterColor[4];// w - яркость солнечного диска
        float cloudsColor[4];    // w - интенсивность теней в облаках
    };

    static_assert(
        sizeof(SkyConstants) <= Vulkan::Pipeline::MaxPushConstants,
        "push constants must fit into 128 bytes");

    struct Options
    {
        Platform::WindowBackend backend = Platform::WindowBackend::Auto;

        // 0 = работать, пока окно не закроют.
        unsigned int maxFrames = 0;

        bool validation = true;

        // Готовые .spv лежат здесь (см. Shaders/xmake.lua).
        std::string shaderPath = "Shaders/SpirV";
    };

    const char* BackendName(Platform::WindowBackend backend)
    {
        switch (backend)
        {
            case Platform::WindowBackend::Auto:    return "Auto";
            case Platform::WindowBackend::Wayland: return "Wayland";
            case Platform::WindowBackend::legasy:  return "legasy (X11)";
        }

        return "Unknown";
    }

    Options ParseOptions(int argc, char** argv)
    {
        Options options;

        for (int i = 1; i < argc; ++i)
        {
            const char* argument = argv[i];

            if (std::strcmp(argument, "wayland") == 0)
            {
                options.backend = Platform::WindowBackend::Wayland;
            }
            else if (std::strcmp(argument, "legasy") == 0)
            {
                options.backend = Platform::WindowBackend::legasy;
            }
            else if (std::strcmp(argument, "auto") == 0)
            {
                options.backend = Platform::WindowBackend::Auto;
            }
            else if (std::strcmp(argument, "--no-validation") == 0)
            {
                options.validation = false;
            }
            else if (std::strncmp(argument, "--frames=", 9) == 0)
            {
                options.maxFrames = static_cast<unsigned int>(
                    std::strtoul(argument + 9, nullptr, 10));
            }
            else if (std::strncmp(argument, "--shaders=", 10) == 0)
            {
                options.shaderPath = argument + 10;
            }
            else
            {
                std::cerr << "[Test] Unknown argument: " << argument << '\n';
            }
        }

        return options;
    }

    // Matrix4 -> сырой массив строками (ровно так, как лежит в памяти,
    // row-major - это то, что ждёт HLSL-матрица row_major).
    void ToArray(const Math::Matrix4& matrix, float out[16])
    {
        out[0]  = matrix.M00;  out[1]  = matrix.M01;
        out[2]  = matrix.M02;  out[3]  = matrix.M03;

        out[4]  = matrix.M10;  out[5]  = matrix.M11;
        out[6]  = matrix.M12;  out[7]  = matrix.M13;

        out[8]  = matrix.M20;  out[9]  = matrix.M21;
        out[10] = matrix.M22;  out[11] = matrix.M23;

        out[12] = matrix.M30;  out[13] = matrix.M31;
        out[14] = matrix.M32;  out[15] = matrix.M33;
    }

    void FillVector(const Math::Vector3& vector, float out[3])
    {
        out[0] = vector.X;
        out[1] = vector.Y;
        out[2] = vector.Z;
    }

    // Константы неба на один кадр. Цвета - из Godot-материала
    // stylized_sky (top/bottom/sun_scatter/clouds_light_color).
    SkyConstants BuildSkyConstants(
        const Math::Vector3& right,
        const Math::Vector3& cameraUp,
        const Math::Vector3& forward,
        float tanHalfFov,
        float aspect,
        float seconds)
    {
        SkyConstants sky{};

        sky.cameraRight[0] = right.X;
        sky.cameraRight[1] = right.Y;
        sky.cameraRight[2] = right.Z;
        sky.cameraRight[3] = tanHalfFov;

        sky.cameraUp[0] = cameraUp.X;
        sky.cameraUp[1] = cameraUp.Y;
        sky.cameraUp[2] = cameraUp.Z;
        sky.cameraUp[3] = aspect;

        sky.cameraForward[0] = forward.X;
        sky.cameraForward[1] = forward.Y;
        sky.cameraForward[2] = forward.Z;
        sky.cameraForward[3] = seconds;

        // Луна впереди-сверху-слева (как на референсе sky_night-1.jpg):
        // диск в верхней трети кадра, левее центра.
        const Math::Vector3 sun =
            Math::Vector3(-0.16f, 0.21f, -0.96f).Normalized();

        sky.sunDirection[0] = sun.X;
        sky.sunDirection[1] = sun.Y;
        sky.sunDirection[2] = sun.Z;
        sky.sunDirection[3] = 6.0f;  // яркость звёзд

        sky.topColor[0] = 0.09f;
        sky.topColor[1] = 0.11f;
        sky.topColor[2] = 0.35f;
        sky.topColor[3] = 0.47f;  // порог плотности облаков

        sky.bottomColor[0] = 0.28f;
        sky.bottomColor[1] = 0.32f;
        sky.bottomColor[2] = 0.68f;

        sky.sunScatterColor[0] = 0.55f;
        sky.sunScatterColor[1] = 0.65f;
        sky.sunScatterColor[2] = 1.0f;
        sky.sunScatterColor[3] = 1.0f;  // яркость ореола луны

        sky.cloudsColor[0] = 0.62f;
        sky.cloudsColor[1] = 0.75f;
        sky.cloudsColor[2] = 1.0f;
        sky.cloudsColor[3] = 1.0f;

        return sky;
    }

    // Всё, что связано с Vulkan, живёт ТОЛЬКО внутри этой функции.
    // Когда она завершается (или бросает исключение), все объекты Vulkan
    // уничтожаются в правильном порядке (в обратном созданию) -
    // и только ПОСЛЕ этого main закрывает окно.
    void RunRendering(Platform::IWindowImpl& window, const Options& options)
    {
        Vulkan::InstanceDesc instanceDesc;
        instanceDesc.applicationName = "Empire.Rendering.Test";
        instanceDesc.enableValidation = options.validation;

        Vulkan::Instance instance(instanceDesc);

        std::cout << "[Test] Vulkan instance created"
                  << (instance.IsValidationEnabled() ? " (validation ON)" : "")
                  << '\n';

        // ---- Мост: окно -> нативные хэндлы -> VkSurfaceKHR ----
        Vulkan::Surface surface(instance, window.GetNativeHandle());

        Vulkan::Device device(instance, surface.Get());

        std::cout << "[Test] GPU: " << device.GetName() << '\n';

        const auto [startWidth, startHeight] = window.GetSize();

        Vulkan::SwapChain swapChain(
            device,
            surface,
            static_cast<unsigned int>(startWidth),
            static_cast<unsigned int>(startHeight));

        Vulkan::RenderTarget renderTarget(device, swapChain);

        Vulkan::FrameContext frames(device, swapChain);

        // ---- Пайплайны: небо (без вершинного буфера) и куб ----
        Vulkan::PipelineConfig skyConfig;
        skyConfig.vertexShaderPath = options.shaderPath + "/Sky.vert.spv";
        skyConfig.fragmentShaderPath = options.shaderPath + "/Sky.frag.spv";
        skyConfig.hasVertexLayout = false;
        skyConfig.depthTest = false;
        skyConfig.depthWrite = false;

        Vulkan::Pipeline skyPipeline(
            device, renderTarget.GetRenderPass(), skyConfig);

        Vulkan::PipelineConfig cubeConfig;
        cubeConfig.vertexShaderPath = options.shaderPath + "/Cube.vert.spv";
        cubeConfig.fragmentShaderPath = options.shaderPath + "/Cube.frag.spv";
        cubeConfig.hasVertexLayout = true;
        cubeConfig.depthTest = true;
        cubeConfig.depthWrite = true;

        Vulkan::Pipeline cubePipeline(
            device, renderTarget.GetRenderPass(), cubeConfig);

        const std::vector<Vulkan::Vertex> vertices = Vulkan::MakeCube(1.0f);

        Vulkan::Mesh cubeMesh(
            device,
            vertices.data(),
            static_cast<unsigned int>(vertices.size()));

        std::cout << "[Test] Pipelines and mesh created "
                  << "(shaders: " << options.shaderPath << ")\n";

        std::cout << "[Test] Rendering. Resize the window, then close it.\n\n";

        // Камера: смотрит на куб с лёгким наклоном.
        const Math::Vector3 eye(0.0f, 0.55f, 4.2f);
        const Math::Vector3 target(0.0f, 0.0f, 0.0f);
        const Math::Vector3 up(0.0f, 1.0f, 0.0f);

        const Math::Vector3 forward = (target - eye).Normalized();
        const Math::Vector3 right = forward.Cross(up).Normalized();
        const Math::Vector3 cameraUp = right.Cross(forward);

        const float fieldOfView = Math::DegreesToRadians(55.0f);
        const float tanHalfFov = Math::Tan(fieldOfView * 0.5f);

        // Vulkan: ось Y вниз, глубина 0..1 - достраиваем матрицу поверх
        // OpenGL-стиля, которым написана перспектива в Engine.Math.
        const Math::Matrix4 vulkanFix(
            1.0f,  0.0f,  0.0f,  0.0f,
            0.0f, -1.0f,  0.0f,  0.0f,
            0.0f,  0.0f,  0.5f,  0.5f,
            0.0f,  0.0f,  0.0f,  1.0f);

        // Направление света в мировых координатах (куб крутится, небо стоит).
        const Math::Vector4 lightWorld(0.45f, 0.8f, 0.35f, 0.0f);

        // Размер, под который сейчас собран swapchain
        // (чтобы не пересоздавать его каждый кадр).
        unsigned int swapWidth = static_cast<unsigned int>(startWidth);
        unsigned int swapHeight = static_cast<unsigned int>(startHeight);

        const auto startTime = std::chrono::steady_clock::now();
        auto fpsTime = startTime;

        unsigned int frameCount = 0;
        unsigned int fpsFrames = 0;

        while (window.IsOpen())
        {
            // false из PollEvent = "очередь пуста", а не ошибка.
            while (window.PollEvent())
            {
            }

            if (window.ShouldClose())
            {
                break;
            }

            const auto [width, height] = window.GetSize();

            // Окно свёрнуто или ещё без размера: рисовать нечего.
            if (width <= 0 || height <= 0)
            {
                std::this_thread::sleep_for(std::chrono::milliseconds(16));
                continue;
            }

            // Размер окна изменился -> пересобираем swapchain и таргет.
            if (
                static_cast<unsigned int>(width) != swapWidth ||
                static_cast<unsigned int>(height) != swapHeight)
            {
                swapWidth = static_cast<unsigned int>(width);
                swapHeight = static_cast<unsigned int>(height);

                if (swapChain.Resize(swapWidth, swapHeight))
                {
                    renderTarget.Recreate();

                    std::cout << "[Test] Resized: "
                              << swapChain.GetExtent().width << "x"
                              << swapChain.GetExtent().height << '\n';
                }
            }

            const float aspect =
                static_cast<float>(width) / static_cast<float>(height);

            const float seconds =
                std::chrono::duration<float>(
                    std::chrono::steady_clock::now() - startTime).count();

            // ---------------- кадр ----------------
            Vulkan::FrameInfo frame;

            const Vulkan::FrameStatus began = frames.Begin(frame);

            if (began == Vulkan::FrameStatus::OutOfDate)
            {
                if (swapChain.Resize(swapWidth, swapHeight))
                {
                    renderTarget.Recreate();
                }

                continue;
            }

            if (began == Vulkan::FrameStatus::Skipped)
            {
                continue;
            }

            // Цвет "под небом": на случай, если небо ещё не покрыло кадр.
            renderTarget.Begin(
                frame.commandBuffer, frame.imageIndex,
                0.015f, 0.02f, 0.05f, 1.0f);

            // ---- Небо: полноэкранный треугольник, без глубины ----
            const SkyConstants sky = BuildSkyConstants(
                right, cameraUp, forward, tanHalfFov, aspect, seconds);

            skyPipeline.Bind(frame.commandBuffer, frame.extent);
            skyPipeline.PushConstants(
                frame.commandBuffer, &sky, sizeof(sky));

            vkCmdDraw(frame.commandBuffer, 3, 1, 0, 0);

            // ---- Куб: вращается, цвет "дышит" ----
            const Math::Matrix4 projection = Math::Matrix4::Perspective(
                fieldOfView, aspect, 0.1f, 100.0f);

            const Math::Matrix4 view =
                Math::Matrix4::LookAt(eye, target, up);

            const Math::Matrix4 model =
                Math::Matrix4::RotationY(seconds * 0.9f) *
                Math::Matrix4::RotationX(seconds * 0.6f);

            const Math::Matrix4 mvp =
                vulkanFix * projection * view * model;

            CubeConstants cube{};

            ToArray(mvp, cube.mvp);

            // Модель - чистый поворот, поэтому из объектных координат
            // в мировые (и обратно) переводит транспонированная матрица.
            const Math::Vector4 lightObject =
                model.Transposed() * lightWorld;

            cube.lightAndTime[0] = lightObject.X;
            cube.lightAndTime[1] = lightObject.Y;
            cube.lightAndTime[2] = lightObject.Z;
            cube.lightAndTime[3] = seconds;

            cube.baseColor[0] = 1.0f;
            cube.baseColor[1] = 1.0f;
            cube.baseColor[2] = 1.0f;
            cube.baseColor[3] = 1.0f;

            cubePipeline.Bind(frame.commandBuffer, frame.extent);
            cubeMesh.Bind(frame.commandBuffer);
            cubePipeline.PushConstants(
                frame.commandBuffer, &cube, sizeof(cube));

            cubeMesh.Draw(frame.commandBuffer);

            renderTarget.End(frame.commandBuffer);

            if (frames.End(frame) == Vulkan::FrameStatus::OutOfDate)
            {
                if (swapChain.Resize(swapWidth, swapHeight))
                {
                    renderTarget.Recreate();
                }
            }

            ++frameCount;
            ++fpsFrames;

            // Раз в секунду печатаем FPS.
            const auto now = std::chrono::steady_clock::now();

            if (now - fpsTime >= std::chrono::seconds(1))
            {
                std::cout << "[Test] " << fpsFrames << " fps  (frame "
                          << frameCount << ")\n";

                fpsFrames = 0;
                fpsTime = now;
            }

            if (options.maxFrames != 0 && frameCount >= options.maxFrames)
            {
                break;
            }
        }

        // Перед уничтожением ресурсов GPU должен закончить работу.
        device.WaitIdle();

        std::cout << "\n[Test] Rendered frames: " << frameCount << '\n';
    }
}

int main(int argc, char** argv)
{
    const Options options = ParseOptions(argc, argv);

    std::cout << "=== Empire.Rendering Vulkan test, window backend: "
              << BackendName(options.backend) << " ===\n";

    // ---- Окно: БЕЗ собственной отрисовки (selfDraw = false) ----
    Platform::WindowConfig config;

    config.width = 1280;
    config.height = 720;
    config.title = "Empire Engine - sky and cube";
    config.backend = options.backend;
    config.selfDraw = false;

    std::unique_ptr<Platform::IWindowImpl> window =
        Platform::CreateWindowImpl(config);

    if (!window)
    {
        std::cerr << "[Test] FAILED: window was not created.\n";
        return 1;
    }

    std::cout << "[Test] Window created, backend: "
              << BackendName(window->GetBackend()) << '\n';

    window->Show();

    int result = 0;

    try
    {
        RunRendering(*window, options);
    }
    catch (const std::exception& error)
    {
        std::cerr << "[Test] FAILED: " << error.what() << '\n';
        result = 1;
    }

    // К этому моменту все объекты Vulkan уже уничтожены.
    window->Close();
    window.reset();

    if (result == 0)
    {
        std::cout << "=== Test passed ===\n";
    }

    return result;
}
