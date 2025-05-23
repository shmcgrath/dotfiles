capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
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

if next(capabilities) == nil then
  capabilities = vim.empty_dict()
end

vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.notify("LSP: " .. client.name, vim.log.levels.INFO)
  end,
  root_markers = { ".git" },
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
