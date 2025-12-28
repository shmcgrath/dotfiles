local dict = require("shm.line-dictionaries")
local special_labels = dict.special_labels

local M = {}
function M.tab_label(tabnr)
  local bufs = vim.fn.tabpagebuflist(tabnr)
  local win = vim.fn.tabpagewinnr(tabnr)
  local buf = bufs[win]

  if not buf then
    return "No Buffers"
  end

  local name = vim.api.nvim_buf_get_name(buf)
  local ft = vim.bo[buf].filetype
  local bt = vim.bo[buf].buftype

  local label =
    special_labels["filetype:" .. ft]
    or special_labels["buftype:" .. bt]
    or (name ~= "" and vim.fn.fnamemodify(name, ":t") or "No Name")

  label = string.format("[%02d|%s]", tabnr, label)

  for _, b in ipairs(bufs) do
    local info = vim.fn.getbufinfo(b)
    if info[1] and info[1].changed == 1 then
      label = "+" .. label
      break
    end
  end

  return label
end

function M.tabline()
  local s = {}
  local current = vim.fn.tabpagenr()
  local total = vim.fn.tabpagenr("$")

  for i = 1, total do
    if i == current then
      table.insert(s, "%#TabLineSel#")
    else
      table.insert(s, "%#TabLine#")
    end

    table.insert(s, "%" .. i .. "T")
    table.insert(s, " ")
    table.insert(s, "%{v:lua.require'shm.tabline'.tab_label(" .. i .. ")} ")
  end

  -- fill remainder and reset click target
  table.insert(s, "%#TabLineFill#%T")

  -- close button on the right
  if total > 1 then
    table.insert(s, "%=%#TabLine#%999Xclose")
  end

  return table.concat(s)
end

-- setup
function M.setup()
  vim.opt.tabline = "%!v:lua.require'shm.tabline'.tabline()"
end

return M
