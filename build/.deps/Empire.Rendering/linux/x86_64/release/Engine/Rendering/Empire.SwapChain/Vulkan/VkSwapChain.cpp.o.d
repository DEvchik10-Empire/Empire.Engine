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
    depfiles = "VkSwapChain.o: Engine/Rendering/Empire.SwapChain/Vulkan/VkSwapChain.cpp  Engine/Rendering/Empire.SwapChain/Vulkan/VkSwapChain.hpp  Engine/Rendering/Empire.SwapChain/Vulkan/../../Empire.Device/Vulkan/VkCommon.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/Types.hpp  Engine/Rendering/Empire.SwapChain/Vulkan/../../Empire.Device/Vulkan/VkDevice.hpp  Engine/Rendering/Empire.SwapChain/Vulkan/../../Empire.Device/Vulkan/VkInstance.hpp  Engine/Rendering/Empire.SwapChain/Vulkan/VkSurface.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/NativeWindowHandle.hpp\
",
    files = {
        "Engine/Rendering/Empire.SwapChain/Vulkan/VkSwapChain.cpp"
    }
}