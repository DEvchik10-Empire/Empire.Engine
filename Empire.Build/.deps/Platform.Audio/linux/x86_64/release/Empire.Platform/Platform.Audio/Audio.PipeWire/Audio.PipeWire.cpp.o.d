{
    files = {
        "Empire.Platform/Platform.Audio/Audio.PipeWire/Audio.PipeWire.cpp"
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
    depfiles = "Audio.PipeWire.o:  Empire.Platform/Platform.Audio/Audio.PipeWire/Audio.PipeWire.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Audio/Audio.hpp\
"
}