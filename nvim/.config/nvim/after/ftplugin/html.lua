-- fix htmldjango filetype annoyance
vim.api.nvim_create_augroup("force_html", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  pattern = "*.html",
  group = "force_html",
  callback = function()
    vim.opt_local.filetype = "html"
  end,
})

vim.opt_local.colorcolumn = "80"
vim.opt_local.foldmethod = "syntax"
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

vim.cmd("let b:ale_linters = ['htmlhint']")

if vim.g.ale_html_htmlhint_options == nil then
  vim.g.ale_html_htmlhint_options = "--config " .. vim.fn.expand("~/.config/htmlhint/htmlhint.conf")
end

