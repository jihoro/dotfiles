-- open app shortcuts
shortcuts = {
    { "W", "Google Chrome" },
    { "I", "Ghostty" },
    { "C", "Google Chat 1" },
    { "M", "Notes" },

    -- { "E", "Windsurf" },
}

for i, shortcut in ipairs(shortcuts) do
    hs.hotkey.bind({ "alt" }, shortcut[1], function()
        hs.application.launchOrFocus(shortcut[2])
    end)
end

-- hs.hotkey.bind({ "alt" }, "C", function()
--     hs.osascript.javascript([[
--     (function() {
--       var brave = Application('Brave Browser');
--       brave.activate();
--
--       for (var win of brave.windows()) {
--         var tabs = win.tabs();
--         for (var i = 0; i < tabs.length; i++) {
--           if (tabs[i].url().includes("mail.google.com/chat")) {
--             win.activeTabIndex = (i + 1);
--             win.index = 1;
--             return; // stop once we find it
--           }
--         }
--       }
--     })();
--   ]])
-- end)

-- Keep terminal word shortcuts native; translate them in other apps.
local terminalApps = {
    ["com.mitchellh.ghostty"] = true,
    ["com.apple.Terminal"] = true,
    ["com.googlecode.iterm2"] = true,
}
local wordHotkeys = {}
local function bindWordKey(mods, key, target)
    local function send()
        hs.eventtap.keyStroke({ "alt" }, target, 0)
    end
    table.insert(wordHotkeys, hs.hotkey.new(mods, key, send, nil, send))
end

bindWordKey({ "alt" }, "b", "left")
bindWordKey({ "alt" }, "f", "right")
bindWordKey({ "ctrl" }, "w", "delete")
bindWordKey({ "alt" }, "d", "forwarddelete")

local function updateWordHotkeys(app)
    local enabled = app and not terminalApps[app:bundleID()]
    for _, hotkey in ipairs(wordHotkeys) do
        if enabled then hotkey:enable() else hotkey:disable() end
    end
end

-- Global reference keeps the application watcher alive.
wordKeyWatcher = hs.application.watcher.new(function(_, event, app)
    if event == hs.application.watcher.activated then
        updateWordHotkeys(app)
    end
end):start()
updateWordHotkeys(hs.application.frontmostApplication())

hs.hotkey.bind({ "ctrl", "alt" }, "d", function()
    hs.application.launchOrFocus("Cloudflare")
end)

-- move windows shortcuts
hs.window.animationDuration = 0

local function moveWindow(xFactor, yFactor, wFactor, hFactor)
    return function()
        local win = hs.window.focusedWindow()
        if not win then return end
        local screen = win:screen()
        local max = screen:frame()

        local f = {
            x = max.x + (max.w * xFactor),
            y = max.y + (max.h * yFactor),
            w = max.w * wFactor,
            h = max.h * hFactor
        }

        win:setFrame(f)
    end
end

local modifiers = { "alt", "ctrl" }

hs.hotkey.bind(modifiers, "Left", moveWindow(0, 0, 0.5, 1))
hs.hotkey.bind(modifiers, "Right", moveWindow(0.5, 0, 0.5, 1))
hs.hotkey.bind(modifiers, "Up", moveWindow(0, 0, 1, 0.5))
hs.hotkey.bind(modifiers, "Down", moveWindow(0, 0.5, 1, 0.5))
hs.hotkey.bind(modifiers, "return", moveWindow(0, 0, 1, 1))
