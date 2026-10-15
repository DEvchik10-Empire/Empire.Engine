{
    files = {
        "Empire.Engine/Engine.GameLoop/GameLoop.cpp"
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
            "-DENGINE_GAMELOOP_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "GameLoop.o: Empire.Engine/Engine.GameLoop/GameLoop.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.GameLoop/GameLoop.hpp\
"
}