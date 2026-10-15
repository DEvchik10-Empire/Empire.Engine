{
    files = {
        "Empire.Engine/Engine.Node/Node.Hierarchy/Hierarchy.cpp"
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
    depfiles = "Hierarchy.o: Empire.Engine/Engine.Node/Node.Hierarchy/Hierarchy.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Node/Node.Hierarchy/Hierarchy.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Node/Node.hpp\
"
}