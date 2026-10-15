{
    files = {
        "Empire.Platform/Platform.Threading/Threading.Linux/Threading.Linux.cpp"
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
            "-DPLATFORM_THREADING_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Threading.Linux.o:  Empire.Platform/Platform.Threading/Threading.Linux/Threading.Linux.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Threading/Threading.hpp\
"
}