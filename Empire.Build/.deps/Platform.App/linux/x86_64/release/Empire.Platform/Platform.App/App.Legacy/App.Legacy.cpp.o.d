{
    files = {
        "Empire.Platform/Platform.App/App.Legacy/App.Legacy.cpp"
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
            "-DPLATFORM_APP_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "App.Legacy.o: Empire.Platform/Platform.App/App.Legacy/App.Legacy.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.App/App.hpp\
"
}