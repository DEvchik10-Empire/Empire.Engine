{
    files = {
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Platform.Clipboard/Platform.Clipboard/linux/x86_64/release/Empire.Platform/Platform.Clipboard/Clipboard.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Platform.Clipboard/Platform.Clipboard/linux/x86_64/release/Empire.Platform/Platform.Clipboard/Clipboard.Legacy/Clipboard.Legacy.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Platform.Clipboard/Platform.Clipboard/linux/x86_64/release/Empire.Platform/Platform.Clipboard/Clipboard.Wayland/Clipboard.Wayland.cpp.o"
    },
    values = {
        "/usr/bin/g++",
        {
            "-shared",
            "-m64",
            "-fPIC",
            "-L/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/Platform",
            "-L/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/Kernel",
            "-Wl,-rpath=$ORIGIN/../Kernel",
            "-Wl,-rpath=$ORIGIN/../Math",
            "-Wl,-rpath=$ORIGIN/../Platform",
            "-Wl,-rpath=$ORIGIN/../Graphics",
            "-Wl,-rpath=$ORIGIN/../Engine",
            "-Wl,-rpath=$ORIGIN",
            "-s",
            "-lPlatform.App",
            "-lKernel.Memory",
            "-lKernel.Assert",
            "-lKernel.Types"
        }
    }
}