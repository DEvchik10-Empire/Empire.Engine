{
    files = {
        "Empire.Engine/Engine.Diagnostics/Diagnostics.cpp"
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
            "-DENGINE_DIAGNOSTICS_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Diagnostics.o: Empire.Engine/Engine.Diagnostics/Diagnostics.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Diagnostics/Diagnostics.hpp\
"
}