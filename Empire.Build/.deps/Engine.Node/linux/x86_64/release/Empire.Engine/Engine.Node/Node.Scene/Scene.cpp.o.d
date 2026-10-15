{
    files = {
        "Empire.Engine/Engine.Node/Node.Scene/Scene.cpp"
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
            "-DENGINE_NODE_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Scene.o: Empire.Engine/Engine.Node/Node.Scene/Scene.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Node/Node.Scene/Scene.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Node/Node.hpp\
"
}