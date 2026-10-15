{
    files = {
        "Empire.Tools/Tools.AssetCompiler/Main.cpp"
    },
    depfiles_format = "gcc",
    values = {
        "/usr/bin/g++",
        {
            "-m64",
            "-fvisibility=hidden",
            "-fvisibility-inlines-hidden",
            "-Wall",
            "-Werror",
            "-O3",
            "-std=c++26",
            "-I/home/devchik10/Documents/Empire.Game.Engine",
            "-DNDEBUG"
        }
    },
    depfiles = "Main.o: Empire.Tools/Tools.AssetCompiler/Main.cpp\
"
}