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

local modifiers = {"alt", "ctrl"}

hs.hotkey.bind(modifiers, "Left", moveWindow(0, 0, 0.5, 1))
hs.hotkey.bind(modifiers, "Right", moveWindow(0.5, 0, 0.5, 1))
hs.hotkey.bind(modifiers, "Up", moveWindow(0, 0, 1, 0.5))
hs.hotkey.bind(modifiers, "Down", moveWindow(0, 0.5, 1, 0.5))
hs.hotkey.bind(modifiers, "return", moveWindow(0, 0, 1, 1))
