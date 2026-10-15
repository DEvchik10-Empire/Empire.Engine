{
    files = {
        "Empire.Engine/Engine.Animation/Animation.Curve/Curve.cpp"
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
            "-DENGINE_ANIMATION_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Curve.o: Empire.Engine/Engine.Animation/Animation.Curve/Curve.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Animation/Animation.Curve/Curve.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Animation/Animation.hpp\
"
}