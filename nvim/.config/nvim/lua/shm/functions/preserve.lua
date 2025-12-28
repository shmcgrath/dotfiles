-- Preserve: A Vim Function that keeps your state
-- https://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
-- Used this in vim, not sure if needed in nvim
-- I migrated everything just in case

local M = {}

function M.preserve(cmd)
    local search = vim.fn.getreg("/")
    local pos = vim.api.nvim_win_get_cursor(0)

    vim.cmd(cmd)

    vim.fn.setreg("/", search)
    vim.api.nvim_win_set_cursor(0, pos)
end

return M
