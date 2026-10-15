{
    files = {
        "Empire.Kernel/Kernel.Assert/Assert.cpp"
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
            "-DKERNEL_ASSERT_EXPORT",
            "-DNDEBUG"
        }
    },
    depfiles = "Assert.o: Empire.Kernel/Kernel.Assert/Assert.cpp  /home/devchik10/Documents/Empire.Game.Engine/Empire.Kernel/Kernel.Assert/Assert.hpp\
"
}