{
    files = {
        "Empire.Engine/Engine.UI/UI.Canvas/Canvas.cpp"
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
            "-DENGINE_UI_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Canvas.o: Empire.Engine/Engine.UI/UI.Canvas/Canvas.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.UI/UI.Canvas/Canvas.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.UI/UI.hpp\
"
}