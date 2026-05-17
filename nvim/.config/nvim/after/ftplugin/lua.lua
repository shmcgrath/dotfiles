vim.cmd([[
  setlocal expandtab
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
  setlocal colorcolumn=100
  setlocal textwidth=100
]])

vim.bo.formatprg = "stylua --config-path ~/.config/stylua/stylua.toml -"

require("conform").formatters.stylua = {
  append_args = { "--config-path", vim.fn.expand("~/.config/stylua/stylua.toml") },
}
require("conform").formatters_by_ft.lua = { "stylua" }
