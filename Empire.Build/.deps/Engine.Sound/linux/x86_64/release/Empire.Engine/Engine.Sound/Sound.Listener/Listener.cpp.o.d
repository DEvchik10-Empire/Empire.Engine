{
    files = {
        "Empire.Engine/Engine.Sound/Sound.Listener/Listener.cpp"
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
    depfiles = "Listener.o: Empire.Engine/Engine.Sound/Sound.Listener/Listener.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Sound/Sound.Listener/Listener.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Sound/Sound.hpp\
"
}