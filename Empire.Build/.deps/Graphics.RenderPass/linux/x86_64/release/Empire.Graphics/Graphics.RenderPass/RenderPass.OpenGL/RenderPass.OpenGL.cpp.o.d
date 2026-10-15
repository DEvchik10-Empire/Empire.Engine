{
    files = {
        "Empire.Graphics/Graphics.RenderPass/RenderPass.OpenGL/RenderPass.OpenGL.cpp"
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
    depfiles = "RenderPass.OpenGL.o:  Empire.Graphics/Graphics.RenderPass/RenderPass.OpenGL/RenderPass.OpenGL.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.RenderPass/RenderPass.hpp\
"
}