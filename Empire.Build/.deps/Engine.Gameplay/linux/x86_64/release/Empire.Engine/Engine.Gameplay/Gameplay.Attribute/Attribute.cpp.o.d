{
    files = {
        "Empire.Engine/Engine.Gameplay/Gameplay.Attribute/Attribute.cpp"
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
            "-DENGINE_GAMEPLAY_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Attribute.o:  Empire.Engine/Engine.Gameplay/Gameplay.Attribute/Attribute.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Gameplay/Gameplay.Attribute/Attribute.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Gameplay/Gameplay.hpp\
"
}