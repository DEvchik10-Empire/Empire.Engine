{
    files = {
        "Empire.Engine/Engine.GameLoop/GameLoop.FixedStep/FixedStep.cpp"
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
    depfiles = "FixedStep.o:  Empire.Engine/Engine.GameLoop/GameLoop.FixedStep/FixedStep.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.GameLoop/GameLoop.FixedStep/FixedStep.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.GameLoop/GameLoop.hpp\
"
}