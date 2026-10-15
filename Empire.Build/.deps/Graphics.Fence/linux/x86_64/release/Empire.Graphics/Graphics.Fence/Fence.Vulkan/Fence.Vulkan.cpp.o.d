{
    files = {
        "Empire.Graphics/Graphics.Fence/Fence.Vulkan/Fence.Vulkan.cpp"
    },
    depfiles_format = "gcc",
    values = {
        "/usr/bin/g++",
        {
            "-m64",
            "-fPIC",
            "-Wall",
            "-Werror",
            "-O3",
            "-std=c++26",
            "-I/home/devchik10/Documents/Empire.Game.Engine",
            "-IEmpire.Graphics/Graphics.ThirdParty",
            "-DGRAPHICS_FENCE_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Fence.Vulkan.o:  Empire.Graphics/Graphics.Fence/Fence.Vulkan/Fence.Vulkan.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Fence/Fence.hpp\
"
}