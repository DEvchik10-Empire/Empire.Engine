{
    files = {
        "Empire.Editor/Editor.Panel/Panel.cpp"
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
            "-DEDITOR_PANEL_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Panel.o: Empire.Editor/Editor.Panel/Panel.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Editor/Editor.Panel/Panel.hpp\
"
}