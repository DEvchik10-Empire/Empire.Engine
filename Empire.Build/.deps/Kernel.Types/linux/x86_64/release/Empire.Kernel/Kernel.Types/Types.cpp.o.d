{
    files = {
        "Empire.Kernel/Kernel.Types/Types.cpp"
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
            "-DKERNEL_TYPES_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Types.o: Empire.Kernel/Kernel.Types/Types.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Kernel/Kernel.Types/Types.hpp\
"
}