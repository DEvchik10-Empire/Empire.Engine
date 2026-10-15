{
    files = {
        "Empire.Platform/Platform.Process/Process.Linux/Process.Linux.cpp"
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
            "-DPLATFORM_PROCESS_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Process.Linux.o:  Empire.Platform/Platform.Process/Process.Linux/Process.Linux.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Process/Process.hpp\
"
}