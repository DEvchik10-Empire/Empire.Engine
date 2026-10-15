{
    files = {
        "Empire.Engine/Engine.AI/AI.cpp"
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
            "-DENGINE_AI_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "AI.o: Empire.Engine/Engine.AI/AI.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.AI/AI.hpp\
"
}