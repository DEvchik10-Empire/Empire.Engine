{
    files = {
        "Empire.Platform/Platform.Network/Network.cpp"
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
    depfiles = "Network.o: Empire.Platform/Platform.Network/Network.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Network/Network.hpp\
"
}