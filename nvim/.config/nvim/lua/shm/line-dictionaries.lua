local M = {}

-- symbols
M.symbols = {
  git = "git",
  line = "ln",
  lock = "🔒",
  --lock = "",
  readonly = "RO",
  help = "HLP",
  preview = "PRV",
  quickfix = "QFL",
  location_list = "LOCL",
  modified = "+",
  unmodified = "-",
  bad = "!",
  sep_short = "-",
  sep_tall = "|",
  sep_round = "●",
}

-- mode_map
-- Note that: \19 = ^S and \22 = ^V.
M.mode_map = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL-OP",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL-LN",
  ["\22"] = "VISUAL-BLK", -- <C-v>
  ["s"] = "SELECT",
  ["S"] = "SELECT-LN",
  ["\19"] = "SELECT-BLK", -- <C-s>
  ["i"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "REPLACE-VIR",
  ["c"] = "COMMAND",
  ["cv"] = "EX-VIM",
  ["ce"] = "EX-NORMAL",
  ["r"] = "PROMPT",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
  -- ["nov"] = "OP-PENDING",
  -- ["noV"] = "OP-PENDING",
  -- ["no\22"] = "OP-PENDING",
  -- ["niI"] = "NORMAL",
  -- ["niR"] = "NORMAL",
  -- ["niV"] = "NORMAL",
  -- ["nt"] = "NORMAL",
  -- ["ntT"] = "NORMAL",
  -- ["vs"] = "VISUAL",
  -- ["Vs"] = "VISUAL",
  -- ["\22s"] = "VISUAL",
  -- ["s"] = "SELECT",
  -- ["S"] = "SELECT",
  -- ["ic"] = "INSERT",
  -- ["ix"] = "INSERT",
  -- ["Rc"] = "REPLACE",
  -- ["Rx"] = "REPLACE",
  -- ["Rvc"] = "VIRT REPLACE",
  -- ["Rvx"] = "VIRT REPLACE",
}

-- special_labels
M.special_labels = {
  ["filetype:Outline"] = "Symbols",
  ["filetype:checkhealth"] = "Health",
  ["filetype:dashboard"] = "Dashboard",
  ["filetype:fzf"] = "fzf",
  ["filetype:fzf-lua"] = "fzf",
  ["filetype:gitcommit"] = "Commit",
  ["filetype:lspinfo"] = "LSP",
  ["filetype:man"] = "Man",
  ["filetype:netrw"] = "netrw",
  ["filetype:oil"] = "Oil",
  ["buftype:help"] = "Help",
  ["buftype:nofile"] = "Scratch",
  ["buftype:prompt"] = "Prompt",
  ["buftype:quickfix"] = "Quickfix",
  ["buftype:terminal"] = "Terminal",
}

return M
