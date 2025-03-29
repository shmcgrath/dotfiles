-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Apply local themes, etc
local cyberdream_colors = require('cyberdream')
local apply_shm_theme = require('shm-theme')

config.colors = cyberdream_colors
apply_shm_theme(config)

-- This is where you actually apply your config choices
config.font = wezterm.font('CommitMono Nerd Font Mono')
config.font_size = 13.0
--config.color_scheme = 'Eldorado dark (terminal.sexy)'
--config.color_scheme = 'Eldritch'


-- and finally, return the configuration to wezterm
return config
