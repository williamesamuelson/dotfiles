return {
  {
    'github/copilot.vim',
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.cmd("Copilot disable")
        end,
      })
    end,
  },
}
