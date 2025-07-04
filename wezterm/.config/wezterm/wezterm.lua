-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_cursor_style = 'SteadyBar'

config.font = wezterm.font('CommitMono Nerd Font Mono')
config.font_size = 13.0

-- Command Palette
-- NIGHTLY config.command_palette_font = wezterm.font 'CommitMono Nerd Font Mono'
config.command_palette_font_size = 13.0
config.command_palette_bg_color = "#1e2124"
config.command_palette_fg_color = "#7b8496"

-- Apply cyberdream and my changes to tab bar appearance
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = "RESIZE"
config.tab_max_width = 155
config.window_background_opacity = 0.95
config.window_padding =
{
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.colors = {
  -- Cyberdream by https://github.com/scottmckendry/cyberdream.nvim
  -- I could not get my tab setup working with importing cyberdream, just copied it manually
  -- Cyberdream Dark Palette:
  -- #16181a bg
  -- #1e2124 bg_alt
  -- #3c4048 bg_highlight
  -- #ffffff fg
  -- #7b8496 grey
  -- #5ea1ff blue
  -- #5eff6c green
  -- #5ef1ff cyan
  -- #ff6e5e red
  -- #f1ff5e yellow
  -- #ff5ef1 magenta
  -- #ff5ea0 pink
  -- #ffbd5e orange
  -- #bd5eff purple

  foreground = "#ffffff",
  background = "#16181a",

  cursor_bg = "#ffffff",
  cursor_fg = "#16181a",
  cursor_border = "#ffffff",

  selection_fg = "#ffffff",
  selection_bg = "#3c4048",

  scrollbar_thumb = "#16181a",
  split = "#16181a",

  ansi = { "#16181a", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
  brights = { "#3c4048", "#ff6e5e", "#5eff6c", "#f1ff5e", "#5ea1ff", "#bd5eff", "#5ef1ff", "#ffffff" },
  indexed = { [16] = "#ffbd5e", [17] = "#ff6e5e" },
  tab_bar = {
    background = '#16181a',
    active_tab = {
      bg_color = '#3c4048',
      fg_color = '#ffbd5e',
      intensity = 'Bold',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },
    inactive_tab = {
      bg_color = '#1e2124',
      fg_color = '#7b8496',
    },
    inactive_tab_hover = {
      bg_color = '#1e2124',
      fg_color = '#bd5eff',
      italic = true,
    },
    new_tab = {
      bg_color = '#16181a',
      fg_color = '#7b8496',
    },
    new_tab_hover = {
      bg_color = '#3c4048',
      fg_color = '#bd5eff',
      italic = true,
    },
  },
}

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
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
    { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    { key = 'u', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
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
    { key = 'T', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = ')', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
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
