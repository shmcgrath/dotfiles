---@type vim.lsp.Config
-- https://github.com/LuaLS/lua-language-server
return {
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_markers = {
    "Gemfile",
    ".git",
  },
  init_options = { formatting = true },
  settings = {
    solargraph = {
      diagnostics = true
    }
  },
}
