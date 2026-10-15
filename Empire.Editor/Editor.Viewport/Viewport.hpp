#pragma once
// Empire.Editor / Editor.Viewport — публичный API модуля.
// Системные заголовки (windows.h, wayland-client.h и т.п.) сюда не попадают.

#if defined(_WIN32)
    #if defined(EDITOR_VIEWPORT_EXPORT)
        #define EDITOR_VIEWPORT_API __declspec(dllexport)
    #else
        #define EDITOR_VIEWPORT_API __declspec(dllimport)
    #endif
#else
    #define EDITOR_VIEWPORT_API __attribute__((visibility("default")))
#endif

namespace Empire::Editor::Viewport
{
}
