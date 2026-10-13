return {
  {
    'github/copilot.vim',
    init = function()
      vim.g.copilot_filetypes = { tex = false }
    end,
  },
}
