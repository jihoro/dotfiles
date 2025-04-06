shortcuts = {
    {"B", "Brave Browser"},
    {"T", "iTerm"},
    {"C", "Google Chat"},
    {"N", "Notes"},
}

for i,shortcut in ipairs(shortcuts) do
    hs.hotkey.bind({"alt"}, shortcut[1], function()
        hs.application.launchOrFocus(shortcut[2])
    end)
end