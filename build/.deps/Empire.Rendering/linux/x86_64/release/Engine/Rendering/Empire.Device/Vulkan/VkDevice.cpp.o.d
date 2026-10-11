{
    files = {
        "Engine/Rendering/Empire.Device/Vulkan/VkDevice.cpp"
    },
    depfiles_format = "gcc",
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
    depfiles = "VkDevice.o: Engine/Rendering/Empire.Device/Vulkan/VkDevice.cpp  Engine/Rendering/Empire.Device/Vulkan/VkDevice.hpp  Engine/Rendering/Empire.Device/Vulkan/VkCommon.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/Types.hpp  Engine/Rendering/Empire.Device/Vulkan/VkInstance.hpp\
"
}