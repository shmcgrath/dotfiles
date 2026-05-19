vim.cmd([[
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
]])

vim.bo.formatprg = "shfmt --filename %"

require("lint").linters_by_ft = {
  sh = { "shellcheck", "bashls", },
}
