local keys = require("shm.keys")
local utils = require("shm.utils")

local apps = {
  f1 = "KeePassXC",
  f6 = "QuickGPT",
  f5 = "Obsidian",
  ["return"] = "Ghostty",
}

for key, appName in pairs(apps) do
  hs.hotkey.bind(keys.hyper, key, function()
    utils.toggle_app(appName)
  end)
end
