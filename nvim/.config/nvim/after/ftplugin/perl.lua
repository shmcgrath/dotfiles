vim.cmd([[
  setlocal expandtab
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
]])

require("conform").formatters_by_ft.perl = { "perltidy" }

require("lint").linters_by_ft = {
  perl = { "perlcritic", },
}
