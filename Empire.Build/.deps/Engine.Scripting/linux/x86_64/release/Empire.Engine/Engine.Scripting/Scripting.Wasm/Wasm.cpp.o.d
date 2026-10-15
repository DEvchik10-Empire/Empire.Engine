{
    files = {
        "Empire.Engine/Engine.Scripting/Scripting.Wasm/Wasm.cpp"
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
    depfiles = "Wasm.o: Empire.Engine/Engine.Scripting/Scripting.Wasm/Wasm.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Scripting/Scripting.Wasm/Wasm.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Scripting/Scripting.hpp\
"
}