-- Commands for my custom functions
-- diagnostics-toggle
vim.api.nvim_create_user_command("ShmDiagnosticsToggle", function()
  require("shm.functions.diagnostics-toggle").toggle()
end, { desc = "toggle diagnostics on and off" })

-- open-snippet-files
vim.api.nvim_create_user_command("ShmSnippetOpenFiletype", function()
  require("shm.functions.open-snippet-files").open_current()
end, { desc = "Open snippet file for current filetype in new tab" })

vim.api.nvim_create_user_command("ShmSnippetOpenGlobal", function()
  require("shm.functions.open-snippet-files").open_global()
end, { desc = "Open global.json snippet file in new tab" })

-- blink-get-binary
vim.api.nvim_create_user_command("ShmBlinkGetBinary", function()
	require("shm.functions.blink-get-binary").run()
end, { desc = "Download and verify blink.cmp platform binary" })

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
