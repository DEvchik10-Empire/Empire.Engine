{
    files = {
        "Empire.Graphics/Graphics.Queue/Queue.OpenGL/Queue.OpenGL.cpp"
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
            "-DGRAPHICS_QUEUE_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Queue.OpenGL.o:  Empire.Graphics/Graphics.Queue/Queue.OpenGL/Queue.OpenGL.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Queue/Queue.hpp\
"
}