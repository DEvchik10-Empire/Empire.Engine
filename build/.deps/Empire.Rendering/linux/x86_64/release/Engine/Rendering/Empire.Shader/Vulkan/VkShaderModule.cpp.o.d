{
    values = {
        "/usr/bin/g++",
        {
            "-m64",
            "-fvisibility=hidden",
            "-fvisibility-inlines-hidden",
            "-O3",
            "-std=c++26",
            "-I/home/devchik10/Documents/Empire.Engine",
            "-I/home/devchik10/Documents/Empire.Engine/Engine/Rendering",
            "-DNDEBUG"
        }
    },
    depfiles_format = "gcc",
    depfiles = "VkShaderModule.o:  Engine/Rendering/Empire.Shader/Vulkan/VkShaderModule.cpp  Engine/Rendering/Empire.Shader/Vulkan/VkShaderModule.hpp  Engine/Rendering/Empire.Shader/Vulkan/../../Empire.Device/Vulkan/VkCommon.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/Types.hpp  Engine/Rendering/Empire.Shader/Vulkan/../../Empire.Device/Vulkan/VkDevice.hpp  Engine/Rendering/Empire.Shader/Vulkan/../../Empire.Device/Vulkan/VkInstance.hpp\
",
    files = {
        "Engine/Rendering/Empire.Shader/Vulkan/VkShaderModule.cpp"
    }
}