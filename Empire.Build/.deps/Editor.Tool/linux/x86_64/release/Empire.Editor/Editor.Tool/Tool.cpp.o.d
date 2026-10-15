{
    files = {
        "Empire.Editor/Editor.Tool/Tool.cpp"
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
            "-DEDITOR_TOOL_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Tool.o: Empire.Editor/Editor.Tool/Tool.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Editor/Editor.Tool/Tool.hpp\
"
}