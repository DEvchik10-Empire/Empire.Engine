#pragma once

#include <cstddef>
#include <cstdint>
#include <string>
#include <string_view>
#include <print>
#include <iostream>

namespace Engine
{
        // Signed integers
        using i8  = std::int8_t;
        using i16 = std::int16_t;
        using i32 = std::int32_t;
        using i64 = std::int64_t;

        // Unsigned integers
        using u8  = std::uint8_t;
        using u16 = std::uint16_t;
        using u32 = std::uint32_t;
        using u64 = std::uint64_t;

        // Floating point
        using f32 = float;
        using f64 = double;

        // Size types
        using usize = std::size_t;
        using isize = std::ptrdiff_t;

        // Strings
        using String = std::string;
        using StringView = std::string_view;

        // Byte type для сырой памяти (аллокаторы)
        using Byte = std::byte; // из <cstddef>, строгая типизация, не смешивается с числами случайно

        // C-style строка для API-границ (например, платформенные вызовы часто просят const char*)
        using CStr = const char*;

        // Void pointer для type-erased API (аллокаторы часто возвращают void*)
        using VoidPtr = void*;

        // I/O
        //using std::print;
        //using std::println;

        // Characters
        using Char   = char;
        //using Char8  = char8_t;
        using Char16 = char16_t;
        using Char32 = char32_t;

        // I/O streams
        inline std::istream& Cin  = std::cin;
        inline std::ostream& Cout = std::cout;

        // Boolean
        using b8 = bool; // просто алиас на bool, если нужен только единый стиль именования (i8/u8/f32 и т.д.)

        // Продолжение следует....
    
}