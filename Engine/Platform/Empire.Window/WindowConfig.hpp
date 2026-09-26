#pragma once

#include "Aliases.hpp"

namespace Engine
{
    struct AutoSize
    {
        operator i32() const { return -1; }
    };

    inline constexpr AutoSize Auto{};

    struct WindowConfig
    {
        i32 width = -1;
        i32 height = -1;
        String title;
    };
}