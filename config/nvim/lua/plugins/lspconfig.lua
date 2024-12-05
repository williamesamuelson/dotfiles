return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = {
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"},
            {'hrsh7th/cmp-nvim-lsp'},
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-path"},
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-nvim-lsp-signature-help"},
            {"L3MON4D3/LuaSnip"},
            {"saadparwaiz1/cmp_luasnip"},
        },

        config = function()
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local lsp_capabilities = cmp_lsp.default_capabilities()

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "julials",
                    "marksman",
                    "pyright",
                },
                handlers = {
                    -- default setup
                    function(server_name)
                        require("lspconfig")[server_name].setup {
                            capabilities = lsp_capabilities
                        }
                    end,

                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilities = lsp_capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = {"vim"},
                                    }
                                }
                            }
                        }
                    end,

                    ["pyright"] = function()
                        local lspconfig = require("lspconfig")
                        -- Automatically detect the active Conda environment
                        local conda_env = os.getenv("CONDA_PREFIX") -- Set by Conda when an environment is active
                        local python_path = conda_env and (conda_env .. "/bin/python") or vim.fn.exepath("python3")

                        lspconfig.pyright.setup {
                            on_attach = function(client, bufnr)
                                -- Notify if Conda is not active
                                if not conda_env then
                                    print("Warning: No active Conda environment detected!")
                                end
                            end,
                            settings = {
                                python = {
                                    pythonPath = python_path,
                                    analysis = {
                                        autoSearchPaths = true,
                                        diagnosticMode = "workspace",
                                        useLibraryCodeForTypes = true,
                                    },
                                },
                            },
                        }
                    end,
                }
            })

            cmp.setup({
                sources = cmp.config.sources({
                    {name = "nvim_lsp"},
                    {name = "luasnip"},
                    {name = "path"},
                    {name = "buffer"},
                    {name = 'nvim_lsp_signature_help'},
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<C-y>'] = cmp.mapping.confirm({select = true}),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })

            -- LSP keymaps
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end, opts)
                end
            })
        end
    }
}

