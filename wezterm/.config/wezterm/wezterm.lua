-- Pull in the wezterm API
local wezterm = require 'wezterm'
-- act is used for keybinds
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()

if wezterm.target_triple:find("apple%-darwin") then
  wezterm.on("gui-startup", function(cmd)
    local screen = wezterm.gui.screens().active
    local ratio = 0.4
    local width = screen.width * ratio
    local height = screen.height
    local tab, pane, window = wezterm.mux.spawn_window {
      position = {
        x = screen.width - width,
        y = 0,
        origin = 'ActiveScreen'
      }
    }
    window:gui_window():set_inner_size(width, height)
    window:gui_window():set_position(screen.width - width, 0)
  end)
  config.window_decorations = "RESIZE"
end

local function terminfo_exists(name)
  local handle = io.popen("infocmp " .. name .. " 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  return result ~= ""
end

if terminfo_exists("wezterm") then
  config.term = "wezterm"
else
  config.term = "xterm-256color"
end

config.default_cursor_style = 'SteadyBar'

config.font = wezterm.font('CommitMono Nerd Font Mono')
config.font_size = 13.0
config.max_fps = 144
config.animation_fps = 30

-- Command Palette
-- NIGHTLY config.command_palette_font = wezterm.font 'CommitMono Nerd Font Mono'
config.command_palette_font_size = 13.0
config.command_palette_bg_color = "#1e2124"
config.command_palette_fg_color = "#7b8496"

-- Apply cyberdream and my changes to tab bar appearance
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 155
config.window_background_opacity = 0.95
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }
config.color_scheme = 'cyberdream-dark'

-- to see default keybinds: wezterm show-keys --lua
-- remove default keybinds and minimize keyboard shortcuts
config.disable_default_key_bindings = true

config.keys = {
    { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'P', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'V', mods = 'SHIFT|ALT|CTRL', action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } },
    { key = 'S', mods = 'SHIFT|ALT|CTRL', action = act.SplitVertical{ domain = 'CurrentPaneDomain' } },
    { key = 'H', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
    { key = 'L', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = 'K', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
    { key = 'J', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
    { key = 'U', mods = 'SHIFT|CTRL', action = act.ScrollByPage(-0.5) },
    { key = 'D', mods = 'SHIFT|CTRL', action = act.ScrollByPage(0.5) },
    { key = 'Z', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    { key = 'z', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    { key = '<', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
    { key = '>', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
    { key = ',', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
    { key = '.', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
    { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
    { key = 'Insert', mods = 'CTRL', action = act.CopyTo 'PrimarySelection' },
    { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
    { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
    { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'C', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'V', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    --{ key = 'X', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
    { key = 'T', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 't', mods = 'SHIFT|CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
    { key = '[', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1) },
    { key = '{', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    { key = '}', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1) },
    { key = '1', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
    { key = '!', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
    { key = '2', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
    { key = '@', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
    { key = '3', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
    { key = '#', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
    { key = '4', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
    { key = '$', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
    { key = '5', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
    { key = '%', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
    { key = '6', mods = 'SHIFT|CTRL', action = act.ActivateTab(5) },
    { key = '^', mods = 'SHIFT|CTRL', action = act.ActivateTab(5) },
    { key = '7', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
    { key = '&', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
    { key = '8', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
    { key = '*', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
}

config.key_tables = {
  copy_mode = {
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
  },
  search_mode = {
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
  },
}

return config
