{
    files = {
        "Engine/Rendering/Empire.Texture/Vulkan/VkDepthImage.cpp"
    },
    depfiles_format = "gcc",
    depfiles = "VkDepthImage.o: Engine/Rendering/Empire.Texture/Vulkan/VkDepthImage.cpp  Engine/Rendering/Empire.Texture/Vulkan/VkDepthImage.hpp  Engine/Rendering/Empire.Texture/Vulkan/../../Empire.Device/Vulkan/VkCommon.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/Types.hpp  Engine/Rendering/Empire.Texture/Vulkan/../../Empire.Device/Vulkan/VkDevice.hpp  Engine/Rendering/Empire.Texture/Vulkan/../../Empire.Device/Vulkan/VkInstance.hpp\
",
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
    }
}