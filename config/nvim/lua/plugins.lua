-- Bootstrap the lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "wbthomason/packer.nvim",
    -- Colorscheme
    { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
    -- LSP and autocompletion support
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",
    -- "hrsh7th/cmp-path",
    -- "hrsh7th/cmp-cmdline",
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    -- Editor functionality
    "lervag/vimtex",
})

-- LSP and Autocompletion setup/config -----------------------------------------

local capabilites = require("cmp_nvim_lsp").default_capabilities()
local lspconfig   = require("lspconfig")

-- Enable lsp servers with cmp capabilites
local servers = { "clangd", "rust_analyzer", "pyright", "tsserver", "texlab" }
for _, server in ipairs(servers) do
    lspconfig[server].setup({
        capabilities = capabilities,
    })
end

local luasnip = require("luasnip")
local cmp     = require("cmp")

-- Nvim-cmp setup
cmp.setup({
    -- Uses luasnip as the snippet engine
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
    end
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }),
    mapping = cmp.mapping.preset.insert({
        ["<C-space>"] = cmp.mapping.complete(),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ["<S-Tab>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' })
    }),
})

-- Uses buffer for '/' and '?' search commands
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "buffer" },
    })
})

-- Vimtex setup and configuration ----------------------------------------------

vim.g.vimtex_view_method = "mupdf"
vim.g.vimtex_compiler_method = "latexmk"

