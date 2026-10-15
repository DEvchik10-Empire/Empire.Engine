#pragma once
// Empire.Editor / Editor.Gizmo — публичный API модуля.
// Системные заголовки (windows.h, wayland-client.h и т.п.) сюда не попадают.

#if defined(_WIN32)
    #if defined(EDITOR_GIZMO_EXPORT)
        #define EDITOR_GIZMO_API __declspec(dllexport)
    #else
        #define EDITOR_GIZMO_API __declspec(dllimport)
    #endif
#else
    #define EDITOR_GIZMO_API __attribute__((visibility("default")))
#endif

namespace Empire::Editor::Gizmo
{
}
