require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "lua_ls",
    "vimls",
    "yamlls",
  },
})
