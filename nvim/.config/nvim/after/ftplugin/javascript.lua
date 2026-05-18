vim.cmd([[
  setlocal foldmethod=syntax
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
  setlocal colorcolumn=101
]])

vim.bo.formatprg = "eslint --fix-dry-run --stdin --stdin-filename %"

require("lint").linters_by_ft = {
  javascript = { "eslint", },
}
