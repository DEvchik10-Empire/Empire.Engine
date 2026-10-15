{
    files = {
        "Empire.Platform/Platform.Dialog/Dialog.Legacy/Dialog.Legacy.cpp"
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
    depfiles = "Dialog.Legacy.o:  Empire.Platform/Platform.Dialog/Dialog.Legacy/Dialog.Legacy.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Platform/Platform.Dialog/Dialog.hpp\
"
}