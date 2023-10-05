-- Bootstrap the packer.nvim plugin manager
local ensure_packer = function()
    local packerpath = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if vim.fn.empty(vim.fn.glob(packerpath)) > 0 then
        vim.fn.system({
            "git",
            "clone",
            "--depth", "1",
            "https://github.com/wbthomason/packer.nvim",
            packerpath
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    -- Colorscheme
    use { "catppuccin/nvim", as = "catppuccin" }
    -- LSP and autocompletion support
    use "hrsh7th/nvim-cmp"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    -- use "hrsh7th/cmp-path"
    -- use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "L3MON4D3/LuaSnip"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- LSP and Autocompletion setup/config ---------------------------------------

local capabilites = require("cmp_nvim_lsp").default_capabilities()
local lspconfig   = require("lspconfig")

-- Enable lsp servers with cmp capabilites
local servers = { "clangd", "rust_analyzer", "pyright", "tsserver" }
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

