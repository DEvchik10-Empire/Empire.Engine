{
    files = {
        "Empire.Platform/Platform.FileSystem/FileSystem.Linux/FileSystem.Linux.cpp"
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
            "-DPLATFORM_FILESYSTEM_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "FileSystem.Linux.o:  Empire.Platform/Platform.FileSystem/FileSystem.Linux/FileSystem.Linux.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.FileSystem/FileSystem.hpp\
"
}