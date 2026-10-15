{
    files = {
        "Empire.Engine/Engine.Modules/Modules.cpp"
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
            "-DENGINE_MODULES_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Modules.o: Empire.Engine/Engine.Modules/Modules.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Modules/Modules.hpp\
"
}