-- ~/.config/nvim/lua/shm/functions/diagnostics-toggle.lua

local M = {}

function M.run()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  if vim.diagnostic.is_enabled() then
    vim.notify("Diagnostics: Enabled", vim.log.levels.INFO)
  else
    vim.notify("Diagnostics: Disabled", vim.log.levels.WARN)
  end
end

vim.api.nvim_create_user_command("ShmDiagnosticsToggle", function()
  require("shm.functions.diagnostics-toggle").run()
end, { desc = "toggle diagnostics on and off" })

return M
