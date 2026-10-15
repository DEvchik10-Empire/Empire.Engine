target("Editor.Framework")
    add_headerfiles("*.hpp")
    add_files("*.cpp")
    add_deps("Engine.Application", "Engine.Assets", "Engine.UI", "Engine.Input", "Engine.Rendering", "Engine.Node")
