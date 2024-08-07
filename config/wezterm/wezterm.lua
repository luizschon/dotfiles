local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font_with_fallback({
    'JetBrainsMono Nerd Font',
    'Liberation Mono',
    'Apple Color Emoji',
    'Noto Color Emoji',
})
config.font_size = 12.0
config.color_scheme = 'Ayu Dark (Gogh)'
config.hide_tab_bar_if_only_one_tab = true
config.initial_rows = 28
config.initial_cols = 78

return config
