{
    files = {
        "Empire.Platform/Platform.Input/Input.Legacy/Input.Legacy.cpp"
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
            "-DPLATFORM_INPUT_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Input.Legacy.o:  Empire.Platform/Platform.Input/Input.Legacy/Input.Legacy.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Input/Input.hpp\
"
}