vim.cmd("colorscheme cyberdream")
vim.opt.inccommand = "split"
-- vim.opt.clipboard = "unnamedplus"

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.keymap.set("n", "<C-w>d", function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
    border = "rounded",
    source = "always",
    header = "Diagnostics",
    prefix = "● ",
    scope = "cursor",
  })
end, { desc = "Show enhanced diagnostics float" })
