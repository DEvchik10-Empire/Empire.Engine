#pragma once
// Empire.Editor / Editor.Framework — публичный API модуля.
// Системные заголовки (windows.h, wayland-client.h и т.п.) сюда не попадают.

#if defined(_WIN32)
    #if defined(EDITOR_FRAMEWORK_EXPORT)
        #define EDITOR_FRAMEWORK_API __declspec(dllexport)
    #else
        #define EDITOR_FRAMEWORK_API __declspec(dllimport)
    #endif
#else
    #define EDITOR_FRAMEWORK_API __attribute__((visibility("default")))
#endif

namespace Empire::Editor::Framework
{
}
