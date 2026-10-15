{
    files = {
        "Empire.Editor/Editor.Viewport/Viewport.cpp"
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
            "-DEDITOR_VIEWPORT_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Viewport.o: Empire.Editor/Editor.Viewport/Viewport.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Editor/Editor.Viewport/Viewport.hpp\
"
}