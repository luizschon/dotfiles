local awful      = require('awful')
local gears      = require('gears')
local wibox      = require('wibox')
local beautiful  = require('beautiful')
local rubato     = require('third_party.rubato')
local dpi        = beautiful.xresources.apply_dpi

local TaskDock = {
    mt = {}
}
local border_width = dpi(5)
local icon_margin  = dpi(18)
local icon_size    = dpi(70)
local dock_spacing = dpi(12)
local dock_margin  = dpi(35)
local dock_height  = icon_size + 2 * icon_margin

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
    self.visible = val

    if self.visible == true then
        self.slide_in.target = self.screen.geometry.height - (dock_height + dock_margin)
    else
        self.slide_in.target = self.screen.geometry.height + dock_height
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
            spacing = dock_spacing,
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
                widget = wibox.container.place,
                valign = 'center',
                halign = 'center',
                {
                    widget = wibox.container.margin,
                    margins = icon_margin,
                    {
                        id = 'clienticon',
                        widget = awful.widget.clienticon,
                        forced_width = icon_size,
                        forced_height = icon_size,
                    },
                }
            },

            create_callback = function (self, c, index, obj)
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
        ontop = true,
        type = 'dock',
    }

    awful.placement.bottom(taskdock, {
        attach = true,
        honor_workarea = true,
        update_workspace = false,
        margins = { bottom = dock_margin },
    })

    local obj = {}

    obj.screen = args.screen
    obj.taskdock = taskdock
    obj.visible = false

    -- Slide-in animation using rubato, hardcoded for now.
    obj.slide_in = rubato.timed {
        awestore_compat = true,
        duration =  0.25,
        intro = 0.125,
        rate = 144,
        pos = args.screen.geometry.height,
        easing = rubato.easing.quadratic,
    }

    obj.slide_in:subscribe(function (pos)
        taskdock:geometry({ y = pos })
        taskdock:draw()
    end)

    obj.slide_in.ended:subscribe(function ()
        obj.taskdock.visible = obj.visible
    end)

    obj.slide_in.started:subscribe(function ()
        obj.taskdock.visible = true
    end)

    self.__index = self
    setmetatable(obj, self)

    obj:show(false)

    return obj
end

function TaskDock.mt:__call(...)
    return TaskDock:new(...)
end

return setmetatable(TaskDock, TaskDock.mt)
