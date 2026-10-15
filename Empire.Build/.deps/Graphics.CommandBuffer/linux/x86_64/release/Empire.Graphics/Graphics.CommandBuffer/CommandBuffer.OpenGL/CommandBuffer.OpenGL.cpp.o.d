{
    files = {
        "Empire.Graphics/Graphics.CommandBuffer/CommandBuffer.OpenGL/CommandBuffer.OpenGL.cpp"
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
            "-DGRAPHICS_COMMANDBUFFER_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "CommandBuffer.OpenGL.o:  Empire.Graphics/Graphics.CommandBuffer/CommandBuffer.OpenGL/CommandBuffer.OpenGL.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.CommandBuffer/CommandBuffer.hpp\
"
}