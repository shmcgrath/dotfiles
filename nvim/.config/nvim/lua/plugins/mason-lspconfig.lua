require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "lua_ls",
    "rust_analyzer",
    "vimls",
    "yamlls",
  },
})
