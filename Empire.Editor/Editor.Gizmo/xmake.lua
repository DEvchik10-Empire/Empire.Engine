target("Editor.Gizmo")
    add_headerfiles("*.hpp")
    add_files("*.cpp")
    add_deps("Editor.Viewport", "Math.Transform")
