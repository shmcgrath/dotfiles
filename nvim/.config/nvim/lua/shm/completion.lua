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
vim.lsp.protocol.CompletionItemKind = {
  '󰉿', -- Text
  '󰆧', -- Method
  '󰊕', -- Function
  '', -- Constructor
  '󰜢', -- Field
  '󰀫', -- Variable
  '󰠱', -- Class
  '', -- Interface
  '', -- Module
  '󰜢', -- Property
  '󰑭', -- Unit
  '󰎠', -- Value
  '', -- Enum
  '󰌋', -- Keyword
  '', -- Snippet
  '󰏘', -- Color
  '󰈙', -- File
  '󰈇', -- Reference
  '󰉋', -- Folder
  '', -- EnumMember
  '󰏿', -- Constant
  '󰙅', -- Struct
  '', -- Event
  '󰆕', -- Operator
  '󰊄', -- TypeParameter
}

local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end

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
        return { abbr = item.label:gsub('%b()', '') }
      end,
    })
  end
end


return {
  on_attach_completion = on_attach_completion,
}
-- h: ins-completion lsp-completion autocomplete
