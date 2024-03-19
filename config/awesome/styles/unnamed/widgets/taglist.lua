local M = {}

local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local font      = require('utils.font')
local dpi       = beautiful.xresources.apply_dpi

-- Setup in root rc.lua and import instead
local modkey = 'Mod4'

local taglist_btns = gears.table.join(
    awful.button({}, 1, function (t) t:view_only() end),
    awful.button({ modkey }, 1, function (t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({}, 3, function (t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({}, 4, function (t) awful.tag.viewprev(t.screen) end),
    awful.button({}, 5, function (t) awful.tag.viewnext(t.screen) end)
)

local taglist_template = {
    {
        {
            id = 'index_role',
            widget = wibox.widget.textbox,
            font = font.monospace_with_size(13),
            align = 'center',
            valign = 'center',
        },
        margins = dpi(6),
        widget = wibox.container.margin,
    },
    id     = 'background_role',
    widget = wibox.container.background,

    -- Add support for hover colors and an index label
    create_callback = function(self, c3, index, objects) --luacheck: no unused args
        self:get_children_by_id('index_role')[1].markup = c3.index
        self:connect_signal('mouse::enter', function()
            if self.bg ~= '#ff0000' then
                self.backup     = self.bg
                self.has_backup = true
            end
            self.bg = '#ff0000'
        end)
        self:connect_signal('mouse::leave', function()
            if self.has_backup then self.bg = self.backup end
        end)
    end,
}

M.apply_taglist = function (s)
    return awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = { shape = gears.shape.circle },
        layout = { spacing = dpi(10), layout = wibox.layout.fixed.vertical },
        widget_template = taglist_template,
        buttons = taglist_btns
    })
end

return M
