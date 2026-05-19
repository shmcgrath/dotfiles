vim.bo.formatprg = "sqlfluff fix --dialect postgres --stdin --disable-progress-bar"

require("lint").linters_by_ft = {
  sql = { "sqlfluff", },
}
