local wezterm = require 'wezterm'
local config = {}

local function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return 'Dark'
end

local function get_color_scheme()
    if get_appearance():find 'Dark' then
        return 'Apple System Colors'
    end
    return 'Alabaster'
end

config.font = wezterm.font_with_fallback({
    'JetBrainsMono Nerd Font',
    'Liberation Mono',
    'Apple Color Emoji',
    'Noto Color Emoji',
})
config.font_size = 12.0
config.color_scheme = get_color_scheme()
config.hide_tab_bar_if_only_one_tab = true
config.initial_rows = 27
config.initial_cols = 80
config.default_cursor_style = 'BlinkingBlock'
config.animation_fps = 144
config.cursor_blink_rate = 380
config.window_close_confirmation = 'NeverPrompt'
config.audible_bell = 'Disabled'

return config
