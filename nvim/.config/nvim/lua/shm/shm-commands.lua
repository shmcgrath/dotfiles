-- Commands for my custom functions
-- diagnostics-toggle
vim.api.nvim_create_user_command("ShmDiagnosticsToggle", function()
  require("shm.functions.diagnostics-toggle").toggle()
end, { desc = "toggle diagnostics on and off" })

-- summarize-tabs
vim.api.nvim_create_user_command("ShmSummarizeTabs", function()
  require("shm.functions.summarize-tabs").summarize()
end, { desc = "Print current state of tab settings" })

-- set-tabs
vim.api.nvim_create_user_command("ShmSetTabs", function()
  require("shm.functions.set-tabs").set_tabs()
end, { desc = "Change tabstop, softtabstop, and shiftwidth to input" })

-- statusline reload for testing
vim.api.nvim_create_user_command("ShmTestReloadStatusline", function()
  package.loaded["shm.statusline"] = nil
  require("shm.statusline").setup()
end, { desc = "reload statusline for testing" })

-- tabline reload for testing
vim.api.nvim_create_user_command("ShmTestReloadTabline", function()
  package.loaded["shm.tabline"] = nil
  require("shm.tabline").setup()
end, { desc = "reload tabline for testing" })

-- align-markdown-table visually selected
vim.api.nvim_create_user_command("ShmAlignMDTable", function(opts)
  require("shm.functions.align-markdown-table").align_visual_range(opts.line1, opts.line2)
end, {
  range = true,
  desc = "Align a markdown table that is visually selected"
})
