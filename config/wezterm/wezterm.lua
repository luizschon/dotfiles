local wezterm = require("wezterm")
local config = wezterm.config_builder()

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function get_color_scheme()
	if get_appearance():find("Dark") then
		return "Apple System Colors"
	end
	return "Alabaster"
end

local function get_process_name(pane)
	local path = pane:get_foreground_process_name()

	if not path then
		return ""
	end

	return path:gsub("(.*[/\\])(.*)", "%2"):gsub("%.exe$", ""):lower()
end

local default_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

local no_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

local no_padding_procs = {
	["nvim"] = true,
	["vim"] = true,
}

config.font = wezterm.font_with_fallback({
	{
		family = "Iosevka Habamax",
		weight = "Regular",
	},
})
config.font_size = 12
config.color_scheme = get_color_scheme()
config.hide_tab_bar_if_only_one_tab = true
config.initial_rows = 27
config.initial_cols = 80
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 144
config.cursor_blink_rate = 600
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"
config.enable_wayland = false
config.window_padding = default_padding

wezterm.on("update-status", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local process = get_process_name(pane)
	local padding = no_padding_procs[process] and no_padding or default_padding

	overrides.window_padding = padding
	window:set_config_overrides(overrides)
end)

return config
