{
    files = {
        "Empire.Platform/Platform.Network/Network.Linux/Network.Linux.cpp"
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
            "-DPLATFORM_NETWORK_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Network.Linux.o:  Empire.Platform/Platform.Network/Network.Linux/Network.Linux.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Network/Network.hpp\
"
}