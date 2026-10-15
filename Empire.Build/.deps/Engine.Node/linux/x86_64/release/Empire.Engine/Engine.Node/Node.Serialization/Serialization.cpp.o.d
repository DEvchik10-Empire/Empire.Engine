{
    files = {
        "Empire.Engine/Engine.Node/Node.Serialization/Serialization.cpp"
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
    depfiles = "Serialization.o:  Empire.Engine/Engine.Node/Node.Serialization/Serialization.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Node/Node.Serialization/Serialization.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Node/Node.hpp\
"
}