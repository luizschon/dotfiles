return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        flavour = "macchiato",
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
        },
        integrations = {
            cmp = true,
            gitsigns = true,
            treesitter = true,
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    },
    init = function ()
        vim.cmd.colorscheme("catppuccin")
    end
}

