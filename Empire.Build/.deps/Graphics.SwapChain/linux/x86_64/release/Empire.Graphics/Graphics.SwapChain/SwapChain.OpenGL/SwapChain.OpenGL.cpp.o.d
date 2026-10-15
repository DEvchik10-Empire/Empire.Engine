{
    files = {
        "Empire.Graphics/Graphics.SwapChain/SwapChain.OpenGL/SwapChain.OpenGL.cpp"
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
            "-DGRAPHICS_SWAPCHAIN_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "SwapChain.OpenGL.o:  Empire.Graphics/Graphics.SwapChain/SwapChain.OpenGL/SwapChain.OpenGL.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.SwapChain/SwapChain.hpp\
"
}