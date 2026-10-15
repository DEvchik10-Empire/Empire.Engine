{
    files = {
        "Empire.Platform/Platform.Library/Library.cpp"
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
            "-DPLATFORM_LIBRARY_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Library.o: Empire.Platform/Platform.Library/Library.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Library/Library.hpp\
"
}