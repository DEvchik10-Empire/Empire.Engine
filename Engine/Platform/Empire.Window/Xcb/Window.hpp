#pragma once

#include <xcb/xcb.h>
#include <utility>

#include "WindowConfig.hpp"
#include "Aliases.hpp"

using namespace Engine;

namespace Xcb
{
    class Window
    {
    public:
        Window(const Engine::WindowConfig& config);
        ~Window();

        xcb_window_t Get() const;

        b8 PollEvent();
        b8 ShouldClose() const;

        void SetTitle(const Engine::String& title);

        std::pair<Engine::i32, Engine::i32> GetPosition() const;
        void SetPosition(Engine::i32 x, Engine::i32 y);

        std::pair<Engine::i32, Engine::i32> GetSize() const;
        void SetSize(Engine::i32 width, Engine::i32 height);

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
        b8 HandleEvent(const xcb_generic_event_t* event);

        xcb_window_t window = 0;

        xcb_atom_t protocolsAtom = 0;
        xcb_atom_t deleteAtom = 0;
        xcb_atom_t netWmNameAtom = 0;
        xcb_atom_t utf8StringAtom = 0;

        b8 closeRequested = false;
        b8 isResizable = true;
        b8 isFullscreen = false;
        b8 isAlwaysOnTop = false;

        b8 resizedFlag = false;
        b8 movedFlag = false;
        b8 hasFocus = true;

        i32 lastKnownWidth = 0;
        i32 lastKnownHeight = 0;
        i32 lastKnownX = 0;
        i32 lastKnownY = 0;
    };
}