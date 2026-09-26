#pragma once

#include <utility>

#include "WindowConfig.hpp"
#include "Aliases.hpp"

namespace Engine
{
    class Window
    {
    public:
        Window(const WindowConfig& config);
        ~Window();

        b8 PollEvent();
        b8 ShouldClose() const;
        void Close();
        b8 IsOpen() const;

        void SetTitle(const String& title);

        std::pair<i32, i32> GetPosition() const;
        void SetPosition(i32 x, i32 y);

        std::pair<i32, i32> GetSize() const;
        void SetSize(i32 width, i32 height);

        void SetResizable(b8 resizable);
        b8 IsResizable() const;

        void Show();
        void Hide();
        void Minimize();
        void Maximize();
        void Restore(); 

        void SetFullscreen(b8 fullscreen);
        b8 IsFullscreen() const;
        void SetAlwaysOnTop(b8 onTop);
        b8 IsAlwaysOnTop() const;

        b8 WasResized();
b8 WasMoved();
b8 HasFocus() const;

    private:
        struct Impl;
        Impl* impl = nullptr;
    };
}