vim.cmd([[
  setlocal foldmethod=syntax
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
  setlocal colorcolumn=101
]])

require("conform").formatters_by_ft.javascript = { "eslint" }

require("lint").linters_by_ft = {
  javascript = { "eslint", },
}
