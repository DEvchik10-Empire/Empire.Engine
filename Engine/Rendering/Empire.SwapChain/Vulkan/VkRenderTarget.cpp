#include "VkRenderTarget.hpp"

#include <stdexcept>

namespace Engine
{
    namespace Rendering
    {
        namespace Vulkan
        {
            namespace
            {
                // Что поддерживает драйвер для depth-аттачмента.
                VkFormat FindSupportedDepthFormat(
                    VkPhysicalDevice physicalDevice,
                    VkFormat candidates[],
                    Types::u32 candidateCount)
                {
                    for (Types::u32 i = 0; i < candidateCount; ++i)
                    {
                        VkFormatProperties properties{};
                        vkGetPhysicalDeviceFormatProperties(
                            physicalDevice, candidates[i], &properties);

                        if (
                            properties.optimalTilingFeatures &
                            VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT)
                        {
                            return candidates[i];
                        }
                    }

                    return VK_FORMAT_UNDEFINED;
                }
            }

            RenderTarget::RenderTarget(
                const Device& device,
                const SwapChain& swapChain
            )
                : device(device),
                  swapChain(swapChain)
            {
                try
                {
                    depthFormat = FindDepthFormat();

                    if (depthFormat == VK_FORMAT_UNDEFINED)
                    {
                        throw std::runtime_error(
                            "Vulkan: no supported depth format");
                    }

                    CreateRenderPass();
                    CreateDepth();
                    CreateFramebuffers();
                }
                catch (...)
                {
                    Destroy();
                    throw;
                }
            }

            RenderTarget::~RenderTarget()
            {
                Destroy();
            }

            void RenderTarget::Recreate()
            {
                device.WaitIdle();

                DestroyDepth();
                DestroyFramebuffers();

                CreateDepth();
                CreateFramebuffers();
            }

            VkFormat RenderTarget::FindDepthFormat() const
            {
                VkFormat candidates[] = {
                    VK_FORMAT_D32_SFLOAT,
                    VK_FORMAT_D24_UNORM_S8_UINT,
                    VK_FORMAT_D16_UNORM
                };

                return FindSupportedDepthFormat(
                    device.GetPhysicalDevice(),
                    candidates,
                    static_cast<Types::u32>(
                        sizeof(candidates) / sizeof(candidates[0])));
            }

            Types::u32 RenderTarget::FindMemoryType(
                Types::u32 typeBits,
                VkMemoryPropertyFlags properties
            ) const
            {
                VkPhysicalDeviceMemoryProperties memoryProperties{};
                vkGetPhysicalDeviceMemoryProperties(
                    device.GetPhysicalDevice(), &memoryProperties);

                for (Types::u32 i = 0;
                     i < memoryProperties.memoryTypeCount;
                     ++i)
                {
                    const Types::b8 fitsFilter =
                        typeBits & (1u << i);

                    const Types::b8 fitsProperties =
                        (memoryProperties.memoryTypes[i].propertyFlags &
                         properties) == properties;

                    if (fitsFilter && fitsProperties)
                    {
                        return i;
                    }
                }

                throw std::runtime_error(
                    "Vulkan: no suitable memory type");
            }

            void RenderTarget::CreateRenderPass()
            {
                // ---------------------------------------------------------
                // Цвет: полная перезапись каждый кадр (UNDEFINED -> clear),
                // на выходе сразу PRESENT_SRC (см. комментарий в hpp).
                // ---------------------------------------------------------
                VkAttachmentDescription color{};
                color.format = swapChain.GetFormat();
                color.samples = VK_SAMPLE_COUNT_1_BIT;
                color.loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR;
                color.storeOp = VK_ATTACHMENT_STORE_OP_STORE;
                color.stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE;
                color.stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE;
                color.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
                color.finalLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR;

                VkAttachmentDescription depth{};
                depth.format = depthFormat;
                depth.samples = VK_SAMPLE_COUNT_1_BIT;
                depth.loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR;
                depth.storeOp = VK_ATTACHMENT_STORE_OP_DONT_CARE;
                depth.stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE;
                depth.stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE;
                depth.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
                depth.finalLayout =
                    VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL;

                const VkAttachmentReference colorReference = {
                    0, VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL
                };

                const VkAttachmentReference depthReference = {
                    1, VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL
                };

                VkSubpassDescription subpass{};
                subpass.pipelineBindPoint =
                    VK_PIPELINE_BIND_POINT_GRAPHICS;
                subpass.colorAttachmentCount = 1;
                subpass.pColorAttachments = &colorReference;
                subpass.pDepthStencilAttachment = &depthReference;

                // Работать можно только когда пришла картинка
                // (семафор imageAvailable ждёт на COLOR_ATTACHMENT),
                // и до тех пор никто не читает результат.
                VkSubpassDependency dependency{};
                dependency.srcSubpass = VK_SUBPASS_EXTERNAL;
                dependency.dstSubpass = 0;
                dependency.srcStageMask =
                    VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT |
                    VK_PIPELINE_STAGE_EARLY_FRAGMENT_TESTS_BIT;
                dependency.dstStageMask =
                    VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT |
                    VK_PIPELINE_STAGE_EARLY_FRAGMENT_TESTS_BIT;
                dependency.srcAccessMask = 0;
                dependency.dstAccessMask =
                    VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT |
                    VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT;

                const VkAttachmentDescription attachments[2] = {
                    color, depth
                };

                VkRenderPassCreateInfo info{};
                info.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
                info.attachmentCount = 2;
                info.pAttachments = attachments;
                info.subpassCount = 1;
                info.pSubpasses = &subpass;
                info.dependencyCount = 1;
                info.pDependencies = &dependency;

                Check(
                    vkCreateRenderPass(
                        device.Get(), &info, nullptr, &renderPass),
                    "vkCreateRenderPass");
            }

            void RenderTarget::CreateDepth()
            {
                const VkExtent2D extent = swapChain.GetExtent();

                VkImageCreateInfo imageInfo{};
                imageInfo.sType = VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO;
                imageInfo.imageType = VK_IMAGE_TYPE_2D;
                imageInfo.format = depthFormat;
                imageInfo.extent = {
                    extent.width, extent.height, 1
                };
                imageInfo.mipLevels = 1;
                imageInfo.arrayLayers = 1;
                imageInfo.samples = VK_SAMPLE_COUNT_1_BIT;
                imageInfo.tiling = VK_IMAGE_TILING_OPTIMAL;
                imageInfo.usage =
                    VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT;
                imageInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;
                imageInfo.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;

                Check(
                    vkCreateImage(
                        device.Get(), &imageInfo, nullptr, &depthImage),
                    "vkCreateImage (depth)");

                VkMemoryRequirements requirements{};
                vkGetImageMemoryRequirements(
                    device.Get(), depthImage, &requirements);

                VkMemoryAllocateInfo allocateInfo{};
                allocateInfo.sType =
                    VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
                allocateInfo.allocationSize = requirements.size;
                allocateInfo.memoryTypeIndex = FindMemoryType(
                    requirements.memoryTypeBits,
                    VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT);

                Check(
                    vkAllocateMemory(
                        device.Get(), &allocateInfo, nullptr, &depthMemory),
                    "vkAllocateMemory (depth)");

                Check(
                    vkBindImageMemory(
                        device.Get(), depthImage, depthMemory, 0),
                    "vkBindImageMemory");

                VkImageViewCreateInfo viewInfo{};
                viewInfo.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
                viewInfo.image = depthImage;
                viewInfo.viewType = VK_IMAGE_VIEW_TYPE_2D;
                viewInfo.format = depthFormat;
                viewInfo.subresourceRange.aspectMask =
                    VK_IMAGE_ASPECT_DEPTH_BIT;
                viewInfo.subresourceRange.baseMipLevel = 0;
                viewInfo.subresourceRange.levelCount = 1;
                viewInfo.subresourceRange.baseArrayLayer = 0;
                viewInfo.subresourceRange.layerCount = 1;

                Check(
                    vkCreateImageView(
                        device.Get(), &viewInfo, nullptr, &depthView),
                    "vkCreateImageView (depth)");
            }

            void RenderTarget::CreateFramebuffers()
            {
                const Types::u32 imageCount =
                    swapChain.GetImageCount();

                const VkExtent2D extent = swapChain.GetExtent();

                colorViews.resize(imageCount, VK_NULL_HANDLE);
                framebuffers.resize(imageCount, VK_NULL_HANDLE);

                VkImageViewCreateInfo viewInfo{};
                viewInfo.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
                viewInfo.viewType = VK_IMAGE_VIEW_TYPE_2D;
                viewInfo.format = swapChain.GetFormat();
                viewInfo.subresourceRange.aspectMask =
                    VK_IMAGE_ASPECT_COLOR_BIT;
                viewInfo.subresourceRange.baseMipLevel = 0;
                viewInfo.subresourceRange.levelCount = 1;
                viewInfo.subresourceRange.baseArrayLayer = 0;
                viewInfo.subresourceRange.layerCount = 1;

                for (Types::u32 i = 0; i < imageCount; ++i)
                {
                    viewInfo.image = swapChain.GetImage(i);

                    Check(
                        vkCreateImageView(
                            device.Get(), &viewInfo, nullptr, &colorViews[i]),
                        "vkCreateImageView (color)");

                    const VkImageView attachments[2] = {
                        colorViews[i], depthView
                    };

                    VkFramebufferCreateInfo framebufferInfo{};
                    framebufferInfo.sType =
                        VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
                    framebufferInfo.renderPass = renderPass;
                    framebufferInfo.attachmentCount = 2;
                    framebufferInfo.pAttachments = attachments;
                    framebufferInfo.width = extent.width;
                    framebufferInfo.height = extent.height;
                    framebufferInfo.layers = 1;

                    Check(
                        vkCreateFramebuffer(
                            device.Get(),
                            &framebufferInfo,
                            nullptr,
                            &framebuffers[i]),
                        "vkCreateFramebuffer");
                }
            }

            void RenderTarget::Begin(
                VkCommandBuffer commandBuffer,
                Types::u32 imageIndex,
                Types::f32 red,
                Types::f32 green,
                Types::f32 blue,
                Types::f32 alpha
            ) const
            {
                // Содержимое картинки нам не важно (UNDEFINED): кадр
                // перезаписывается целиком. Синхронизация с acquire -
                // через барьер на стадии COLOR_ATTACHMENT (семафор
                // imageAvailable ждёт именно на ней, см. FrameContext).
                VkImageMemoryBarrier barrier{};
                barrier.sType = VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER;
                barrier.srcAccessMask = 0;
                barrier.dstAccessMask =
                    VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;
                barrier.oldLayout = VK_IMAGE_LAYOUT_UNDEFINED;
                barrier.newLayout =
                    VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL;
                barrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
                barrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
                barrier.image = swapChain.GetImage(imageIndex);
                barrier.subresourceRange.aspectMask =
                    VK_IMAGE_ASPECT_COLOR_BIT;
                barrier.subresourceRange.baseMipLevel = 0;
                barrier.subresourceRange.levelCount = 1;
                barrier.subresourceRange.baseArrayLayer = 0;
                barrier.subresourceRange.layerCount = 1;

                vkCmdPipelineBarrier(
                    commandBuffer,
                    VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT,
                    VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
                    0,
                    0, nullptr,
                    0, nullptr,
                    1, &barrier);

                VkClearValue clears[2]{};

                clears[0].color.float32[0] = red;
                clears[0].color.float32[1] = green;
                clears[0].color.float32[2] = blue;
                clears[0].color.float32[3] = alpha;

                // Depth: чем больше Z, тем ближе (диапазон 0..1).
                clears[1].depthStencil.depth = 1.0f;

                const VkExtent2D extent = swapChain.GetExtent();

                VkRenderPassBeginInfo beginInfo{};
                beginInfo.sType =
                    VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
                beginInfo.renderPass = renderPass;
                beginInfo.framebuffer = framebuffers.at(imageIndex);
                beginInfo.renderArea.offset = {0, 0};
                beginInfo.renderArea.extent = extent;
                beginInfo.clearValueCount = 2;
                beginInfo.pClearValues = clears;

                vkCmdBeginRenderPass(
                    commandBuffer, &beginInfo, VK_SUBPASS_CONTENTS_INLINE);
            }

            void RenderTarget::End(VkCommandBuffer commandBuffer) const
            {
                vkCmdEndRenderPass(commandBuffer);
            }

            VkRenderPass RenderTarget::GetRenderPass() const
            {
                return renderPass;
            }

            void RenderTarget::DestroyDepth()
            {
                if (device.Get() == VK_NULL_HANDLE)
                {
                    return;
                }

                if (depthView != VK_NULL_HANDLE)
                {
                    vkDestroyImageView(device.Get(), depthView, nullptr);
                    depthView = VK_NULL_HANDLE;
                }

                if (depthImage != VK_NULL_HANDLE)
                {
                    vkDestroyImage(device.Get(), depthImage, nullptr);
                    depthImage = VK_NULL_HANDLE;
                }

                if (depthMemory != VK_NULL_HANDLE)
                {
                    vkFreeMemory(device.Get(), depthMemory, nullptr);
                    depthMemory = VK_NULL_HANDLE;
                }
            }

            void RenderTarget::DestroyFramebuffers()
            {
                if (device.Get() == VK_NULL_HANDLE)
                {
                    return;
                }

                for (VkFramebuffer framebuffer : framebuffers)
                {
                    if (framebuffer != VK_NULL_HANDLE)
                    {
                        vkDestroyFramebuffer(
                            device.Get(), framebuffer, nullptr);
                    }
                }

                framebuffers.clear();

                for (VkImageView view : colorViews)
                {
                    if (view != VK_NULL_HANDLE)
                    {
                        vkDestroyImageView(device.Get(), view, nullptr);
                    }
                }

                colorViews.clear();
            }

            void RenderTarget::Destroy()
            {
                if (device.Get() == VK_NULL_HANDLE)
                {
                    return;
                }

                vkDeviceWaitIdle(device.Get());

                DestroyFramebuffers();
                DestroyDepth();

                if (renderPass != VK_NULL_HANDLE)
                {
                    vkDestroyRenderPass(
                        device.Get(), renderPass, nullptr);
                    renderPass = VK_NULL_HANDLE;
                }
            }
        }
    }
}
