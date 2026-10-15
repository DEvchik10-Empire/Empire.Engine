{
    files = {
        "Empire.Editor/Editor.Gizmo/Gizmo.cpp"
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
            "-DEDITOR_GIZMO_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Gizmo.o: Empire.Editor/Editor.Gizmo/Gizmo.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Editor/Editor.Gizmo/Gizmo.hpp\
"
}