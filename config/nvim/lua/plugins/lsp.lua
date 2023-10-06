return {
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        opts = {
            servers = { 
                "clangd", "rust_analyzer", "pyright", "tsserver", "texlab",
                "lua_ls", 
            },
        },
        config = function (_, opts)
            local servers = opts.servers

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities() or {},
                opts.capabilities or {}
            )

            for _, server in ipairs(servers) do
                require("lspconfig")[server].setup({
                    capabilities = capabilities,
                })
            end
        end
    },
}

