-- h: lsp-attach
-- h: lsp-config
vim.lsp.protocol.SymbolKind = {
  '󰈙', -- File
  '󰏗', -- Module
  '󰌗', -- Namespace
  '󰏖', -- Package
  '󰠱', -- Class
  '󰆧', -- Method
  '󰜢', -- Property
  '󰜢', -- Field
  '', -- Constructor
  '', -- Enum
  '', -- Interface
  '󰊕', -- Function
  '󰀫', -- Variable
  '󰏿', -- Constant
  '󰀬', -- String
  '󰎠', -- Number
  '󰨙', -- Boolean
  '󰅪', -- Array
  '󰅩', -- Object
  '󰌋', -- Key
  '󰟢', -- Null
  '', -- EnumMember
  '󰙅', -- Struct
  '', -- Event
  '󰆕', -- Operator
  '󰊄', -- TypeParameter
}

local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
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
-- https://github.com/neovim/nvim-lspconfig
vim.lsp.enable({
  "bashls",
  "gopls",
  "lua_ls",
  "sqlls",
  "tinymist",
  "tombi",
  "vimls",
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "🆇",
      [vim.diagnostic.severity.WARN] = "⚠",
      [vim.diagnostic.severity.INFO] = "ℹ",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  severity_sort = true,
  underline = true,
  update_in_insert = false,
})

vim.keymap.set("n", "<C-w>d", function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
    border = "double",
    source = true,
    header = "Diagnostics",
    prefix = "● ",
    scope = "cursor",
    close_events = { "CursorMoved", "BufLeave", "WinLeave", "InsertEnter" },
  })
end, { noremap = true, silent = true, desc = "Show enhanced diagnostics float" })
