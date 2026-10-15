target("Editor.Panel")
    add_headerfiles("*.hpp")
    add_files("*.cpp")
    add_deps("Editor.Framework", "Engine.Node", "Engine.Assets", "Engine.UI")
