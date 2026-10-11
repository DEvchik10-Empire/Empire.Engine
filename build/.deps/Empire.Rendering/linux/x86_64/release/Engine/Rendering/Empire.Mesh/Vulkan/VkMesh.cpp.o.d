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
        "Engine/Rendering/Empire.Mesh/Vulkan/VkMesh.cpp"
    },
    depfiles_format = "gcc",
    depfiles = "VkMesh.o: Engine/Rendering/Empire.Mesh/Vulkan/VkMesh.cpp  Engine/Rendering/Empire.Mesh/Vulkan/VkMesh.hpp  Engine/Rendering/Empire.Mesh/Vulkan/../../Empire.Device/Vulkan/VkCommon.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/Types.hpp  Engine/Rendering/Empire.Mesh/Vulkan/../../Empire.Device/Vulkan/VkDevice.hpp  Engine/Rendering/Empire.Mesh/Vulkan/../../Empire.Device/Vulkan/VkInstance.hpp\
"
}