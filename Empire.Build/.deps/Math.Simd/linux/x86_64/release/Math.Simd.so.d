{
    files = {
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Math.Simd/Math.Simd/linux/x86_64/release/Empire.Math/Math.Simd/Simd.AVX/Simd.AVX.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Math.Simd/Math.Simd/linux/x86_64/release/Empire.Math/Math.Simd/Simd.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Math.Simd/Math.Simd/linux/x86_64/release/Empire.Math/Math.Simd/Simd.Scalar/Simd.Scalar.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Math.Simd/Math.Simd/linux/x86_64/release/Empire.Math/Math.Simd/Simd.SSE/Simd.SSE.cpp.o"
    },
    values = {
        "/usr/bin/g++",
        {
            "-shared",
            "-m64",
            "-fPIC",
            "-L/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/Kernel",
            "-Wl,-rpath=$ORIGIN/../Kernel",
            "-Wl,-rpath=$ORIGIN/../Math",
            "-Wl,-rpath=$ORIGIN/../Platform",
            "-Wl,-rpath=$ORIGIN/../Graphics",
            "-Wl,-rpath=$ORIGIN/../Engine",
            "-Wl,-rpath=$ORIGIN",
            "-s",
            "-lKernel.Assert",
            "-lKernel.Types"
        }
    }
}