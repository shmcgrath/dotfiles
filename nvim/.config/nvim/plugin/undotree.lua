--[[
vim.pack.add({
  {
    src = "https://github.com/mbbill/undotree",
  },
})
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
]]

vim.o.undofile = true
vim.o.undodir = vim.fn.expand("$HOME/.local/state/nvim/undodir")
vim.o.undolevels = 1000
vim.o.undoreload = 10000

-- 2026-03-31 trialing built in undotree in neovim

vim.cmd("packadd nvim.undotree")

vim.keymap.set("n", "<F5>", function()
  require("undotree").open({
    command = "topleft " .. math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew"
  })
end, {
  noremap = true,
  silent = true,
	desc = "toggle undotree",
})

-- this was the else of a persistent_undo check in vim
-- vim.o.undodir = vim.fn.expand("$HOME/.local/state/nvim/undo//")
-- vim.notify("persistent_undo not set", vim.log.levels.WARN)
