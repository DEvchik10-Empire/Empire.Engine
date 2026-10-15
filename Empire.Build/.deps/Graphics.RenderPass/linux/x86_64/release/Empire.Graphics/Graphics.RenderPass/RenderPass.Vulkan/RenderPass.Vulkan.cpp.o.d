{
    files = {
        "Empire.Graphics/Graphics.RenderPass/RenderPass.Vulkan/RenderPass.Vulkan.cpp"
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
            "-DGRAPHICS_RENDERPASS_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "RenderPass.Vulkan.o:  Empire.Graphics/Graphics.RenderPass/RenderPass.Vulkan/RenderPass.Vulkan.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.RenderPass/RenderPass.hpp\
"
}