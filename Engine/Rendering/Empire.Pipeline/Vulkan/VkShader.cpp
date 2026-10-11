#include "VkShader.hpp"

#include <fstream>
#include <stdexcept>
#include <vector>

#include "../../Empire.Device/Vulkan/VkDevice.hpp"

namespace Engine
{
    namespace Rendering
    {
        namespace Vulkan
        {
            ShaderModule::ShaderModule(
                const Device& device,
                const Types::String& path
            )
                : device(device)
            {
                try
                {
                    // .spv - это просто слова по 4 байта, читаем как есть.
                    std::ifstream file(path, std::ios::binary | std::ios::ate);

                    if (!file)
                    {
                        throw std::runtime_error(
                            "Vulkan: shader file not found: " + path);
                    }

                    const std::streamsize size = file.tellg();
                    file.seekg(0, std::ios::beg);

                    if (size <= 0 || (size % 4) != 0)
                    {
                        throw std::runtime_error(
                            "Vulkan: shader file is not valid SPIR-V: " + path);
                    }

                    std::vector<Types::u32> code(
                        static_cast<Types::usize>(size) / 4);

                    if (!file.read(
                            reinterpret_cast<char*>(code.data()), size))
                    {
                        throw std::runtime_error(
                            "Vulkan: failed to read shader file: " + path);
                    }

                    VkShaderModuleCreateInfo info{};
                    info.sType = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
                    info.codeSize = static_cast<Types::usize>(size);
                    info.pCode = code.data();

                    Check(
                        vkCreateShaderModule(
                            device.Get(), &info, nullptr, &handle),
                        "vkCreateShaderModule");
                }
                catch (...)
                {
                    Destroy();
                    throw;
                }
            }

            ShaderModule::~ShaderModule()
            {
                Destroy();
            }

            void ShaderModule::Destroy()
            {
                if (handle != VK_NULL_HANDLE)
                {
                    vkDestroyShaderModule(device.Get(), handle, nullptr);
                    handle = VK_NULL_HANDLE;
                }
            }

            VkShaderModule ShaderModule::Get() const
            {
                return handle;
            }
        }
    }
}
