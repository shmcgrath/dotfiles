vim.cmd("colorscheme cyberdream")
vim.opt.inccommand = "split"
vim.g.have_nerd_font = true -- from kickstart.nvim
-- vim.opt.clipboard = "unnamedplus"

vim.opt.winborder = "rounded"

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
