local M = {}

function M.trim_whitespace_newlines()
  local view = vim.fn.winsaveview()

  -- trim trailing whitespace
  vim.cmd([[%s/\s\+$//e]])

  -- trim trailing blank lines
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  while #lines > 0 and lines[#lines] == "" do
    table.remove(lines)
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  vim.fn.winrestview(view)
end

return M
