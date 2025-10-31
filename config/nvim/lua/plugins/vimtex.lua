return {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    init = function()
      -- VimTeX configuration goes here
        vim.g.vimtex_view_method = "skim"
        vim.g.vimtex_compiler_latexmk = {
            out_dir = 'build',
        }
        vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1

    end
}
