local beautiful = require("beautiful")

local themeName = "dracula"
local themeDir = os.getenv('HOME') .. '/.config/awesome/themes/'..themeName..'/theme.lua'

beautiful.init(themeDir)
