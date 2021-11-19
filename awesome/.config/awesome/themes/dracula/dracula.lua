local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local color_background = '#282a36', --40,42,54
local color_selection = '#44475a', --68,71,90
local color_foreground = '#f8f8f2', --246,248,242
local color_comment = '#6272a4', --98,114,164
local color_cyan = '#8be9fd', --139,233,255
local color_green = '#4dc76e', --77,199,110
local color_orange = '#ffb86c', --255,184,108
local color_pink = '#ff79c6', --255,121,198
local color_purple = '#bd93f9', --189,147,249
local color_red = '#ff5555', --255,85,85
local color_yellow = '#e6d80b', --230,216,11

local theme = {}
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/dracula"

theme.useless_gap   = dpi(4)
theme.border_width  = dpi(7)

theme.hotkeys_bg = colors.selection
theme.hotkeys_fg = colors.white
theme.hotkeys_modifiers_fg = colors.purple
theme.hotkeys_border_color = colors.green
theme.hotkeys_group_margin = 10

client.shape_clip = 4

return theme
