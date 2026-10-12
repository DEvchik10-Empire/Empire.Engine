{
    depfiles = "StbImage.o: Engine/Rendering/Empire.Mesh/StbImage.cpp  Engine/Rendering/Empire.Mesh/../ThirdParty/stb/stb_image.h\
",
    files = {
        "Engine/Rendering/Empire.Mesh/StbImage.cpp"
    },
    depfiles_format = "gcc",
    values = {
        "/usr/bin/g++",
        {
            "-m64",
            "-fvisibility=hidden",
            "-fvisibility-inlines-hidden",
            "-O3",
            "-std=c++26",
            "-I/home/devchik10/Documents/Empire.Engine",
            "-I/home/devchik10/Documents/Empire.Engine/Engine/Rendering",
            "-DNDEBUG"
        }
    }
}