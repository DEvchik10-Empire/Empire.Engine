#pragma once
// Empire.Editor / Editor.Tool — публичный API модуля.
// Системные заголовки (windows.h, wayland-client.h и т.п.) сюда не попадают.

#if defined(_WIN32)
    #if defined(EDITOR_TOOL_EXPORT)
        #define EDITOR_TOOL_API __declspec(dllexport)
    #else
        #define EDITOR_TOOL_API __declspec(dllimport)
    #endif
#else
    #define EDITOR_TOOL_API __attribute__((visibility("default")))
#endif

namespace Empire::Editor::Tool
{
}
