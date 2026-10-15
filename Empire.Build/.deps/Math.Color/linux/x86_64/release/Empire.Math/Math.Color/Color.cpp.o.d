{
    files = {
        "Empire.Math/Math.Color/Color.cpp"
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
            "-DMATH_COLOR_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Color.o: Empire.Math/Math.Color/Color.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Math/Math.Color/Color.hpp\
"
}