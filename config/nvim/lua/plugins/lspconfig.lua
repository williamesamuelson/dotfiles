return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "micangl/cmp-vimtex",
        },
        config = function()
            -- Set up mason
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "pyright" }
            }

            -- Get enhanced capabilities
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local cmp = require("cmp")

            -- Setup LSPs manually
            vim.lsp.config('lua_ls', {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
            vim.lsp.enable('lua_ls')

            vim.lsp.enable('julials')

            vim.lsp.config('pyright', {
                capabilities = capabilities,
            })
            vim.lsp.enable('pyright')

            -- Setup nvim-cmp
            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "vimtex" },
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-x>'] = cmp.mapping.complete(),
                }),
            })

            -- LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("LspKeymaps", {}),
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, opts)
                end,
            })
        end,
    },
}
