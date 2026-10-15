{
    files = {
        "Empire.Engine/Engine.Jobs/Jobs.cpp"
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
            "-DENGINE_JOBS_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Jobs.o: Empire.Engine/Engine.Jobs/Jobs.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Jobs/Jobs.hpp\
"
}