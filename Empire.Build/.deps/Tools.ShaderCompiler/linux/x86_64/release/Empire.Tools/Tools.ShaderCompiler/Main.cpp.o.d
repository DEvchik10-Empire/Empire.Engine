{
    files = {
        "Empire.Tools/Tools.ShaderCompiler/Main.cpp"
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
            "-IEmpire.Graphics/Graphics.ThirdParty",
            "-DNDEBUG"
        }
    },
    depfiles = "Main.o: Empire.Tools/Tools.ShaderCompiler/Main.cpp\
"
}