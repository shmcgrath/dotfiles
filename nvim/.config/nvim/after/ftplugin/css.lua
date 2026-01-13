vim.opt_local.colorcolumn = "80"
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

vim.cmd("let b:ale_linters = ['stylelint']")

if vim.g.ale_css_stylelint_options == nil then
  vim.g.ale_css_stylelint_options = "--config " .. vim.fn.expand("~/.config/stylelint/stylelint.config.js")
end

