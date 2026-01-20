local M = {}

--- Diagnostic severities.
M.diagnostics = {
  ERROR = "🆇",
  WARN = "⚠",
  HINT = "",
  INFO = "ℹ",
}

--- For folding.
M.arrows = {
  right = "",
  left = "",
  up = "",
  down = "",
}

M.listchars = {
  tab = "▸ ",
  eol = "¬",
  trail = "‽",
  nbsp = "␣",
  --precedes = "←",
  --extends = "→",
  precedes = "«",
  extends = "»",
}

--- LSP symbol kinds.
M.symbol_kinds = {
  Array = "󰅪",
  Boolean = "󰨙",
  Class = "󰠱",
  Color = "󰏘",
  Constant = "󰏿",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "󰜢",
  File = "󰈙",
  Folder = "󰉋",
  Function = "󰊕",
  Interface = "",
  Keyword = "󰌋",
  Key = "󰌋",
  Null = "󰟢",
  Method = "󰆧",
  Module = "󰏗", -- original: 
  Namespace = "󰌗",
  Object = "󰅩",
  Operator = "󰆕",
  Property = "󰜢",
  Package = "󰏖",
  Reference = "󰈇",
  Snippet = "",
  Struct = "",
  Text = "󰉿",
  TypeParameter = "󰊄",
  Unit = "󰑭",
  Value = "󰫧",
  Variable = "󰀫",
  String = "󰀬",
  Number = "󰎠",
}

M.misc = {
  bar_dashed = "┊",
  bar_double = "║",
  bar_vertical = "│",
  bug = "",
  ellipsis = "…",
  git = "",
  palette = "󰏘",
  robot = "󰚩",
  search = "",
  terminal = "",
  toolbox = "󰦬",
}

return M
