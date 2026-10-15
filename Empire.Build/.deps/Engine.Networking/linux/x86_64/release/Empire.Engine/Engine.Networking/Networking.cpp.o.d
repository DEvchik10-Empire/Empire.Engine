{
    files = {
        "Empire.Engine/Engine.Networking/Networking.cpp"
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
            "-DENGINE_NETWORKING_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Networking.o: Empire.Engine/Engine.Networking/Networking.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Networking/Networking.hpp\
"
}