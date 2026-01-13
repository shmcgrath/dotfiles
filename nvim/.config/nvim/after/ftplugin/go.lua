vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4
vim.opt_local.textwidth = 90
vim.opt_local.colorcolumn= "90"

vim.cmd("let b:ale_fixers = ['goimports', 'gofmt']")
vim.cmd("let b:ale_linters = ['gobuild', 'govet']")
-- let b:ale_linters = ['gobuild', 'staticcheck']
