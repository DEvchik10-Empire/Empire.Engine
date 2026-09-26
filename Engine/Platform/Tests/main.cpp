#include <thread>
#include <chrono>
#include <iostream>

#include "Window.hpp"
#include "WindowConfig.hpp"

using namespace Engine;

int main()
{
    WindowConfig editorConfig;
    editorConfig.width = 800;
    editorConfig.height = 600;
    editorConfig.title = "Resizable Test";

    Window editor(editorConfig);

    while (editor.IsOpen())
    {
        editor.PollEvent();

        if (editor.ShouldClose())
            editor.Close();

        std::this_thread::sleep_for(std::chrono::milliseconds(16));
    }

    return 0;
}