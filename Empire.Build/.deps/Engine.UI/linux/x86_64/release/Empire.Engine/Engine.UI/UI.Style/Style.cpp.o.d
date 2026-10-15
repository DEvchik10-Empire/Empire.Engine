{
    files = {
        "Empire.Engine/Engine.UI/UI.Style/Style.cpp"
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
    depfiles = "Style.o: Empire.Engine/Engine.UI/UI.Style/Style.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.UI/UI.Style/Style.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.UI/UI.hpp\
"
}