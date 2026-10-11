{
    depfiles = "VkPipeline.o: Engine/Rendering/Empire.Pipeline/Vulkan/VkPipeline.cpp  Engine/Rendering/Empire.Pipeline/Vulkan/VkPipeline.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Device/Vulkan/VkCommon.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/Types.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/VkShader.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Device/Vulkan/VkDevice.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Device/Vulkan/VkInstance.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Mesh/Vulkan/VkMesh.hpp\
",
    depfiles_format = "gcc",
    files = {
        "Engine/Rendering/Empire.Pipeline/Vulkan/VkPipeline.cpp"
    },
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