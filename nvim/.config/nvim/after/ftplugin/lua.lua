vim.cmd([[
  setlocal expandtab
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
  setlocal colorcolumn=100
  setlocal textwidth=100
]])

vim.bo.formatprg = "stylua --config-path ~/.config/stylua/stylua.toml -"
