#pragma once

#include <vector>

#include "../../Empire.Device/Vulkan/VkCommon.hpp"

namespace Engine
{
    namespace Rendering
    {
        namespace Vulkan
        {
            class Device;

            /*
             * Вершина сцены. Лейаут обязан совпадать с тем, что ожидает
             * Pipeline (Empire.Pipeline/Vulkan/VkPipeline.cpp) и
             * Cube.hlsl: position : float3, normal : float3.
             */
            struct Vertex
            {
                Types::f32 position[3];
                Types::f32 normal[3];
            };

            // Куб из 36 вершин (грани не шарингятся, индексного буфера нет).
            std::vector<Vertex> MakeCube(Types::f32 size);

            /*
             * Статический вершинный буфер (host visible: данные маленькие,
             * staging-буфер здесь был бы оверинжинирингом).
             *
             * Время жизни: Mesh умирает РАНЬШЕ Device.
             */
            class Mesh
            {
                public:
                    Mesh(
                        const Device& device,
                        const Vertex* vertices,
                        Types::u32 vertexCount
                    );

                    ~Mesh();

                    Mesh(const Mesh&) = delete;
                    Mesh& operator=(const Mesh&) = delete;
                    Mesh(Mesh&&) = delete;
                    Mesh& operator=(Mesh&&) = delete;

                    void Bind(VkCommandBuffer commandBuffer) const;
                    void Draw(VkCommandBuffer commandBuffer) const;

                    Types::u32 GetVertexCount() const;

                private:
                    void Destroy();

                    const Device& device;

                    VkBuffer handle = VK_NULL_HANDLE;
                    VkDeviceMemory memory = VK_NULL_HANDLE;

                    Types::u32 vertexCount = 0;
            };
        }
    }
}
