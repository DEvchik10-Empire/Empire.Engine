{
    files = {
        "Empire.Kernel/Kernel.Memory/Memory.cpp"
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
            "-DKERNEL_MEMORY_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Memory.o: Empire.Kernel/Kernel.Memory/Memory.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Kernel/Kernel.Memory/Memory.hpp\
"
}