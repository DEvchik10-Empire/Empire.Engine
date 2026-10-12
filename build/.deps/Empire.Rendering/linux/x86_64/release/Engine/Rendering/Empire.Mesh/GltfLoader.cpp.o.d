{
    depfiles = "GltfLoader.o: Engine/Rendering/Empire.Mesh/GltfLoader.cpp  Engine/Rendering/Empire.Mesh/Mesh.hpp  /home/devchik10/Documents/Empire.Engine/Kernel/Types.hpp  Engine/Rendering/Empire.Mesh/../ThirdParty/stb/stb_image.h\
",
    files = {
        "Engine/Rendering/Empire.Mesh/GltfLoader.cpp"
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