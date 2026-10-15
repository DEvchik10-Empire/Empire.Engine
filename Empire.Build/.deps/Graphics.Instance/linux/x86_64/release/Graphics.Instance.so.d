{
    files = {
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Graphics.Instance/Graphics.Instance/linux/x86_64/release/Empire.Graphics/Graphics.Instance/Instance.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Graphics.Instance/Graphics.Instance/linux/x86_64/release/Empire.Graphics/Graphics.Instance/Instance.OpenGL/Instance.OpenGL.cpp.o",
        "/home/devchik10/Documents/Empire.Game.Engine/Empire.Build/Build.Linux.Release/.Obj/Graphics.Instance/Graphics.Instance/linux/x86_64/release/Empire.Graphics/Graphics.Instance/Instance.Vulkan/Instance.Vulkan.cpp.o"
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
            "-lGraphics.Common",
            "-lKernel.Assert",
            "-lKernel.Types"
        }
    }
}