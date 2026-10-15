{
    files = {
        "Empire.Graphics/Graphics.Queue/Queue.Vulkan/Queue.Vulkan.cpp"
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
            "-IEmpire.Graphics/Graphics.ThirdParty",
            "-DGRAPHICS_QUEUE_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Queue.Vulkan.o:  Empire.Graphics/Graphics.Queue/Queue.Vulkan/Queue.Vulkan.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Queue/Queue.hpp\
"
}