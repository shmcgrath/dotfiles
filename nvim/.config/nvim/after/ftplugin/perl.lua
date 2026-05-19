vim.cmd([[
  setlocal expandtab
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
]])

vim.bo.formatprg = "perltidy --standard-output"

require("lint").linters_by_ft = {
  perl = { "perlcritic", },
}
