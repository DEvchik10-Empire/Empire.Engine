{
    files = {
        "Empire.Graphics/Graphics.Semaphore/Semaphore.Vulkan/Semaphore.Vulkan.cpp"
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
            "-DGRAPHICS_SEMAPHORE_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Semaphore.Vulkan.o:  Empire.Graphics/Graphics.Semaphore/Semaphore.Vulkan/Semaphore.Vulkan.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Semaphore/Semaphore.hpp\
"
}