vim.cmd([[
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
  setlocal colorcolumn=80
]])

require("lint").linters.stylelint.args = vim.list_extend({
  "--config",
  vim.fn.expand("~/.config/stylelint/stylelint.config.js"),
}, vim.deepcopy(require("lint").linters.stylelint.args or {}))

require("lint").linters_by_ft = {
  css = { "stylelint", },
}
