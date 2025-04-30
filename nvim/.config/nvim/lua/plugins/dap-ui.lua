require("dapui").setup({
})

local widgets = require("dap.ui.widgets")

vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
  widgets.hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
  widgets.preview()
end)
vim.keymap.set("n", "<Leader>df", function()
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
  widgets.centered_float(widgets.scopes)
end)
