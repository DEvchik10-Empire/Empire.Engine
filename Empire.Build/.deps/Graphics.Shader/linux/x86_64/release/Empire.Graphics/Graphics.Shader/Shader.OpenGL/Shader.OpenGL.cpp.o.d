{
    files = {
        "Empire.Graphics/Graphics.Shader/Shader.OpenGL/Shader.OpenGL.cpp"
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
            "-DGRAPHICS_SHADER_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Shader.OpenGL.o:  Empire.Graphics/Graphics.Shader/Shader.OpenGL/Shader.OpenGL.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Graphics/Graphics.Shader/Shader.hpp\
"
}