{
    files = {
        "Empire.Graphics/Graphics.Texture/Texture.OpenGL/Texture.OpenGL.cpp"
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
            "-DGRAPHICS_TEXTURE_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Texture.OpenGL.o:  Empire.Graphics/Graphics.Texture/Texture.OpenGL/Texture.OpenGL.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Texture/Texture.hpp\
"
}