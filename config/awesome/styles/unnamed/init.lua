local awful = require('awful')
require('styles.unnamed.widgets.bar')
local widgets = require('styles.unnamed.widgets')

awful.screen.connect_for_each_screen(function (s)
    widgets.taskdock {
        screen = s,
    }
end)
