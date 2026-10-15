{
    files = {
        "Empire.Kernel/Kernel.Containers/Containers.cpp"
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
            "-DKERNEL_CONTAINERS_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Containers.o: Empire.Kernel/Kernel.Containers/Containers.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Kernel/Kernel.Containers/Containers.hpp\
"
}