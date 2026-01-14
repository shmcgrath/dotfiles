-- ~/.config/nvim/lua/shm/funcitons/align-markdown-table.lua
local M = {}

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Align a single markdown table (lines array)
function M.align(lines)
  if #lines == 0 then return lines end

  -- Split each line into cells
  local rows = {}
  local n_cols = 0
  for _, line in ipairs(lines) do
    local row = {}
    for cell in line:gmatch("[^|]+") do
      table.insert(row, trim(cell))
    end
    table.insert(rows, row)
    if #row > n_cols then n_cols = #row end
  end

  -- Make all rows have same number of columns
  for _, row in ipairs(rows) do
    while #row < n_cols do table.insert(row, "") end
  end

  -- Compute max width for each column
  local widths = {}
  for col = 1, n_cols do
    local max_w = 0
    for _, row in ipairs(rows) do
      local w = #row[col]
      if w > max_w then max_w = w end
    end
    widths[col] = max_w
  end

  -- Build aligned lines
  local aligned = {}
  for i, row in ipairs(rows) do
    local line = "|"
    for col = 1, n_cols do
      local cell = row[col] or ""
      local pad = widths[col] - #cell
      line = line .. " " .. cell .. string.rep(" ", pad) .. " |"
    end
    aligned[i] = line

    -- Second line should be dashes
    if i == 2 then
      local sep = "|"
      for col = 1, n_cols do
        sep = sep .. " " .. string.rep("-", widths[col]) .. " |"
      end
      aligned[i] = sep
    end
  end

  return aligned
end

-- Apply to visual selection
function M.align_visual_range(start_line, end_line)
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local aligned = M.align(lines)
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, aligned)
end

return M
