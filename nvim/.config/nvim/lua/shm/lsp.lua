-- h: lsp-attach h: lsp-config

local symbol_kinds = require("shm.icons").symbol_kinds

vim.lsp.protocol.SymbolKind = {
  symbol_kinds.File,
  symbol_kinds.Module,
  symbol_kinds.Namespace,
  symbol_kinds.Package,
  symbol_kinds.Class,
  symbol_kinds.Method,
  symbol_kinds.Property,
  symbol_kinds.Field,
  symbol_kinds.Constructor,
  symbol_kinds.Enum,
  symbol_kinds.Interface,
  symbol_kinds.Function,
  symbol_kinds.Variable,
  symbol_kinds.Constant,
  symbol_kinds.String,
  symbol_kinds.Number,
  symbol_kinds.Boolean,
  symbol_kinds.Array,
  symbol_kinds.Object,
  symbol_kinds.Key,
  symbol_kinds.Null,
  symbol_kinds.EnumMember,
  symbol_kinds.Struct,
  symbol_kinds.Event,
  symbol_kinds.Operator,
  symbol_kinds.TypeParameter,
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

local diag_icons = require("shm.icons").diagnostics
vim.fn.sign_define("DiagnosticSignError", {
  text = diag_icons.ERROR,
  texthl = "DiagnosticSignError",
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = diag_icons.WARN,
  texthl = "DiagnosticSignWarn",
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = diag_icons.INFO,
  texthl = "DiagnosticSignInfo",
})

vim.fn.sign_define("DiagnosticSignHint", {
  text = diag_icons.HINT,
  texthl = "DiagnosticSignHint",
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diag_icons.ERROR,
      [vim.diagnostic.severity.WARN] = diag_icons.WARN,
      [vim.diagnostic.severity.INFO] = diag_icons.INFO,
      [vim.diagnostic.severity.HINT] = diag_icons.HINT,
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
    prefix = function(diag)
      return string.format("%s ", diag_icons[vim.diagnostic.severity[diag.severity]])
    end,
    scope = "cursor",
    close_events = { "CursorMoved", "BufLeave", "WinLeave", "InsertEnter" },
  })
end, { noremap = true, silent = true, desc = "Show enhanced diagnostics float" })
