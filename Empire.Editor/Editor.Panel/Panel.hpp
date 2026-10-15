#pragma once
// Empire.Editor / Editor.Panel — публичный API модуля.
// Системные заголовки (windows.h, wayland-client.h и т.п.) сюда не попадают.

#if defined(_WIN32)
    #if defined(EDITOR_PANEL_EXPORT)
        #define EDITOR_PANEL_API __declspec(dllexport)
    #else
        #define EDITOR_PANEL_API __declspec(dllimport)
    #endif
#else
    #define EDITOR_PANEL_API __attribute__((visibility("default")))
#endif

namespace Empire::Editor::Panel
{
}
