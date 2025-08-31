-- open app shortcuts
shortcuts = {
    { "L", "Brave Browser" },
    { "I", "iTerm" },
    -- {"C", "Google Chat"},
    { "M", "Notes" },
    { "W", "Windsurf" },
}

for i, shortcut in ipairs(shortcuts) do
    hs.hotkey.bind({ "alt" }, shortcut[1], function()
        hs.application.launchOrFocus(shortcut[2])
    end)
end

hs.hotkey.bind({ "alt" }, "C", function()
    hs.osascript.javascript([[
    (function() {
      var brave = Application('Brave Browser');
      brave.activate();

      for (var win of brave.windows()) {
        var tabs = win.tabs();
        for (var i = 0; i < tabs.length; i++) {
          if (tabs[i].url().includes("mail.google.com/chat")) {
            win.activeTabIndex = (i + 1);
            win.index = 1;
            return; // stop once we find it
          }
        }
      }
    })();
  ]])
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
