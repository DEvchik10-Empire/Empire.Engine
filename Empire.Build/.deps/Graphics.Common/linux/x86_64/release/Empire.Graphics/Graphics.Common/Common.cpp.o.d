{
    files = {
        "Empire.Graphics/Graphics.Common/Common.cpp"
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
            "-DGRAPHICS_COMMON_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Common.o: Empire.Graphics/Graphics.Common/Common.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Common/Common.hpp\
"
}