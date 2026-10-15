#pragma once
// Empire.Editor / Editor.Plugin — публичный API модуля.
// Системные заголовки (windows.h, wayland-client.h и т.п.) сюда не попадают.

#if defined(_WIN32)
    #if defined(EDITOR_PLUGIN_EXPORT)
        #define EDITOR_PLUGIN_API __declspec(dllexport)
    #else
        #define EDITOR_PLUGIN_API __declspec(dllimport)
    #endif
#else
    #define EDITOR_PLUGIN_API __attribute__((visibility("default")))
#endif

namespace Empire::Editor::Plugin
{
}
