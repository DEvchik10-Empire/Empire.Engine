#pragma once

#include <vector>

#include "VkSwapChain.hpp"

namespace Engine
{
    namespace Rendering
    {
        namespace Vulkan
        {
            /*
             * Что рисуется в swapchain: render pass + depth + framebuffer'ы.
             *
             * Цепочка кадра:
             *
             *     target.Begin(commandBuffer, imageIndex, r, g, b, a);
             *     ... пайплайны рисуют (небо, сцена) ...
             *     target.End(commandBuffer);
             *
             * Begin переводит изображение swapchain в COLOR_ATTACHMENT и
             * открывает render pass с clear-цветом (плюс depth = far).
             * End закрывает render pass: изображение сразу в PRESENT_SRC,
             * отдельный барьер не нужен (finalLayout в описании аттачмента).
             *
             * Время жизни: RenderTarget умирает РАНЬШЕ SwapChain и Device.
             */
            class RenderTarget
            {
                public:
                    RenderTarget(
                        const Device& device,
                        const SwapChain& swapChain
                    );

                    ~RenderTarget();

                    RenderTarget(const RenderTarget&) = delete;
                    RenderTarget& operator=(const RenderTarget&) = delete;
                    RenderTarget(RenderTarget&&) = delete;
                    RenderTarget& operator=(RenderTarget&&) = delete;

                    // Пересоздаёт depth и framebuffer'ы под текущий swapchain
                    // (после SwapChain::Resize). Сам ждёт GPU.
                    void Recreate();

                    void Begin(
                        VkCommandBuffer commandBuffer,
                        Types::u32 imageIndex,
                        Types::f32 red,
                        Types::f32 green,
                        Types::f32 blue,
                        Types::f32 alpha
                    ) const;

                    void End(VkCommandBuffer commandBuffer) const;

                    VkRenderPass GetRenderPass() const;

                private:
                    VkFormat FindDepthFormat() const;
                    Types::u32 FindMemoryType(
                        Types::u32 typeBits,
                        VkMemoryPropertyFlags properties
                    ) const;

                    void CreateRenderPass();
                    void CreateDepth();
                    void CreateFramebuffers();

                    void DestroyDepth();
                    void DestroyFramebuffers();
                    void Destroy();

                    const Device& device;
                    const SwapChain& swapChain;

                    VkRenderPass renderPass = VK_NULL_HANDLE;

                    VkFormat depthFormat = VK_FORMAT_UNDEFINED;

                    VkImage depthImage = VK_NULL_HANDLE;
                    VkDeviceMemory depthMemory = VK_NULL_HANDLE;
                    VkImageView depthView = VK_NULL_HANDLE;

                    std::vector<VkImageView> colorViews;
                    std::vector<VkFramebuffer> framebuffers;
            };
        }
    }
}
