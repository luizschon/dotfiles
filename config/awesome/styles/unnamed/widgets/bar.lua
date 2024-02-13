local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local taglist   = require('styles.unnamed.widgets.taglist')
local dpi       = beautiful.xresources.apply_dpi

local bar_width = dpi(55)

local create_left_bar = function (s)
    local _taglist = taglist.apply_taglist(s)

    s.left_bar = awful.wibar({
        screen = s,
        position = 'left',
        visible = true,
        ontop = false,
        type = "dock",
        width = bar_width,
        height = 0.75 * s.geometry.height,
        shape = gears.shape.rounded_rect,
        margins = { left = beautiful.useless_gap },
    })

    s.left_bar:setup({
        layout = wibox.layout.flex.vertical,
        _taglist,
        awful.widget.keyboardlayout(),
        wibox.widget.textclock(),
    })

end

awful.screen.connect_for_each_screen(function (s)
    create_left_bar(s)
end)

