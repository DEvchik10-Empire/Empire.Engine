set_project("Empire.Tests")

set_languages("c++26")

add_rules("mode.debug", "mode.release")

local EngineRoot = path.absolute("..")
local PlatformRoot = path.join(EngineRoot, "Engine/Platform")
local RenderingRoot = path.join(EngineRoot, "Engine/Rendering")

add_requires(
    "pkgconfig::vulkan",
    "pkgconfig::wayland-client",
    "pkgconfig::xcb"
)


-- Тест рендеринга: окно (Platform) + Vulkan (Rendering) + закраска цветом.
--
--   xmake build Empire.Rendering.Test.Vulkan
--   xmake run   Empire.Rendering.Test.Vulkan             (Auto)
--   xmake run   Empire.Rendering.Test.Vulkan wayland
--   xmake run   Empire.Rendering.Test.Vulkan legasy
--   xmake run   Empire.Rendering.Test.Vulkan --frames=300
target("Empire.Rendering.Test.Vulkan")
    set_kind("binary")

    -- Запуск из корня проекта: там лежат Shaders/SpirV с .spv.
    set_rundir("$(projectdir)")

    add_files(
        "Rendering/TestMain.cpp"
    )

    add_deps(
        "Empire.Platform",
        "Empire.Rendering",
        "Empire.Shaders",
        "Math"
    )

    add_includedirs(
        EngineRoot,
        PlatformRoot,
        RenderingRoot,
        path.join(PlatformRoot, "ThirdParty/Wayland")
    )

    add_packages(
        "pkgconfig::vulkan",
        "pkgconfig::wayland-client",
        "pkgconfig::xcb"
    )
