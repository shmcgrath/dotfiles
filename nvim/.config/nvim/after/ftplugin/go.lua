vim.cmd([[
  setlocal noexpandtab
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
  setlocal colorcolumn=90
  setlocal textwidth=90
]])

-- how to call two programs with formatprg
-- need goimports and gofmt
-- may need to call one manually
-- require("conform").formatters_by_ft.go = { "goimports", "gofmt" }

require("lint").linters_by_ft = {
  go = { "gobuild", "govet", },
  -- go = { "gobuild", "govet", "staticcheck" },
}
