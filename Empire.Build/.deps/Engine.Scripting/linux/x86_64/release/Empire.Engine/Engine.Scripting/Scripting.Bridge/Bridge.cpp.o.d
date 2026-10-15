{
    files = {
        "Empire.Engine/Engine.Scripting/Scripting.Bridge/Bridge.cpp"
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
            "-DENGINE_SCRIPTING_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Bridge.o: Empire.Engine/Engine.Scripting/Scripting.Bridge/Bridge.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Scripting/Scripting.Bridge/Bridge.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Scripting/Scripting.hpp\
"
}