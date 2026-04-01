-- fix htmldjango filetype annoyance
vim.api.nvim_create_augroup("force_html", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  pattern = "*.html",
  group = "force_html",
  callback = function()
    vim.opt_local.filetype = "html"
  end,
})

vim.cmd([[
  setlocal foldmethod=syntax
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
  setlocal colorcolumn=80
]])

require("lint").linters_by_ft = {
  html = { "htmlhint", },
}

require("lint").linters.htmlhint.args = vim.list_extend({
  "--config",
  vim.fn.expand("~/.config/htmlhint/htmlhint.conf"),
}, vim.deepcopy(require("lint").linters.htmlhint.args or {}))
