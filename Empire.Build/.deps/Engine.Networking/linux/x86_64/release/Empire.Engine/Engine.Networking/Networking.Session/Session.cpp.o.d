{
    files = {
        "Empire.Engine/Engine.Networking/Networking.Session/Session.cpp"
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
    depfiles = "Session.o: Empire.Engine/Engine.Networking/Networking.Session/Session.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Networking/Networking.Session/Session.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Networking/Networking.hpp\
"
}