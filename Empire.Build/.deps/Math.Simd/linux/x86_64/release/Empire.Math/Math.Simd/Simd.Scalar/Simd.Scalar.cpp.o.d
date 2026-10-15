{
    files = {
        "Empire.Math/Math.Simd/Simd.Scalar/Simd.Scalar.cpp"
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
            "-DMATH_SIMD_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Simd.Scalar.o: Empire.Math/Math.Simd/Simd.Scalar/Simd.Scalar.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Math/Math.Simd/Simd.hpp\
"
}