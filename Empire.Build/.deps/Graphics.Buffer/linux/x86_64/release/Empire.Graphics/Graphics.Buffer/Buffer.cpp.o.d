{
    files = {
        "Empire.Graphics/Graphics.Buffer/Buffer.cpp"
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
            "-DGRAPHICS_BUFFER_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Buffer.o: Empire.Graphics/Graphics.Buffer/Buffer.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Buffer/Buffer.hpp\
"
}