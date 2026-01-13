vim.opt_local.colorcolumn = "101"
vim.opt_local.foldmethod = "syntax"
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

vim.cmd("let b:ale_fixers = {'javascript': ['eslint']}")
vim.cmd("let b:ale_linters = {'javascript': ['eslint']}")
