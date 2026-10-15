{
    files = {
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Graphics.Adapter/Graphics.Adapter/linux/x86_64/release/Empire.Graphics/Graphics.Adapter/Adapter.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Graphics.Adapter/Graphics.Adapter/linux/x86_64/release/Empire.Graphics/Graphics.Adapter/Adapter.OpenGL/Adapter.OpenGL.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Graphics.Adapter/Graphics.Adapter/linux/x86_64/release/Empire.Graphics/Graphics.Adapter/Adapter.Vulkan/Adapter.Vulkan.cpp.o"
    },
    values = {
        "/usr/bin/g++",
        {
            "-shared",
            "-m64",
            "-fPIC",
            "-L/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/Graphics",
            "-L/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/Kernel",
            "-Wl,-rpath=$ORIGIN/../Kernel",
            "-Wl,-rpath=$ORIGIN/../Math",
            "-Wl,-rpath=$ORIGIN/../Platform",
            "-Wl,-rpath=$ORIGIN/../Graphics",
            "-Wl,-rpath=$ORIGIN/../Engine",
            "-Wl,-rpath=$ORIGIN",
            "-s",
            "-lGraphics.Instance",
            "-lGraphics.Common",
            "-lKernel.Assert",
            "-lKernel.Types"
        }
    }
}