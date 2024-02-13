local awful      = require('awful')
local gears      = require('gears')
local wibox      = require('wibox')
local beautiful  = require('beautiful')
local dpi        = beautiful.xresources.apply_dpi

local TaskDock = {
    mt = {}
}

local border_width = dpi(5)

local tasklist_btns = gears.table.join( awful.button({}, 1, function (c) if c == client.focus then c.minimized = true else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function ()
        awful.client.focus.byidx(-1)
    end),
    awful.button({}, 5, function ()
        awful.client.focus.byidx(1)
    end)
)

function TaskDock:show(val)
    self.visible = val or true

    if val == true then
        
    else

    end
end

function TaskDock:toggle()
    self:show(not self.visible)
end

function TaskDock:new(args)
    args.screen  = args.screen or screen.primary
    args.filter  = args.filter or awful.widget.tasklist.filter.currenttags
    args.buttons = args.buttons or tasklist_btns

    local tasklist = awful.widget.tasklist {
        screen = args.screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = args.buttons,
        layout = {
            spacing = dpi(12),
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            widget = wibox.container.background,
            bg = beautiful.tasklist_bg_normal,
            shape = gears.shape.rounded_rect,
            border_width = border_width,
            border_color = beautiful.tasklist_fg_normal,
            border_strategy = 'none',
            {
                margins = dpi(10),
                widget = wibox.container.margin,
                {
                    id = 'clienticon',
                    widget = awful.widget.clienticon,
                    forced_width = dpi(80),
                    forced_height = dpi(80),
                },
            },

            create_callback = function (self, c, index, obj)
                if c == client.focus then
                    self.bg = beautiful.tasklist_bg_focus or beautiful.tasklist_bg_normal
                    self.border_width = border_width
                else
                    self.bg = beautiful.tasklist_bg_normal
                    self.border_width = 0
                end

                self:connect_signal('mouse::enter', function ()
                    self.bg = beautiful.tasklist_bg_focus or beautiful.tasklist_bg_normal
                end)
                self:connect_signal('mouse::leave', function ()
                    if c ~= client.focus then
                        self.bg = beautiful.tasklist_bg_normal
                    end
                end)
            end,

            update_callback = function (self, c, index, obj)
                if c == client.focus then
                    self.bg = beautiful.tasklist_bg_focus or beautiful.tasklist_bg_normal
                    self.border_width = border_width
                else
                    self.bg = beautiful.tasklist_bg_normal
                    self.border_width = 0
                end
            end,
        }

    }

    local taskdock = awful.popup {
        widget = tasklist,
        bg = '#00000000',
        layout = wibox.layout.fixed.horizontal,
        screen = args.screen,
        ontop = false,
        type = 'dock',
    }

    awful.placement.bottom(taskdock, {
        attach = true,
        update_workarea = false,
        margins = { bottom = dpi(35) },
        honor_workarea = true,
    })

    local obj = {}
    self.__index = self
    setmetatable(obj, self)
    obj.visible = false
    obj.taskdock = taskdock
    obj.visible = false

    obj:show(false)

    return obj
end

function TaskDock.mt:__call(...)
    return TaskDock:new(...)
end

return setmetatable(TaskDock, TaskDock.mt)
