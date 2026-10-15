{
    files = {
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Math.Geometry/Math.Geometry/linux/x86_64/release/Empire.Math/Math.Geometry/Geometry.cpp.o"
    },
    values = {
        "/usr/bin/g++",
        {
            "-shared",
            "-m64",
            "-fPIC",
            "-L/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/Math",
            "-L/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/Kernel",
            "-Wl,-rpath=$ORIGIN/../Kernel",
            "-Wl,-rpath=$ORIGIN/../Math",
            "-Wl,-rpath=$ORIGIN/../Platform",
            "-Wl,-rpath=$ORIGIN/../Graphics",
            "-Wl,-rpath=$ORIGIN/../Engine",
            "-Wl,-rpath=$ORIGIN",
            "-s",
            "-lMath.Vector",
            "-lMath.Simd",
            "-lKernel.Assert",
            "-lKernel.Types"
        }
    }
}