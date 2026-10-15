{
    files = {
        "Empire.Kernel/Kernel.Config/Config.cpp"
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
            "-DKERNEL_CONFIG_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Config.o: Empire.Kernel/Kernel.Config/Config.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Kernel/Kernel.Config/Config.hpp\
"
}