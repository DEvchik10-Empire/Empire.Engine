{
    files = {
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Math.Transform/Math.Transform/linux/x86_64/release/Empire.Math/Math.Transform/Transform.cpp.o"
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
            "-lMath.Quaternion",
            "-lMath.Matrix",
            "-lMath.Vector",
            "-lMath.Simd",
            "-lKernel.Assert",
            "-lKernel.Types"
        }
    }
}