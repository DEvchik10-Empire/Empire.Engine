#include "VkPipeline.hpp"

#include <stdexcept>
#include <vector>

#include "../../Empire.Device/Vulkan/VkDevice.hpp"
#include "../../Empire.Mesh/Vulkan/VkMesh.hpp"

namespace Engine
{
    namespace Rendering
    {
        namespace Vulkan
        {
            Pipeline::Pipeline(
                const Device& device,
                VkRenderPass renderPass,
                const PipelineConfig& config
            )
                : device(device)
            {
                try
                {
                    // ---------------------------------------------------------
                    // Pipeline layout: только push-константы.
                    // ---------------------------------------------------------
                    VkPushConstantRange pushRange{};
                    pushRange.stageFlags =
                        VK_SHADER_STAGE_VERTEX_BIT |
                        VK_SHADER_STAGE_FRAGMENT_BIT;
                    pushRange.offset = 0;
                    pushRange.size = MaxPushConstants;

                    VkPipelineLayoutCreateInfo layoutInfo{};
                    layoutInfo.sType =
                        VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO;
                    layoutInfo.pushConstantRangeCount = 1;
                    layoutInfo.pPushConstantRanges = &pushRange;

                    Check(
                        vkCreatePipelineLayout(
                            device.Get(), &layoutInfo, nullptr, &layout),
                        "vkCreatePipelineLayout");

                    // Шейдеры живут только внутри конструктора: после
                    // vkCreateGraphicsPipelines модули больше не нужны.
                    ShaderModule vertexModule(
                        device, config.vertexShaderPath);

                    ShaderModule fragmentModule(
                        device, config.fragmentShaderPath);

                    VkPipelineShaderStageCreateInfo stages[2]{};

                    stages[0].sType =
                        VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
                    stages[0].stage = VK_SHADER_STAGE_VERTEX_BIT;
                    stages[0].module = vertexModule.Get();
                    stages[0].pName = "mainVS";

                    stages[1].sType =
                        VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
                    stages[1].stage = VK_SHADER_STAGE_FRAGMENT_BIT;
                    stages[1].module = fragmentModule.Get();
                    stages[1].pName = "mainPS";

                    // ---------------------------------------------------------
                    // Вершинный ввод: один байндинг { position, normal }.
                    // ---------------------------------------------------------
                    VkVertexInputBindingDescription binding{};
                    binding.binding = 0;
                    binding.stride = sizeof(Vertex);
                    binding.inputRate = VK_VERTEX_INPUT_RATE_VERTEX;

                    VkVertexInputAttributeDescription attributes[2]{};

                    attributes[0].location = 0;
                    attributes[0].binding = 0;
                    attributes[0].format = VK_FORMAT_R32G32B32_SFLOAT;
                    attributes[0].offset = offsetof(Vertex, position);

                    attributes[1].location = 1;
                    attributes[1].binding = 0;
                    attributes[1].format = VK_FORMAT_R32G32B32_SFLOAT;
                    attributes[1].offset = offsetof(Vertex, normal);

                    VkPipelineVertexInputStateCreateInfo vertexInput{};
                    vertexInput.sType =
                        VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;

                    if (config.hasVertexLayout)
                    {
                        vertexInput.vertexBindingDescriptionCount = 1;
                        vertexInput.pVertexBindingDescriptions = &binding;
                        vertexInput.vertexAttributeDescriptionCount = 2;
                        vertexInput.pVertexAttributeDescriptions = attributes;
                    }

                    VkPipelineInputAssemblyStateCreateInfo assembly{};
                    assembly.sType =
                        VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;
                    assembly.topology = VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST;

                    VkPipelineViewportStateCreateInfo viewport{};
                    viewport.sType =
                        VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO;
                    viewport.viewportCount = 1;
                    viewport.scissorCount = 1;

                    VkPipelineRasterizationStateCreateInfo raster{};
                    raster.sType =
                        VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO;
                    raster.polygonMode = VK_POLYGON_MODE_FILL;
                    raster.cullMode = config.cullMode;
                    raster.frontFace = VK_FRONT_FACE_COUNTER_CLOCKWISE;
                    raster.lineWidth = 1.0f;

                    VkPipelineMultisampleStateCreateInfo multisample{};
                    multisample.sType =
                        VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;
                    multisample.rasterizationSamples = VK_SAMPLE_COUNT_1_BIT;

                    VkPipelineDepthStencilStateCreateInfo depth{};
                    depth.sType =
                        VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO;
                    depth.depthTestEnable =
                        config.depthTest ? VK_TRUE : VK_FALSE;
                    depth.depthWriteEnable =
                        config.depthWrite ? VK_TRUE : VK_FALSE;
                    depth.depthCompareOp = VK_COMPARE_OP_LESS_OR_EQUAL;

                    VkPipelineColorBlendAttachmentState blendAttachment{};
                    blendAttachment.colorWriteMask =
                        VK_COLOR_COMPONENT_R_BIT |
                        VK_COLOR_COMPONENT_G_BIT |
                        VK_COLOR_COMPONENT_B_BIT |
                        VK_COLOR_COMPONENT_A_BIT;
                    blendAttachment.blendEnable = VK_FALSE;

                    VkPipelineColorBlendStateCreateInfo blend{};
                    blend.sType =
                        VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;
                    blend.attachmentCount = 1;
                    blend.pAttachments = &blendAttachment;

                    const VkDynamicState dynamicStates[2] = {
                        VK_DYNAMIC_STATE_VIEWPORT,
                        VK_DYNAMIC_STATE_SCISSOR
                    };

                    VkPipelineDynamicStateCreateInfo dynamic{};
                    dynamic.sType =
                        VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO;
                    dynamic.dynamicStateCount = 2;
                    dynamic.pDynamicStates = dynamicStates;

                    VkGraphicsPipelineCreateInfo info{};
                    info.sType =
                        VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO;
                    info.stageCount = 2;
                    info.pStages = stages;
                    info.pVertexInputState = &vertexInput;
                    info.pInputAssemblyState = &assembly;
                    info.pViewportState = &viewport;
                    info.pRasterizationState = &raster;
                    info.pMultisampleState = &multisample;
                    info.pDepthStencilState = &depth;
                    info.pColorBlendState = &blend;
                    info.pDynamicState = &dynamic;
                    info.layout = layout;
                    info.renderPass = renderPass;
                    info.subpass = 0;

                    Check(
                        vkCreateGraphicsPipelines(
                            device.Get(),
                            VK_NULL_HANDLE,
                            1,
                            &info,
                            nullptr,
                            &handle),
                        "vkCreateGraphicsPipelines");
                }
                catch (...)
                {
                    Destroy();
                    throw;
                }
            }

            Pipeline::~Pipeline()
            {
                Destroy();
            }

            void Pipeline::Destroy()
            {
                if (device.Get() == VK_NULL_HANDLE)
                {
                    return;
                }

                if (handle != VK_NULL_HANDLE)
                {
                    vkDestroyPipeline(device.Get(), handle, nullptr);
                    handle = VK_NULL_HANDLE;
                }

                if (layout != VK_NULL_HANDLE)
                {
                    vkDestroyPipelineLayout(device.Get(), layout, nullptr);
                    layout = VK_NULL_HANDLE;
                }
            }

            void Pipeline::Bind(
                VkCommandBuffer commandBuffer,
                VkExtent2D extent
            ) const
            {
                vkCmdBindPipeline(
                    commandBuffer,
                    VK_PIPELINE_BIND_POINT_GRAPHICS,
                    handle);

                VkViewport viewport{};
                viewport.x = 0.0f;
                viewport.y = 0.0f;
                viewport.width = static_cast<Types::f32>(extent.width);
                viewport.height = static_cast<Types::f32>(extent.height);
                viewport.minDepth = 0.0f;
                viewport.maxDepth = 1.0f;

                vkCmdSetViewport(commandBuffer, 0, 1, &viewport);

                VkRect2D scissor{};
                scissor.offset = {0, 0};
                scissor.extent = extent;

                vkCmdSetScissor(commandBuffer, 0, 1, &scissor);
            }

            void Pipeline::PushConstants(
                VkCommandBuffer commandBuffer,
                const void* data,
                Types::u32 size
            ) const
            {
                if (size == 0 || size > MaxPushConstants)
                {
                    throw std::runtime_error(
                        "Vulkan: push constants size is out of range");
                }

                vkCmdPushConstants(
                    commandBuffer,
                    layout,
                    VK_SHADER_STAGE_VERTEX_BIT |
                        VK_SHADER_STAGE_FRAGMENT_BIT,
                    0,
                    size,
                    data);
            }

            VkPipeline Pipeline::Get() const
            {
                return handle;
            }

            VkPipelineLayout Pipeline::GetLayout() const
            {
                return layout;
            }
        }
    }
}
