vim.opt.nu = true
vim.opt.scrolloff = 8

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false


-- netrw opens files by absolute path, and vim only shortens buffer names
-- relative to cwd when the directory changes. Re-"cd" to the current dir
-- (preserving its scope) so names stay relative.
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.bo.buftype ~= "" then return end
        local cmd = "cd"
        if vim.fn.haslocaldir() == 1 then
            cmd = "lcd"
        elseif vim.fn.haslocaldir(-1, 0) == 1 then
            cmd = "tcd"
        end
        vim.cmd("noautocmd silent " .. cmd .. " " .. vim.fn.fnameescape(vim.fn.getcwd()))
    end,
})
