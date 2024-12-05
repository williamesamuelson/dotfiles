return {
    "rose-pine/neovim",
    name = "rose-pine",
    styles = { italic = false },
    config = function()
        vim.cmd([[colorscheme rose-pine]])
    end
}
