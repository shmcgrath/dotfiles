local M = {}

function M.open_lazy_git()
  vim.cmd.tabnew()

  local buf = vim.api.nvim_get_current_buf()

  vim.fn.jobstart({ "lazygit" }, {
    term = true,

    on_exit = function()
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
          vim.cmd.tabclose()
        end
      end)
    end,
  })

  vim.cmd.startinsert()
end

return M
