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
    files = {
        "Engine/Rendering/Empire.Pipeline/Vulkan/VkShader.cpp"
    },
    depfiles_format = "gcc",
    depfiles = "VkShader.o: Engine/Rendering/Empire.Pipeline/Vulkan/VkShader.cpp  Engine/Rendering/Empire.Pipeline/Vulkan/VkShader.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Device/Vulkan/VkCommon.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/Types.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Device/Vulkan/VkDevice.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Device/Vulkan/VkInstance.hpp\
"
}