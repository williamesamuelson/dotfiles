return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "julia", "python"},
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            additional_vim_regex_highlighting = false,
        })
    end
 }
