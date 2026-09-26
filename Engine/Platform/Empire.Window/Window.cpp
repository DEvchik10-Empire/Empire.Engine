#include "Window.hpp"

#include <memory>

#include "Xcb/Window.hpp"
#include "Aliases.hpp"

namespace Engine
{
    struct Window::Impl
    {
        std::unique_ptr<Xcb::Window> window;

        Impl(const WindowConfig& config)
            : window(std::make_unique<Xcb::Window>(config))
        {
        }
    };

    Window::Window(const WindowConfig& config)
    {
        impl = new Impl(config);
    }

    Window::~Window()
    {
        delete impl;
    }

    b8 Window::PollEvent()
    {
        if (!impl->window)
            return false;

        return impl->window->PollEvent();
    }

    b8 Window::ShouldClose() const
    {
        if (!impl->window)
            return true;

        return impl->window->ShouldClose();
    }

    void Window::Close()
    {
        impl->window.reset();
    }

    b8 Window::IsOpen() const
    {
        return impl->window != nullptr;
    }

    void Window::SetTitle(const String& title)
    {
        if (impl->window)
            impl->window->SetTitle(title);
    }

    std::pair<i32, i32> Window::GetPosition() const
    {
        if (!impl->window)
            return {0, 0};

        return impl->window->GetPosition();
    }

    void Window::SetPosition(i32 x, i32 y)
    {
        if (impl->window)
            impl->window->SetPosition(x, y);
    }

    std::pair<i32, i32> Window::GetSize() const
    {
        if (!impl->window)
            return {0, 0};

        return impl->window->GetSize();
    }

    void Window::SetSize(i32 width, i32 height)
    {
        if (impl->window)
            impl->window->SetSize(width, height);
    }

    void Window::SetResizable(b8 resizable)
    {
        if (impl->window)
            impl->window->SetResizable(resizable);
    }

    b8 Window::IsResizable() const
    {
        if (!impl->window)
            return false;

        return impl->window->IsResizable();
    }

    void Window::Show()
    {
        if (impl->window)
            impl->window->Show();
    }

    void Window::Hide()
    {
        if (impl->window)
            impl->window->Hide();
    }

    void Window::Minimize()
    {
        if (impl->window)
            impl->window->Minimize();
    }

    void Window::Maximize()
    {
        if (impl->window)
            impl->window->Maximize();
    }

    void Window::Restore()
    {
        if (impl->window)
            impl->window->Restore();
    }

    void Window::SetFullscreen(b8 fullscreen)
    {
        if (impl->window)
            impl->window->SetFullscreen(fullscreen);
    }

    b8 Window::IsFullscreen() const
    {
        if (!impl->window)
            return false;

        return impl->window->IsFullscreen();
    }

    void Window::SetAlwaysOnTop(b8 onTop)
    {
        if (impl->window)
            impl->window->SetAlwaysOnTop(onTop);
    }

    b8 Window::IsAlwaysOnTop() const
    {
        if (!impl->window)
            return false;

        return impl->window->IsAlwaysOnTop();
    }

    b8 Window::WasResized()
{
    if (!impl->window)
        return false;
    return impl->window->WasResized();
}

b8 Window::WasMoved()
{
    if (!impl->window)
        return false;
    return impl->window->WasMoved();
}

b8 Window::HasFocus() const
{
    if (!impl->window)
        return false;
    return impl->window->HasFocus();
}

}