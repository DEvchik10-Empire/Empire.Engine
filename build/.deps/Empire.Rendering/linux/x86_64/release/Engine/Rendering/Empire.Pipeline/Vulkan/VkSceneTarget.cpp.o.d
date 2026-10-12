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
    depfiles = "VkSceneTarget.o:  Engine/Rendering/Empire.Pipeline/Vulkan/VkSceneTarget.cpp  Engine/Rendering/Empire.Pipeline/Vulkan/VkSceneTarget.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Device/Vulkan/VkCommon.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/Types.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Device/Vulkan/VkDevice.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Device/Vulkan/VkInstance.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.SwapChain/Vulkan/VkSwapChain.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.SwapChain/Vulkan/VkSurface.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/NativeWindowHandle.hpp  Engine/Rendering/Empire.Pipeline/Vulkan/../../Empire.Texture/Vulkan/VkDepthImage.hpp\
",
    files = {
        "Engine/Rendering/Empire.Pipeline/Vulkan/VkSceneTarget.cpp"
    }
}