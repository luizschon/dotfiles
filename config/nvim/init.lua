local core_conf_files = {
  "mappings.lua", -- all the user-defined mappings
  "plugins.lua", -- all the plugins installed and their configurations
  "colorscheme.lua", -- colorscheme settings
  "options.lua", -- colorscheme settings
}


require("mappings")
require("plugins")
require("colorscheme")
require("options")
