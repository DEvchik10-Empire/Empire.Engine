{
    files = {
        "Empire.Platform/Platform.Dialog/Dialog.Wayland/Dialog.Wayland.cpp"
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
            "-DPLATFORM_DIALOG_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Dialog.Wayland.o:  Empire.Platform/Platform.Dialog/Dialog.Wayland/Dialog.Wayland.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Dialog/Dialog.hpp\
"
}