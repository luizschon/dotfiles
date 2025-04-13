local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font_with_fallback({
    'JetBrainsMono Nerd Font',
    'Liberation Mono',
    'Apple Color Emoji',
    'Noto Color Emoji',
})
config.font_size = 12.0
config.color_scheme = 'Argonaut (Gogh)'
config.hide_tab_bar_if_only_one_tab = true
config.initial_rows = 25
config.initial_cols = 78
config.default_cursor_style = 'BlinkingBlock'
config.animation_fps = 144
config.cursor_blink_rate = 380
config.window_close_confirmation = 'NeverPrompt'

return config
