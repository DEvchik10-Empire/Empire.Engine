{
    files = {
        "Empire.Platform/Platform.Audio/Audio.ALSA/Audio.ALSA.cpp"
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
            "-DPLATFORM_AUDIO_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Audio.ALSA.o: Empire.Platform/Platform.Audio/Audio.ALSA/Audio.ALSA.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Audio/Audio.hpp\
"
}