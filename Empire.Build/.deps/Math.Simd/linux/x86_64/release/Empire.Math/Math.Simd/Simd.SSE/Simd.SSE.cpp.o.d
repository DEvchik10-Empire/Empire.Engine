{
    files = {
        "Empire.Math/Math.Simd/Simd.SSE/Simd.SSE.cpp"
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
    depfiles = "Simd.SSE.o: Empire.Math/Math.Simd/Simd.SSE/Simd.SSE.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Math/Math.Simd/Simd.hpp\
"
}