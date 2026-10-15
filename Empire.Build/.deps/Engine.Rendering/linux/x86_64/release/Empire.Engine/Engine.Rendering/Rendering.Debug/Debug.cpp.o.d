{
    files = {
        "Empire.Engine/Engine.Rendering/Rendering.Debug/Debug.cpp"
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
            "-DENGINE_RENDERING_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Debug.o: Empire.Engine/Engine.Rendering/Rendering.Debug/Debug.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Rendering/Rendering.Debug/Debug.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Rendering/Rendering.hpp\
"
}