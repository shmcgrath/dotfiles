---@type vim.lsp.Config
-- https://tombi-toml.github.io/tombi/
return {
  cmd = { "tombi", "lsp" },
  filetypes = { "toml" },
  root_markers = {
    "tombi.toml",
    "pyproject.toml",
    ".git",
  },
}
