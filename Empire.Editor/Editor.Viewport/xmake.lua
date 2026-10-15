target("Editor.Viewport")
    add_headerfiles("*.hpp")
    add_files("*.cpp")
    add_deps("Editor.Framework", "Engine.Rendering")
