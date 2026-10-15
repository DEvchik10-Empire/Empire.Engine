{
    files = {
        "Empire.Engine/Engine.Physics/Physics.Query/Query.cpp"
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
            "-DENGINE_PHYSICS_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Query.o: Empire.Engine/Engine.Physics/Physics.Query/Query.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Physics/Physics.Query/Query.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Physics/Physics.hpp\
"
}