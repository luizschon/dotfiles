local awful        = require('awful')
local beautiful    = require('beautiful')
local xresources   = require('beautiful.xresources')
local gfs          = require('gears.filesystem')
local font         = require('utils.font')
local dpi          = xresources.apply_dpi

local themes_path = gfs.get_configuration_dir() .. 'themes'
local curr_theme_path = gfs.get_configuration_dir() .. 'themes/unnamed'
local theme = {}

theme.wallpaper = curr_theme_path .. '/wallpapers/wallpaper2.jpg'

-- Default font and font configurarion.
theme.default_font   = 'SF Pro Text'
theme.monospace_font = 'SF Mono'
theme.font_size      = 10
theme.font           = font.set_font(theme.default_font, theme.font_size)

theme.bg_normal     = '#222222'
theme.bg_focus      = '#535d6c'
theme.bg_urgent     = '#ff0000'
theme.bg_minimize   = '#444444'
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = '#aaaaaa'
theme.fg_focus      = '#ffffff'
theme.fg_urgent     = '#ffffff'
theme.fg_minimize   = '#ffffff'

theme.useless_gap   = dpi(7)
theme.border_width  = dpi(1)
theme.border_normal = '#000000'
theme.border_focus  = '#535d6c'
theme.border_marked = '#91231c'

-- Taglist theme variables.
theme.taglist_bg_focus    = '#ff0000'
theme.taglist_fg_focus    = '#000000'
theme.taglist_fg_empty    = '#000000'
theme.taglist_bg_empty    = theme.bg_normal
theme.taglist_fg_occupied = '#000000'
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_font = 'SF Mono 12'

-- Tasklist theme variables
theme.tasklist_fg_normal = '#333333'
theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus  = '#111111'
theme.tasklist_fg_focus  = '#000000'
theme.tasklist_bg_urgent = '#111111'
theme.tasklist_fg_urgent = '#000000'

-- titlebar
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

beautiful.init(theme)

