#include "Window.hpp"

#include <cstdlib>
#include <xcb/xcb.h>

#include "Empire.App/Xcb/Connection.hpp"
#include "Empire.App/Xcb/EventQueue.hpp"
#include "WindowConfig.hpp"
#include "Aliases.hpp"

using namespace Engine;

namespace Xcb
{
    namespace
    {
        void SendNetWmStateMessage(xcb_connection_t* conn, xcb_window_t window,
                                    xcb_screen_t* screen, i32 action,
                                    xcb_atom_t state1, xcb_atom_t state2 = 0)
        {
            xcb_intern_atom_cookie_t stateCookie =
                xcb_intern_atom(conn, 0, 13, "_NET_WM_STATE");
            xcb_intern_atom_reply_t* stateReply =
                xcb_intern_atom_reply(conn, stateCookie, nullptr);

            if (!stateReply)
                return;

            xcb_client_message_event_t event = {};
            event.response_type = XCB_CLIENT_MESSAGE;
            event.format = 32;
            event.window = window;
            event.type = stateReply->atom;
            event.data.data32[0] = action; // 0 = remove, 1 = add, 2 = toggle
            event.data.data32[1] = state1;
            event.data.data32[2] = state2;
            event.data.data32[3] = 1; // source indication: normal application

            xcb_send_event(conn, 0, screen->root,
                            XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT | XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY,
                            reinterpret_cast<const char*>(&event));

            std::free(stateReply);
            xcb_flush(conn);
        }

        b8 NetWmStateContains(xcb_connection_t* conn, xcb_window_t window, xcb_atom_t targetAtom)
        {
            xcb_intern_atom_cookie_t stateCookie =
                xcb_intern_atom(conn, 0, 13, "_NET_WM_STATE");
            xcb_intern_atom_reply_t* stateReply =
                xcb_intern_atom_reply(conn, stateCookie, nullptr);

            if (!stateReply)
                return false;

            xcb_get_property_cookie_t propCookie =
                xcb_get_property(conn, 0, window, stateReply->atom,
                                  XCB_ATOM_ATOM, 0, 1024);
            xcb_get_property_reply_t* propReply =
                xcb_get_property_reply(conn, propCookie, nullptr);

            b8 found = false;

            if (propReply)
            {
                xcb_atom_t* atoms = static_cast<xcb_atom_t*>(xcb_get_property_value(propReply));
                i32 count = xcb_get_property_value_length(propReply) / sizeof(xcb_atom_t);

                for (i32 i = 0; i < count; ++i)
                {
                    if (atoms[i] == targetAtom)
                    {
                        found = true;
                        break;
                    }
                }

                std::free(propReply);
            }

            std::free(stateReply);
            return found;
        }
    }

    Window::Window(const Engine::WindowConfig& config)
    {
        xcb_connection_t* conn = Connection::Instance().get();

        window = xcb_generate_id(conn);

        const xcb_setup_t* setup = xcb_get_setup(conn);
        xcb_screen_iterator_t iter = xcb_setup_roots_iterator(setup);
        xcb_screen_t* screen = iter.data;

        i32 actualWidth = (config.width == -1)
            ? screen->width_in_pixels
            : config.width;

        i32 actualHeight = (config.height == -1)
            ? screen->height_in_pixels
            : config.height;

        u32 eventMask = XCB_EVENT_MASK_PROPERTY_CHANGE;

        xcb_create_window(conn,
                           XCB_COPY_FROM_PARENT,
                           window,
                           screen->root,
                           0, 0,
                           actualWidth, actualHeight,
                           10,
                           XCB_WINDOW_CLASS_INPUT_OUTPUT,
                           screen->root_visual,
                           XCB_CW_EVENT_MASK, &eventMask);

        // WM_NAME (legacy, ASCII) — читается почти всеми WM
        xcb_change_property(conn,
                             XCB_PROP_MODE_REPLACE,
                             window,
                             XCB_ATOM_WM_NAME,
                             XCB_ATOM_STRING,
                             8,
                             config.title.size(),
                             config.title.c_str());

        // _NET_WM_NAME (современный, UTF-8) — нужны свои атомы
        xcb_intern_atom_cookie_t netWmNameCookie =
            xcb_intern_atom(conn, 0, 12, "_NET_WM_NAME");
        xcb_intern_atom_reply_t* netWmNameReply =
            xcb_intern_atom_reply(conn, netWmNameCookie, nullptr);

        xcb_intern_atom_cookie_t utf8StringCookie =
            xcb_intern_atom(conn, 0, 11, "UTF8_STRING");
        xcb_intern_atom_reply_t* utf8StringReply =
            xcb_intern_atom_reply(conn, utf8StringCookie, nullptr);

        if (netWmNameReply && utf8StringReply)
        {
            netWmNameAtom = netWmNameReply->atom;
            utf8StringAtom = utf8StringReply->atom;

            xcb_change_property(conn,
                                 XCB_PROP_MODE_REPLACE,
                                 window,
                                 netWmNameAtom,
                                 utf8StringAtom,
                                 8,
                                 config.title.size(),
                                 config.title.c_str());
        }

        std::free(netWmNameReply);
        std::free(utf8StringReply);

        // WM_DELETE_WINDOW setup — чтобы получать событие "юзер запросил закрытие"
        // вместо разрыва соединения при закрытии окна
        xcb_intern_atom_cookie_t protocolsCookie =
            xcb_intern_atom(conn, 0, 12, "WM_PROTOCOLS");
        xcb_intern_atom_reply_t* protocolsReply =
            xcb_intern_atom_reply(conn, protocolsCookie, nullptr);

        xcb_intern_atom_cookie_t deleteCookie =
            xcb_intern_atom(conn, 0, 16, "WM_DELETE_WINDOW");
        xcb_intern_atom_reply_t* deleteReply =
            xcb_intern_atom_reply(conn, deleteCookie, nullptr);

        if (protocolsReply && deleteReply)
        {
            protocolsAtom = protocolsReply->atom;
            deleteAtom = deleteReply->atom;

            xcb_change_property(conn,
                                 XCB_PROP_MODE_REPLACE,
                                 window,
                                 protocolsAtom,
                                 XCB_ATOM_ATOM,
                                 32, 1,
                                 &deleteAtom);
        }

        std::free(protocolsReply);
        std::free(deleteReply);

        EventQueue::Instance().RegisterWindow(window);

        xcb_map_window(conn, window);
        xcb_flush(conn);
    }

    Window::~Window()
    {
        xcb_connection_t* conn = Connection::Instance().get();

        EventQueue::Instance().UnregisterWindow(window);

        if (window != 0)
        {
            xcb_destroy_window(conn, window);
            xcb_flush(conn);
        }
    }

    xcb_window_t Window::Get() const
    {
        return window;
    }

    b8 Window::HandleEvent(const xcb_generic_event_t* event)
{
    if (!event)
        return false;

    const u8 responseType = event->response_type & ~0x80;

    if (responseType == XCB_CONFIGURE_NOTIFY)
    {
        const auto* configureEvent =
            reinterpret_cast<const xcb_configure_notify_event_t*>(event);

        if (configureEvent->width != lastKnownWidth || configureEvent->height != lastKnownHeight)
        {
            resizedFlag = true;
            lastKnownWidth = configureEvent->width;
            lastKnownHeight = configureEvent->height;
        }

        if (configureEvent->x != lastKnownX || configureEvent->y != lastKnownY)
        {
            movedFlag = true;
            lastKnownX = configureEvent->x;
            lastKnownY = configureEvent->y;
        }

        return true;
    }

    if (responseType == XCB_FOCUS_IN)
    {
        hasFocus = true;
        return true;
    }

    if (responseType == XCB_FOCUS_OUT)
    {
        hasFocus = false;
        return true;
    }

    if (responseType == XCB_PROPERTY_NOTIFY)
    {
        xcb_connection_t* conn = Connection::Instance().get();

        xcb_intern_atom_cookie_t fsCookie =
            xcb_intern_atom(conn, 0, 24, "_NET_WM_STATE_FULLSCREEN");
        xcb_intern_atom_reply_t* fsReply =
            xcb_intern_atom_reply(conn, fsCookie, nullptr);

        if (fsReply)
        {
            isFullscreen = NetWmStateContains(conn, window, fsReply->atom);
            std::free(fsReply);
        }

        xcb_intern_atom_cookie_t aboveCookie =
            xcb_intern_atom(conn, 0, 20, "_NET_WM_STATE_ABOVE");
        xcb_intern_atom_reply_t* aboveReply =
            xcb_intern_atom_reply(conn, aboveCookie, nullptr);

        if (aboveReply)
        {
            isAlwaysOnTop = NetWmStateContains(conn, window, aboveReply->atom);
            std::free(aboveReply);
        }

        return true;
    }

    if (responseType != XCB_CLIENT_MESSAGE)
        return false;

    const auto* clientMessage =
        reinterpret_cast<const xcb_client_message_event_t*>(event);

    if (clientMessage->window != window)
        return false;

    if (clientMessage->type != protocolsAtom)
        return false;

    if (clientMessage->data.data32[0] != deleteAtom)
        return false;

    closeRequested = true;
    return true;
}

    b8 Window::PollEvent()
    {
        xcb_generic_event_t* event = EventQueue::Instance().PollEvent(window);

        if (!event)
            return false;

        const b8 handled = HandleEvent(event);
        std::free(event);

        return handled;
    }

    b8 Window::ShouldClose() const
    {
        return closeRequested;
    }

    void Window::SetTitle(const Engine::String& title)
    {
        xcb_connection_t* conn = Connection::Instance().get();

        xcb_change_property(conn, XCB_PROP_MODE_REPLACE, window,
                             XCB_ATOM_WM_NAME, XCB_ATOM_STRING, 8,
                             title.size(), title.c_str());

        if (netWmNameAtom && utf8StringAtom)
        {
            xcb_change_property(conn, XCB_PROP_MODE_REPLACE, window,
                                 netWmNameAtom, utf8StringAtom, 8,
                                 title.size(), title.c_str());
        }

        xcb_flush(conn);
    }

    std::pair<i32, i32> Window::GetPosition() const
    {
        xcb_connection_t* conn = Connection::Instance().get();

        xcb_get_geometry_cookie_t cookie = xcb_get_geometry(conn, window);
        xcb_get_geometry_reply_t* reply = xcb_get_geometry_reply(conn, cookie, nullptr);

        if (!reply)
            return {0, 0};

        xcb_translate_coordinates_cookie_t translateCookie =
            xcb_translate_coordinates(conn, window, reply->root, 0, 0);
        xcb_translate_coordinates_reply_t* translateReply =
            xcb_translate_coordinates_reply(conn, translateCookie, nullptr);

        std::pair<i32, i32> result{0, 0};

        if (translateReply)
        {
            result = {translateReply->dst_x, translateReply->dst_y};
            std::free(translateReply);
        }

        std::free(reply);
        return result;
    }

    void Window::SetPosition(i32 x, i32 y)
    {
        xcb_connection_t* conn = Connection::Instance().get();

        const u32 values[] = {
            static_cast<u32>(x),
            static_cast<u32>(y)
        };

        xcb_configure_window(conn, window,
                              XCB_CONFIG_WINDOW_X | XCB_CONFIG_WINDOW_Y,
                              values);
        xcb_flush(conn);
    }

    std::pair<i32, i32> Window::GetSize() const
    {
        xcb_connection_t* conn = Connection::Instance().get();

        xcb_get_geometry_cookie_t cookie = xcb_get_geometry(conn, window);
        xcb_get_geometry_reply_t* reply = xcb_get_geometry_reply(conn, cookie, nullptr);

        if (!reply)
            return {0, 0};

        std::pair<i32, i32> result{reply->width, reply->height};
        std::free(reply);
        return result;
    }

    void Window::SetSize(i32 width, i32 height)
    {
        xcb_connection_t* conn = Connection::Instance().get();

        const u32 values[] = {
            static_cast<u32>(width),
            static_cast<u32>(height)
        };

        xcb_configure_window(conn, window,
                              XCB_CONFIG_WINDOW_WIDTH | XCB_CONFIG_WINDOW_HEIGHT,
                              values);
        xcb_flush(conn);
    }

    void Window::SetResizable(b8 resizable)
    {
        xcb_connection_t* conn = Connection::Instance().get();
        isResizable = resizable;

        struct
        {
            u32 flags;
            i32 x, y;
            i32 width, height;
            i32 min_width, min_height;
            i32 max_width, max_height;
            i32 width_inc, height_inc;
            i32 min_aspect_num, min_aspect_den;
            i32 max_aspect_num, max_aspect_den;
            i32 base_width, base_height;
            u32 win_gravity;
        } hints = {};

        constexpr u32 PMinSize = 1 << 4;
        constexpr u32 PMaxSize = 1 << 5;

        auto [width, height] = GetSize();

        if (!resizable)
        {
            hints.flags = PMinSize | PMaxSize;
            hints.min_width = width;
            hints.min_height = height;
            hints.max_width = width;
            hints.max_height = height;
        }
        else
        {
            hints.flags = PMinSize | PMaxSize;
            hints.min_width = 1;
            hints.min_height = 1;
            hints.max_width = 32767;
            hints.max_height = 32767;
        }

        xcb_change_property(conn, XCB_PROP_MODE_REPLACE, window,
                             XCB_ATOM_WM_NORMAL_HINTS, XCB_ATOM_WM_SIZE_HINTS, 32,
                             sizeof(hints) / 4, &hints);

        xcb_flush(conn);
    }

    b8 Window::IsResizable() const
    {
        return isResizable;
    }

    void Window::Show()
    {
        xcb_connection_t* conn = Connection::Instance().get();
        xcb_map_window(conn, window);
        xcb_flush(conn);
    }

    void Window::Hide()
    {
        xcb_connection_t* conn = Connection::Instance().get();
        xcb_unmap_window(conn, window);
        xcb_flush(conn);
    }

    void Window::Minimize()
    {
        xcb_connection_t* conn = Connection::Instance().get();

        const xcb_setup_t* setup = xcb_get_setup(conn);
        xcb_screen_t* screen = xcb_setup_roots_iterator(setup).data;

        xcb_intern_atom_cookie_t cookie =
            xcb_intern_atom(conn, 0, 16, "WM_CHANGE_STATE");
        xcb_intern_atom_reply_t* reply =
            xcb_intern_atom_reply(conn, cookie, nullptr);

        if (!reply)
            return;

        xcb_client_message_event_t event = {};
        event.response_type = XCB_CLIENT_MESSAGE;
        event.format = 32;
        event.window = window;
        event.type = reply->atom;
        event.data.data32[0] = 3; // IconicState

        xcb_send_event(conn, 0, screen->root,
                        XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT | XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY,
                        reinterpret_cast<const char*>(&event));

        std::free(reply);
        xcb_flush(conn);
    }

    void Window::Maximize()
    {
        xcb_connection_t* conn = Connection::Instance().get();
        const xcb_setup_t* setup = xcb_get_setup(conn);
        xcb_screen_t* screen = xcb_setup_roots_iterator(setup).data;

        xcb_intern_atom_cookie_t vertCookie =
            xcb_intern_atom(conn, 0, 24, "_NET_WM_STATE_MAXIMIZED_VERT");
        xcb_intern_atom_reply_t* vertReply =
            xcb_intern_atom_reply(conn, vertCookie, nullptr);

        xcb_intern_atom_cookie_t horzCookie =
            xcb_intern_atom(conn, 0, 24, "_NET_WM_STATE_MAXIMIZED_HORZ");
        xcb_intern_atom_reply_t* horzReply =
            xcb_intern_atom_reply(conn, horzCookie, nullptr);

        if (vertReply && horzReply)
        {
            SendNetWmStateMessage(conn, window, screen, 1, vertReply->atom, horzReply->atom);
        }

        std::free(vertReply);
        std::free(horzReply);
    }

    void Window::Restore()
    {
        xcb_connection_t* conn = Connection::Instance().get();
        const xcb_setup_t* setup = xcb_get_setup(conn);
        xcb_screen_t* screen = xcb_setup_roots_iterator(setup).data;

        xcb_intern_atom_cookie_t vertCookie =
            xcb_intern_atom(conn, 0, 24, "_NET_WM_STATE_MAXIMIZED_VERT");
        xcb_intern_atom_reply_t* vertReply =
            xcb_intern_atom_reply(conn, vertCookie, nullptr);

        xcb_intern_atom_cookie_t horzCookie =
            xcb_intern_atom(conn, 0, 24, "_NET_WM_STATE_MAXIMIZED_HORZ");
        xcb_intern_atom_reply_t* horzReply =
            xcb_intern_atom_reply(conn, horzCookie, nullptr);

        if (vertReply && horzReply)
        {
            SendNetWmStateMessage(conn, window, screen, 0, vertReply->atom, horzReply->atom);
        }

        std::free(vertReply);
        std::free(horzReply);
    }

    void Window::SetFullscreen(b8 fullscreen)
    {
        xcb_connection_t* conn = Connection::Instance().get();
        const xcb_setup_t* setup = xcb_get_setup(conn);
        xcb_screen_t* screen = xcb_setup_roots_iterator(setup).data;

        xcb_intern_atom_cookie_t cookie =
            xcb_intern_atom(conn, 0, 24, "_NET_WM_STATE_FULLSCREEN");
        xcb_intern_atom_reply_t* reply =
            xcb_intern_atom_reply(conn, cookie, nullptr);

        if (reply)
        {
            SendNetWmStateMessage(conn, window, screen, fullscreen ? 1 : 0, reply->atom);
            isFullscreen = fullscreen;
        }

        std::free(reply);
    }

    b8 Window::IsFullscreen() const
    {
        return isFullscreen;
    }

    void Window::SetAlwaysOnTop(b8 onTop)
    {
        xcb_connection_t* conn = Connection::Instance().get();
        const xcb_setup_t* setup = xcb_get_setup(conn);
        xcb_screen_t* screen = xcb_setup_roots_iterator(setup).data;

        xcb_intern_atom_cookie_t cookie =
            xcb_intern_atom(conn, 0, 20, "_NET_WM_STATE_ABOVE");
        xcb_intern_atom_reply_t* reply =
            xcb_intern_atom_reply(conn, cookie, nullptr);

        if (reply)
        {
            SendNetWmStateMessage(conn, window, screen, onTop ? 1 : 0, reply->atom);
            isAlwaysOnTop = onTop;
        }

        std::free(reply);
    }

    b8 Window::IsAlwaysOnTop() const
    {
        return isAlwaysOnTop;
    }

    b8 Window::HandleEvent(const xcb_generic_event_t* event)
{
    if (!event)
        return false;

    const u8 responseType = event->response_type & ~0x80;

    if (responseType == XCB_CONFIGURE_NOTIFY)
    {
        const auto* configureEvent =
            reinterpret_cast<const xcb_configure_notify_event_t*>(event);

        static i32 lastWidth = configureEvent->width;
        static i32 lastHeight = configureEvent->height;
        static i32 lastX = configureEvent->x;
        static i32 lastY = configureEvent->y;

        if (configureEvent->width != lastWidth || configureEvent->height != lastHeight)
        {
            resizedFlag = true;
            lastWidth = configureEvent->width;
            lastHeight = configureEvent->height;
        }

        if (configureEvent->x != lastX || configureEvent->y != lastY)
        {
            movedFlag = true;
            lastX = configureEvent->x;
            lastY = configureEvent->y;
        }

        return true;
    }

    if (responseType == XCB_FOCUS_IN)
    {
        hasFocus = true;
        return true;
    }

    if (responseType == XCB_FOCUS_OUT)
    {
        hasFocus = false;
        return true;
    }

    // ... остальная логика PROPERTY_NOTIFY / CLIENT_MESSAGE как была
}

b8 Window::WasResized()
{
    b8 result = resizedFlag;
    resizedFlag = false;
    return result;
}

b8 Window::WasMoved()
{
    b8 result = movedFlag;
    movedFlag = false;
    return result;
}

b8 Window::HasFocus() const
{
    return hasFocus;
}

}