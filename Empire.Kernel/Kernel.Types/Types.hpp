#pragma once
// Empire.Kernel / Kernel.Types — публичный API модуля.
// Системные заголовки (windows.h, wayland-client.h и т.п.) сюда не попадают.

#if defined(_WIN32)
    #if defined(KERNEL_TYPES_EXPORT)
        #define KERNEL_TYPES_API __declspec(dllexport)
    #else
        #define KERNEL_TYPES_API __declspec(dllimport)
    #endif
#else
    #define KERNEL_TYPES_API __attribute__((visibility("default")))
#endif

namespace Empire::Kernel::Types
{
}
