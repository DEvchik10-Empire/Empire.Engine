{
    files = {
        "Empire.Math/Math.Vector/Vector.cpp"
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
            "-DMATH_VECTOR_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Vector.o: Empire.Math/Math.Vector/Vector.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Math/Math.Vector/Vector.hpp\
"
}