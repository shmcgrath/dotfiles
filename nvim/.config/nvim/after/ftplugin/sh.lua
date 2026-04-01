vim.cmd([[
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
]])

require("conform").formatters_by_ft.sh = { "shfmt" }

require("lint").linters_by_ft = {
  sh = { "shellcheck", "bashls", },
}
