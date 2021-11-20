---------------------------
--  Dracula Theme by SHM  --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi

local gears = require("gears")
local default_themes_path = gears.filesystem.get_themes_dir()
local theme_name = 'dracula'
local theme_directory = string.format("%s/.config/awesome/themes/%s/", os.getenv("HOME"), theme_name)


-- Color Palette from draculatheme.com
local color_background = '#282a36' --40,42,54
local color_selection = '#44475a' --68,71,90
local color_foreground = '#f8f8f2' --246,248,242
local color_comment = '#6272a4' --98,114,164
local color_cyan = '#8be9fd' --139,233,255
local color_green = '#4dc76e' --77,199,110
local color_orange = '#ffb86c' --255,184,108
local color_pink = '#ff79c6' --255,121,198
local color_purple = '#bd93f9' --189,147,249
local color_red = '#ff5555' --255,85,85
local color_yellow = '#e6d80b' --230,216,11

local theme = {}
--client.shape_clip = 4
--theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/dracula"

-- Font{{{2
theme.font = "Operator Mono Book Italic 10"

-- Wallpaper{{{2
theme.wallpaper = theme_directory.."wallpaper/arch-dracula-center.png"

-- General{{{2
theme.bg_normal = color_selection
theme.bg_focus = color_comment
theme.bg_urgent = color_red
theme.bg_minimize = color_yellow
theme.bg_systray = theme.bg_normal
theme.bg_widget = "#cc0000"

theme.fg_normal = color_foreground
theme.fg_focus = color_background
theme.fg_urgent = color_red
theme.fg_minimize = color_purple

theme.useless_gap = dpi(3)
theme.border_width = dpi(3)
theme.border_normal = color_selection
theme.border_focus = color_comment
theme.border_marked = color_cyan
-- Menu{{{
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = default_themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]{{{2
theme.taglist_bg_focus = color_orange
-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)
-- tasklist_[bg|fg]_[focus|urgent]{{{2
-- Titlebar{{{2
-- Define the image to load
theme.titlebar_close_button_normal = default_themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = default_themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = default_themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = default_themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = default_themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = default_themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = default_themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = default_themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = default_themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = default_themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = default_themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = default_themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = default_themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = default_themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = default_themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = default_themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = default_themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = default_themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = default_themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = default_themes_path.."default/titlebar/maximized_focus_active.png"
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]{{{2
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]{{{2
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]{{{2
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]{{{2
theme.hotkeys_bg = color_background
theme.hotkeys_fg = color_foreground
theme.hotkeys_modifiers_fg = color_purple
theme.hotkeys_border_color = color_green
theme.hotkeys_group_margin = 10
-- Notifications{{{2
-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

return theme
--[[


-- Variables set for theming the menu:

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua



-- You can use your own layout icons like this:
theme.layout_fairh = default_themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = default_themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = default_themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = default_themes_path.."default/layouts/magnifierw.png"
theme.layout_max = default_themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = default_themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = default_themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = default_themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = default_themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = default_themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = default_themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = default_themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = default_themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = default_themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = default_themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = default_themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil
--]]

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
