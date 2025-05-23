--@type vim.lsp.Config
local s = vim.empty_dict()

s.gopls = {
  completeUnimported = true,
  usePlaceholders = true,
  analyses = {
    unusedparams = true,
  },
  ["ui.inlayhint.hints"] = {
    compositeLiteralFields = true,
    constantValues = true,
    parameterNames = true,
    rangeVariableTypes = true,
  },
}

return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod" },
  settings = s
}
