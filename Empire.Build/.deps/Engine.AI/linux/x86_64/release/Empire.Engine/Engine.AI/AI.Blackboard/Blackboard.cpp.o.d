{
    files = {
        "Empire.Engine/Engine.AI/AI.Blackboard/Blackboard.cpp"
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
    depfiles = "Blackboard.o: Empire.Engine/Engine.AI/AI.Blackboard/Blackboard.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.AI/AI.Blackboard/Blackboard.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.AI/AI.hpp\
"
}