{
    files = {
        "Empire.Platform/Platform.Monitor/Monitor.Wayland/Monitor.Wayland.cpp"
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
            "-DPLATFORM_MONITOR_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Monitor.Wayland.o:  Empire.Platform/Platform.Monitor/Monitor.Wayland/Monitor.Wayland.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Monitor/Monitor.hpp\
"
}