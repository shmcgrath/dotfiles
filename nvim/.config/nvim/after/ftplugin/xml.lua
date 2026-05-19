vim.bo.formatprg = "yq eval --prettyPrint -"

require("lint").linters_by_ft = {
  xml = { "yq", },
}
