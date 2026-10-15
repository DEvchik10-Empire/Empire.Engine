{
    files = {
        "Empire.Engine/Engine.Assets/Assets.Loader/Loader.cpp"
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
            "-DENGINE_ASSETS_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Loader.o: Empire.Engine/Engine.Assets/Assets.Loader/Loader.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Assets/Assets.Loader/Loader.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Assets/Assets.hpp\
"
}