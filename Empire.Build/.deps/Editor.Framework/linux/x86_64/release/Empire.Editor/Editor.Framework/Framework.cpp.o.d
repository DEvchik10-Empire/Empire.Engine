{
    files = {
        "Empire.Editor/Editor.Framework/Framework.cpp"
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
            "-DEDITOR_FRAMEWORK_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Framework.o: Empire.Editor/Editor.Framework/Framework.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Editor/Editor.Framework/Framework.hpp\
"
}