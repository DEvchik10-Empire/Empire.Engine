{
    files = {
        "Empire.Engine/Engine.Scripting/Scripting.Lua/Lua.cpp"
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
    depfiles = "Lua.o: Empire.Engine/Engine.Scripting/Scripting.Lua/Lua.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Scripting/Scripting.Lua/Lua.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Scripting/Scripting.hpp\
"
}