{
    files = {
        "Empire.Platform/Platform.Time/Time.Linux/Time.Linux.cpp"
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
            "-DPLATFORM_TIME_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Time.Linux.o: Empire.Platform/Platform.Time/Time.Linux/Time.Linux.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Time/Time.hpp\
"
}