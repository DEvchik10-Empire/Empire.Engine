{
    files = {
        "Empire.Math/Math.Geometry/Geometry.cpp"
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
            "-DMATH_GEOMETRY_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Geometry.o: Empire.Math/Math.Geometry/Geometry.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Math/Math.Geometry/Geometry.hpp\
"
}