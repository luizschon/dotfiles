return {
    {
        "hrsh7th/nvim-cmp",
        version = false,
        dependencies = {
            "neovim/nvim-lspconfig",
            -- Cmp sources
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            -- Luasnip requirements
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        opts = function ()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            return {
                -- Uses luasnip as the snippet engine
                snippet = {
                    expand = function (args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
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
                })
            }
        end,
        init = function (_, opts)
            local cmp = require("cmp")

            -- Setup plugin with opts defined above
            cmp.setup(opts)

            -- Uses buffer for '/' and '?' search commands
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "buffer" },
                })
            })

            -- Uses cmdline and path sources for ':' commands
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    },
    {
        "lervag/vimtex",
        config = function ()
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_view_method = "mupdf"
        end
    },
}
