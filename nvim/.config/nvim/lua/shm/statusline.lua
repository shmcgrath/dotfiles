local dict = require("shm.line-dictionaries")
local symbols = dict.symbols
local mode_map = dict.mode_map

local M = {}

-- error logging {{{2

local logged = {}

function M.log_error(key, msg)
  if logged[key] then
    return
  end
  logged[key] = true

  vim.schedule(function()
    vim.api.nvim_echo({ { "statusline: " .. msg, "ErrorMsg" } }, true, {})
  end)
end

-- statusline functions {{{2

-- git_info (requires fugitive) {{{3
function M.git_info()
  -- fugitive not loaded silently do nothing
  if vim.fn.exists("g:loaded_fugitive") ~= 1 then
    return ""
  end

  local ok, res = pcall(vim.fn.FugitiveStatusline)
  if not ok then
    M.log_error("git", "git_status failed: " .. res)
    return "Git Error"
  end

  return res
end

-- readonly {{{3
function M.readonly()
  local ro = vim.bo.readonly
  local modifiable = vim.bo.modifiable

  local s = ""
  if not modifiable and ro then
    s = symbols.lock .. " " .. symbols.readonly
  elseif ro then
    s = symbols.readonly
  elseif not modifiable then
    s = symbols.lock
  end

  return "[" .. s .. "]"
end

-- modified {{{3
function M.modified()
  if vim.bo.modified then
    return "[" .. symbols.modified .. "]"
  end
  return "[" .. symbols.unmodified .. "]"
end

-- mode {{{3
function M.mode()
  local m = vim.api.nvim_get_mode().mode
  return mode_map[m] or m
end

-- file_size {{{3
function M.file_size()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return "0B"
  end

  local size = vim.fn.getfsize(name)
  if size <= 0 then
    return "0B"
  end

  if size >= 1024 * 1024 then
    return math.floor(size / (1024 * 1024)) .. "MB"
  elseif size >= 1024 then
    return math.floor(size / 1024) .. "KB"
  end

  return size .. "B"
end



-- Build the full statusline as a Lua string {{{2
function M.render()
  local sl = table.concat({
    M.readonly(),
    M.modified(),
    M.mode(),
    --M.git_status(),
    symbols.sep_round,
    "%t", -- filename from Vim
    "%h%w%q", -- help, preview, quickfix indicators
    "%=", -- switch to right side
    --M.csv_col_info(),
    symbols.sep_round,
    M.file_size(),
    "%y", -- filetype
    symbols.sep_round,
    "%{&ff}", -- fileformat
    symbols.sep_tall,
    "%03v", -- current column
    symbols.sep_tall,
    symbols.line,
    "%04l/%04L", -- current line / total lines
    symbols.sep_round,
    "%P", -- percentage through buffer
  })
  return sl
end

-- setup {{{2

function M.setup()
  vim.opt.statusline = "%!v:lua.require'shm.statusline'.render()"
end
-- }}}

return M
