#include "VkMesh.hpp"

#include <cstring>
#include <stdexcept>

#include "../../Empire.Device/Vulkan/VkDevice.hpp"

namespace Engine
{
    namespace Rendering
    {
        namespace Vulkan
        {
            std::vector<Vertex> MakeCube(Types::f32 size)
            {
                const Types::f32 h = size * 0.5f;

                // Ограниченная грань: { position, normal }, 6 вершин.
                #define FACE(px, py, pz, nx, ny, nz) \
                    {{ px, py, pz }, { nx, ny, nz }}

                const std::vector<Vertex> vertices = {
                    // +Z
                    FACE(-h, -h,  h,  0.0f,  0.0f,  1.0f),
                    FACE( h, -h,  h,  0.0f,  0.0f,  1.0f),
                    FACE( h,  h,  h,  0.0f,  0.0f,  1.0f),
                    FACE(-h, -h,  h,  0.0f,  0.0f,  1.0f),
                    FACE( h,  h,  h,  0.0f,  0.0f,  1.0f),
                    FACE(-h,  h,  h,  0.0f,  0.0f,  1.0f),

                    // -Z
                    FACE( h, -h, -h,  0.0f,  0.0f, -1.0f),
                    FACE(-h, -h, -h,  0.0f,  0.0f, -1.0f),
                    FACE(-h,  h, -h,  0.0f,  0.0f, -1.0f),
                    FACE( h, -h, -h,  0.0f,  0.0f, -1.0f),
                    FACE(-h,  h, -h,  0.0f,  0.0f, -1.0f),
                    FACE( h,  h, -h,  0.0f,  0.0f, -1.0f),

                    // +X
                    FACE( h, -h,  h,  1.0f,  0.0f,  0.0f),
                    FACE( h, -h, -h,  1.0f,  0.0f,  0.0f),
                    FACE( h,  h, -h,  1.0f,  0.0f,  0.0f),
                    FACE( h, -h,  h,  1.0f,  0.0f,  0.0f),
                    FACE( h,  h, -h,  1.0f,  0.0f,  0.0f),
                    FACE( h,  h,  h,  1.0f,  0.0f,  0.0f),

                    // -X
                    FACE(-h, -h, -h, -1.0f,  0.0f,  0.0f),
                    FACE(-h, -h,  h, -1.0f,  0.0f,  0.0f),
                    FACE(-h,  h,  h, -1.0f,  0.0f,  0.0f),
                    FACE(-h, -h, -h, -1.0f,  0.0f,  0.0f),
                    FACE(-h,  h,  h, -1.0f,  0.0f,  0.0f),
                    FACE(-h,  h, -h, -1.0f,  0.0f,  0.0f),

                    // +Y
                    FACE(-h,  h,  h,  0.0f,  1.0f,  0.0f),
                    FACE( h,  h,  h,  0.0f,  1.0f,  0.0f),
                    FACE( h,  h, -h,  0.0f,  1.0f,  0.0f),
                    FACE(-h,  h,  h,  0.0f,  1.0f,  0.0f),
                    FACE( h,  h, -h,  0.0f,  1.0f,  0.0f),
                    FACE(-h,  h, -h,  0.0f,  1.0f,  0.0f),

                    // -Y
                    FACE(-h, -h, -h,  0.0f, -1.0f,  0.0f),
                    FACE( h, -h, -h,  0.0f, -1.0f,  0.0f),
                    FACE( h, -h,  h,  0.0f, -1.0f,  0.0f),
                    FACE(-h, -h, -h,  0.0f, -1.0f,  0.0f),
                    FACE( h, -h,  h,  0.0f, -1.0f,  0.0f),
                    FACE(-h, -h,  h,  0.0f, -1.0f,  0.0f)
                };

                #undef FACE

                return vertices;
            }

            Mesh::Mesh(
                const Device& device,
                const Vertex* vertices,
                Types::u32 vertexCount
            )
                : device(device),
                  vertexCount(vertexCount)
            {
                try
                {
                    if (!vertices || vertexCount == 0)
                    {
                        throw std::runtime_error(
                            "Vulkan: mesh has no vertices");
                    }

                    const VkDeviceSize size =
                        static_cast<VkDeviceSize>(vertexCount) *
                        sizeof(Vertex);

                    VkBufferCreateInfo bufferInfo{};
                    bufferInfo.sType = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
                    bufferInfo.size = size;
                    bufferInfo.usage = VK_BUFFER_USAGE_VERTEX_BUFFER_BIT;
                    bufferInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;

                    Check(
                        vkCreateBuffer(
                            device.Get(), &bufferInfo, nullptr, &handle),
                        "vkCreateBuffer");

                    // ---------------------------------------------------------
                    // Память: host visible, данные пишем сразу с CPU.
                    // ---------------------------------------------------------
                    VkMemoryRequirements requirements{};
                    vkGetBufferMemoryRequirements(device.Get(), handle, &requirements);

                    VkPhysicalDeviceMemoryProperties memoryProperties{};
                    vkGetPhysicalDeviceMemoryProperties(
                        device.GetPhysicalDevice(), &memoryProperties);

                    Types::u32 memoryType = 0;
                    Types::b8 found = false;

                    for (Types::u32 i = 0;
                         i < memoryProperties.memoryTypeCount;
                         ++i)
                    {
                        const Types::b8 fitsFilter =
                            requirements.memoryTypeBits & (1u << i);

                        const Types::b8 isHostVisible =
                            memoryProperties.memoryTypes[i].propertyFlags &
                            VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT;

                        if (fitsFilter && isHostVisible)
                        {
                            memoryType = i;
                            found = true;
                            break;
                        }
                    }

                    if (!found)
                    {
                        throw std::runtime_error(
                            "Vulkan: no host visible memory for vertex buffer");
                    }

                    VkMemoryAllocateInfo allocateInfo{};
                    allocateInfo.sType =
                        VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
                    allocateInfo.allocationSize = requirements.size;
                    allocateInfo.memoryTypeIndex = memoryType;

                    Check(
                        vkAllocateMemory(
                            device.Get(), &allocateInfo, nullptr, &memory),
                        "vkAllocateMemory");

                    Check(
                        vkBindBufferMemory(device.Get(), handle, memory, 0),
                        "vkBindBufferMemory");

                    Types::VoidPtr mapped = nullptr;

                    Check(
                        vkMapMemory(device.Get(), memory, 0, size, 0, &mapped),
                        "vkMapMemory");

                    std::memcpy(mapped, vertices, static_cast<Types::usize>(size));

                    vkUnmapMemory(device.Get(), memory);
                }
                catch (...)
                {
                    Destroy();
                    throw;
                }
            }

            Mesh::~Mesh()
            {
                Destroy();
            }

            void Mesh::Destroy()
            {
                if (device.Get() == VK_NULL_HANDLE)
                {
                    return;
                }

                if (handle != VK_NULL_HANDLE)
                {
                    vkDestroyBuffer(device.Get(), handle, nullptr);
                    handle = VK_NULL_HANDLE;
                }

                if (memory != VK_NULL_HANDLE)
                {
                    vkFreeMemory(device.Get(), memory, nullptr);
                    memory = VK_NULL_HANDLE;
                }
            }

            void Mesh::Bind(VkCommandBuffer commandBuffer) const
            {
                const VkDeviceSize offset = 0;

                vkCmdBindVertexBuffers(
                    commandBuffer, 0, 1, &handle, &offset);
            }

            void Mesh::Draw(VkCommandBuffer commandBuffer) const
            {
                vkCmdDraw(commandBuffer, vertexCount, 1, 0, 0);
            }

            Types::u32 Mesh::GetVertexCount() const
            {
                return vertexCount;
            }
        }
    }
}
