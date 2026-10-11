#pragma once

#include "../../Empire.Device/Vulkan/VkCommon.hpp"

namespace Engine
{
    namespace Rendering
    {
        namespace Vulkan
        {
            class Device;

            /*
             * Шейдерный модуль из готового .spv файла.
             *
             * Компиляция HLSL -> SPIR-V живёт отдельно (Shaders/, xmake,
             * glslangValidator), в рантайме это просто загрузка байтов.
             *
             * Ошибки: файл не найден или битый -> std::runtime_error.
             *
             * Время жизни: ShaderModule умирает РАНЬШЕ Pipeline,
             * которая построена на нём.
             */
            class ShaderModule
            {
                public:
                    ShaderModule(
                        const Device& device,
                        const Types::String& path
                    );

                    ~ShaderModule();

                    ShaderModule(const ShaderModule&) = delete;
                    ShaderModule& operator=(const ShaderModule&) = delete;
                    ShaderModule(ShaderModule&&) = delete;
                    ShaderModule& operator=(ShaderModule&&) = delete;

                    VkShaderModule Get() const;

                private:
                    void Destroy();

                    const Device& device;
                    VkShaderModule handle = VK_NULL_HANDLE;
            };
        }
    }
}
