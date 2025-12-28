-- Set tabstop, softtabstop, and shiftwidth to the same value

local M = {}

function M.set_tabs()
    local input = vim.fn.input("set tabstop = softtabstop = shiftwidth = ")
    local n = tonumber(input)

    if not n or n <= 0 then
        return
    end

    vim.opt_local.tabstop = n
    vim.opt_local.shiftwidth = n
    vim.opt_local.softtabstop = n

    require("shm.functions.summarize-tabs").summarize()
end
