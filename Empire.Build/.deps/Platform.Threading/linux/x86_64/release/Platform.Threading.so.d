{
    files = {
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Platform.Threading/Platform.Threading/linux/x86_64/release/Empire.Platform/Platform.Threading/Threading.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Platform.Threading/Platform.Threading/linux/x86_64/release/Empire.Platform/Platform.Threading/Threading.Linux/Threading.Linux.cpp.o"
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
            "-lKernel.Memory",
            "-lKernel.Assert",
            "-lKernel.Types"
        }
    }
}