vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2
vim.opt_local.textwidth = 100
vim.opt_local.colorcolumn = "100"

vim.cmd("let b:ale_fixers = ['stylua']")

if vim.g.ale_lua_stylua_options == nil then
  vim.g.ale_lua_stylua_options = "--config-path " .. vim.fn.expand("~/.config/stylua/stylua.toml")
end
