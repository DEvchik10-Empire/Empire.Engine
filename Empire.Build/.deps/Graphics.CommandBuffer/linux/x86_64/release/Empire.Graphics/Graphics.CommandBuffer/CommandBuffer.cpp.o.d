{
    files = {
        "Empire.Graphics/Graphics.CommandBuffer/CommandBuffer.cpp"
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
    depfiles = "CommandBuffer.o: Empire.Graphics/Graphics.CommandBuffer/CommandBuffer.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.CommandBuffer/CommandBuffer.hpp\
"
}