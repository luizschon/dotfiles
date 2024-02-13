local M = {}

local beautiful = require('beautiful')

-- Fallback font if font_name or font field are not initialized by the theme or
-- beautiful.init() was not called yet.
local default_font = 'sans'
local default_mono_font = 'monospace'

M.default_with_size = function (size)
    if beautiful.default_font ~= nil and beautiful.default_font ~= '' then
        return beautiful.font_name .. ' ' .. size
    elseif beautiful.font ~= nil and beautiful.font ~= '' then
        local font_name = beautiful.font:match('%w+')
        return font_name .. ' ' .. size
    else
        return default_font .. ' ' .. size
    end
end

M.monospace_with_size = function (size)
    if beautiful.monospace_font ~= nil and beautiful.monospace_font ~= nil then
        return beautiful.monospace_font .. ' ' .. size
    else
        return default_mono_font .. ' ' .. size
    end
end

M.set_font = function (fontname, size)
    return fontname .. ' ' .. size
end

return M
