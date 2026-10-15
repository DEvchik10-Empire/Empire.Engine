{
    files = {
        "Empire.Engine/Engine.Application/Application.Lifecycle/Lifecycle.cpp"
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
            "-DENGINE_APPLICATION_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Lifecycle.o:  Empire.Engine/Engine.Application/Application.Lifecycle/Lifecycle.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Application/Application.Lifecycle/Lifecycle.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Application/Application.hpp\
"
}