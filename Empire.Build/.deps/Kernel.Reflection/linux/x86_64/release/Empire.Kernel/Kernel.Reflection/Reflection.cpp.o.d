{
    files = {
        "Empire.Kernel/Kernel.Reflection/Reflection.cpp"
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
            "-DKERNEL_REFLECTION_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Reflection.o: Empire.Kernel/Kernel.Reflection/Reflection.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Kernel/Kernel.Reflection/Reflection.hpp\
"
}