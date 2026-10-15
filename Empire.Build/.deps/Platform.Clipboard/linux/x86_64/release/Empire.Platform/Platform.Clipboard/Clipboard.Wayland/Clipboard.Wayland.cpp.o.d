{
    files = {
        "Empire.Platform/Platform.Clipboard/Clipboard.Wayland/Clipboard.Wayland.cpp"
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
            "-DPLATFORM_CLIPBOARD_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Clipboard.Wayland.o:  Empire.Platform/Platform.Clipboard/Clipboard.Wayland/Clipboard.Wayland.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Clipboard/Clipboard.hpp\
"
}