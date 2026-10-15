{
    files = {
        "Empire.Kernel/Kernel.Logging/Logging.cpp"
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
            "-DKERNEL_LOGGING_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Logging.o: Empire.Kernel/Kernel.Logging/Logging.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Kernel/Kernel.Logging/Logging.hpp\
"
}