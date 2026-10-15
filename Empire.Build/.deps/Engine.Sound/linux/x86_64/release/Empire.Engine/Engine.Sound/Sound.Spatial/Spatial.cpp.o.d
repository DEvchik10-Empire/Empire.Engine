{
    files = {
        "Empire.Engine/Engine.Sound/Sound.Spatial/Spatial.cpp"
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
            "-DENGINE_SOUND_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Spatial.o: Empire.Engine/Engine.Sound/Sound.Spatial/Spatial.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Sound/Sound.Spatial/Spatial.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Sound/Sound.hpp\
"
}