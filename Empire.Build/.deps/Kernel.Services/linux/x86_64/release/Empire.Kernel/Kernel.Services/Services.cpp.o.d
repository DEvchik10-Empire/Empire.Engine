{
    files = {
        "Empire.Kernel/Kernel.Services/Services.cpp"
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
            "-DKERNEL_SERVICES_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Services.o: Empire.Kernel/Kernel.Services/Services.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Kernel/Kernel.Services/Services.hpp\
"
}