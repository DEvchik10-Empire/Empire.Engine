{
    files = {
        "Empire.Engine/Engine.Input/Input.Binding/Binding.cpp"
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
            "-DENGINE_INPUT_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Binding.o: Empire.Engine/Engine.Input/Input.Binding/Binding.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Input/Input.Binding/Binding.hpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Engine/Engine.Input/Input.hpp\
"
}