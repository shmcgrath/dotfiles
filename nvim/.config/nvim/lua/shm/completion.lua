-- popup not working, follow this commit:
-- https://github.com/neovim/neovim/pull/32820
-- With lsp snippets yes, probably with plugin if you configure the “complete” option
-- h: completefunc
-- roadmap for snippet API: https://github.com/neovim/neovim/issues/25696
-- h: completeopt
vim.opt.completeopt = { "fuzzy", "noselect", "menuone", "popup" }

-- Make completion menu appear whenever you type something
-- from h: lsp-attach
-- Optional: trigger autocompletion on EVERY keypress. May be slow!
local symbol_kinds = require("shm.icons").symbol_kinds

vim.lsp.protocol.CompletionItemKind = {
  symbol_kinds.Text,
  symbol_kinds.Method,
  symbol_kinds.Function,
  symbol_kinds.Constructor,
  symbol_kinds.Field,
  symbol_kinds.Variable,
  symbol_kinds.Class,
  symbol_kinds.Interface,
  symbol_kinds.Module,
  symbol_kinds.Property,
  symbol_kinds.Unit,
  symbol_kinds.Value,
  symbol_kinds.Enum,
  symbol_kinds.Keyword,
  symbol_kinds.Snippet,
  symbol_kinds.Color,
  symbol_kinds.File,
  symbol_kinds.Reference,
  symbol_kinds.Folder,
  symbol_kinds.EnumMember,
  symbol_kinds.Constant,
  symbol_kinds.Struct,
  symbol_kinds.Event,
  symbol_kinds.Operator,
  symbol_kinds.TypeParameter,
}

local chars = {}
for i = 32, 126 do
  table.insert(chars, string.char(i))
end

local function on_attach_completion(client, bufnr)
  if client.supports_method("textDocument/completion") then
    vim.schedule(function()
      vim.notify("Completion enabled for " .. client.name, vim.log.levels.INFO)
    end)
    client.server_capabilities.completionProvider.triggerCharacters = chars
    vim.opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        return { abbr = item.label:gsub("%b()", "") }
      end,
    })
  end
end

return {
  on_attach_completion = on_attach_completion,
}
-- h: ins-completion lsp-completion autocomplete
