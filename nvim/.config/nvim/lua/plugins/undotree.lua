vim.keymap.set("n", "<leader><F5>", ":UndotreeToggle<CR>", { noremap = true, silent = true })

-- set undodir if undotree is installed
if vim.fn.has("persistent_undo") == 1 then
    local target_path = vim.fn.expand("~/.local/state/nvim/undodir")

    -- Create the directory if it doesn't exist
    if vim.fn.isdirectory(target_path) == 0 then
        vim.fn.mkdir(target_path, "p", "0700")
    end

    -- Set undodir and enable persistent undo
    vim.opt.undodir = target_path
    vim.opt.undofile = true
end
