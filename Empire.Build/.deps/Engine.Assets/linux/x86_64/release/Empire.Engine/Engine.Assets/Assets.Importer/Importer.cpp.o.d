{
    files = {
        "Empire.Engine/Engine.Assets/Assets.Importer/Importer.cpp"
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
    depfiles = "Importer.o: Empire.Engine/Engine.Assets/Assets.Importer/Importer.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Assets/Assets.Importer/Importer.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Assets/Assets.hpp\
"
}