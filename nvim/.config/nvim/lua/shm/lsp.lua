--[[
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "gc", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    if client:supports_method("textDocument/implementation") then
      vim.keymap.set("n", "gK", vim.lsp.buf.implementation, keyopts)
    end
    if client:supports_method("textDocument/completion") then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end,
})
--grn in Normal mode maps to vim.lsp.buf.rename()
--grr in Normal mode maps to vim.lsp.buf.references()
--gri in Normal mode maps to vim.lsp.buf.implementation()
--gO in Normal mode maps to vim.lsp.buf.document_symbol() (this is analogous to the gO mappings in help buffers and :Man page buffers to show a “table of contents”)
--gra in Normal and Visual mode maps to vim.lsp.buf.code_action()
--CTRL-S in Insert and Select mode maps to vim.lsp.buf.signature_help()
--[d and ]d move between diagnostics in the current buffer ([D jumps to the first diagnostic, ]D jumps to the last)
-- Create a keymap for vim.lsp.buf.implementation ...
-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|

--]]
-- Setup language servers.
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
