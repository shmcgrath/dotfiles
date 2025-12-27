-- Settings for [undotree](https://github.com/mbbill/undotree)
vim.keymap.set("n", "<F5>", "<cmd>UndotreeToggle<CR>", {
	noremap = true,
	silent = true,
	desc = "Toggle Undotree",
})

vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffpanelHeight = 8
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_HighlightChangedText = 1

if vim.fn.has("persistent_undo") == 1 then
    vim.o.undodir = vim.fn.expand("$HOME/.local/state/nvim/undodir//")
    vim.o.undolevels = 1000
    vim.o.undoreload = 10000
else
    vim.o.undodir = vim.fn.expand("$HOME/.local/state/nvim/undo//")
end

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        print("Undo dir: " .. vim.o.undodir)
    end,
})
