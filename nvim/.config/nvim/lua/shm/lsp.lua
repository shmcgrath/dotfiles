local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend("force", capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
  semanticTokens = {
    multilineTokenSupport = true,
  },
})

capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
  on_attach = function(client, bufnr)
    print("LSP: " .. client.name)
    vim.diagnostic.enable(true, { buf = bufnr })
  end,
})

-- Enable each language server by filename under the lsp/ folder
-- more information on ls: https://www.andersevenrud.net/neovim.github.io/lsp/
vim.lsp.enable({
  "bashls",
  "gopls",
  "lua_ls",
  "vimls",
  "yamlls",
  "zls",
})
