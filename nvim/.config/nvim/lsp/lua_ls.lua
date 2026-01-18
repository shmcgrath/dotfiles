---@type vim.lsp.Config
-- https://github.com/LuaLS/lua-language-server
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
  },
  settings = {
    Lua = {
      workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
      runtime = {
        version = "LuaJIT",
      },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim" },
      },
      signatureHelp = {
        enabled = true,
      },
      hint = {
        enable = true,
        arrayIndex = "Disable",
      },
    },
  },
}
