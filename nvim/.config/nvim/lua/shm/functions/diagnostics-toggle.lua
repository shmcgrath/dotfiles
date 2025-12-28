-- ~/.config/nvim/lua/shm/functions/diagnostics-toggle.lua

local M = {}

function M.toggle()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  if vim.diagnostic.is_enabled() then
    vim.notify("Diagnostics: Enabled", vim.log.levels.INFO)
  else
    vim.notify("Diagnostics: Disabled", vim.log.levels.WARN)
  end
end

return M
