#pragma once

#include "../../Empire.Device/Vulkan/VkCommon.hpp"

#include "VkShader.hpp"

namespace Engine
{
    namespace Rendering
    {
        namespace Vulkan
        {
            class Device;

            /*
             * Что нужно графическому пайплайну, чтобы собраться.
             *
             * Шейдеры - пути к .spv (см. Shaders/SpirV).
             */
            struct PipelineConfig
            {
                Types::String vertexShaderPath;
                Types::String fragmentShaderPath;

                // false -> fullscreen-треугольник по SV_VertexID,
                // вершинный буфер и лейаут не нужны (небо).
                Types::b8 hasVertexLayout = false;

                // Тест и запись глубины (кубу нужен, небу - нет).
                Types::b8 depthTest = false;
                Types::b8 depthWrite = false;

                VkCullModeFlagBits cullMode = VK_CULL_MODE_NONE;
            };

            /*
             * Графический pipeline + pipeline layout.
             *
             * Vertex-лейаут фиксированный: { position : float3, normal : float3 }
             * (см. Empire.Mesh/Vulkan/VkMesh.hpp).
             *
             * Viewport/scissor динамические: их задаёт Bind().
             *
             * Константы шейдеров - push-блок до 128 байт (гарантированный
             * минимум Vulkan), поэтому сцена не тянет uniform-буферы.
             *
             * Время жизни: Pipeline умирает РАНЬШЕ RenderPass,
             * на котором она построена.
             */
            class Pipeline
            {
                public:
                    Pipeline(
                        const Device& device,
                        VkRenderPass renderPass,
                        const PipelineConfig& config
                    );

                    ~Pipeline();

                    Pipeline(const Pipeline&) = delete;
                    Pipeline& operator=(const Pipeline&) = delete;
                    Pipeline(Pipeline&&) = delete;
                    Pipeline& operator=(Pipeline&&) = delete;

                    void Bind(
                        VkCommandBuffer commandBuffer,
                        VkExtent2D extent
                    ) const;

                    // data обязан влезать в MaxPushConstants байт.
                    void PushConstants(
                        VkCommandBuffer commandBuffer,
                        const void* data,
                        Types::u32 size
                    ) const;

                    VkPipeline Get() const;
                    VkPipelineLayout GetLayout() const;

                    static constexpr Types::u32 MaxPushConstants = 128;

                private:
                    void Destroy();

                    const Device& device;

                    VkPipelineLayout layout = VK_NULL_HANDLE;
                    VkPipeline handle = VK_NULL_HANDLE;
            };
        }
    }
}
