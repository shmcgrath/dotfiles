require("conform").formatters_by_ft.sql = { "sqlfluff" }

require("lint").linters_by_ft = {
  sql = { "sqlfluff", },
}
