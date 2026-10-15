{
    files = {
        "Empire.Graphics/Graphics.Device/Device.OpenGL/Device.OpenGL.cpp"
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
            "-DGRAPHICS_DEVICE_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Device.OpenGL.o:  Empire.Graphics/Graphics.Device/Device.OpenGL/Device.OpenGL.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Device/Device.hpp\
"
}