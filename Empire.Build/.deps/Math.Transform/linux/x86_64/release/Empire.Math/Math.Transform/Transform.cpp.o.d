{
    files = {
        "Empire.Math/Math.Transform/Transform.cpp"
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
            "-DMATH_TRANSFORM_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Transform.o: Empire.Math/Math.Transform/Transform.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Math/Math.Transform/Transform.hpp\
"
}