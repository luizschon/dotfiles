local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local taglist   = require('styles.unnamed.widgets.taglist')
local dpi       = beautiful.xresources.apply_dpi

local bar_width = dpi(58)

local create_left_bar = function (s)
    local _taglist = taglist.apply_taglist(s)

    s.left_bar = awful.wibar({
        screen = s,
        position = 'left',
        visible = true,
        ontop = false,
        type = "dock",
        width = bar_width,
        height = s.geometry.height,
    })

    s.left_bar:setup({
        layout = wibox.layout.align.vertical,
        expand = 'outside',
        awful.widget.keyboardlayout(),
        _taglist,
        wibox.widget.textclock(),
    })

end

awful.screen.connect_for_each_screen(function (s)
    create_left_bar(s)
end)

