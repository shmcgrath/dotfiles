vim.bo.formatprg = "tombi format -"

require("lint").linters_by_ft = {
  toml = { "tombi", },
}
