{
    files = {
        "Empire.Editor/Editor.Plugin/Plugin.cpp"
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
            "-DEDITOR_PLUGIN_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Plugin.o: Empire.Editor/Editor.Plugin/Plugin.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Editor/Editor.Plugin/Plugin.hpp\
"
}