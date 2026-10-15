{
    files = {
        "Empire.Math/Math.Random/Random.cpp"
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
            "-DMATH_RANDOM_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Random.o: Empire.Math/Math.Random/Random.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Math/Math.Random/Random.hpp\
"
}