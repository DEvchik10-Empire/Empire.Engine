{
    files = {
        "Empire.Graphics/Graphics.Adapter/Adapter.OpenGL/Adapter.OpenGL.cpp"
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
            "-DGRAPHICS_ADAPTER_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Adapter.OpenGL.o:  Empire.Graphics/Graphics.Adapter/Adapter.OpenGL/Adapter.OpenGL.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Adapter/Adapter.hpp\
"
}