require("dapui").setup({
})

local widgets = require("dap.ui.widgets")

vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
  widgets.hover()
end, {
  noremap = true,
  silent = true,
  desc = "dap-ui hover",
})

vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
  widgets.preview()
end, {
  noremap = true,
  silent = true,
  desc = "dap-ui preview",
})

vim.keymap.set("n", "<Leader>df", function()
  widgets.centered_float(widgets.frames)
end, {
  noremap = true,
  silent = true,
  desc = "dap-ui centered float frames",
})

vim.keymap.set("n", "<Leader>ds", function()
  widgets.centered_float(widgets.scopes)
end, {
  noremap = true,
  silent = true,
  desc = "dap-ui centered float scope",
})
