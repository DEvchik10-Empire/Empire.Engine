{
    files = {
        "Empire.Platform/Platform.Cursor/Cursor.Legacy/Cursor.Legacy.cpp"
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
            "-DPLATFORM_CURSOR_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Cursor.Legacy.o:  Empire.Platform/Platform.Cursor/Cursor.Legacy/Cursor.Legacy.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Cursor/Cursor.hpp\
"
}