-- Commands for my custom functions
-- diagnostics-toggle
vim.api.nvim_create_user_command("ShmToggleDiagnostics", function()
  require("shm.functions.diagnostics-toggle").toggle()
end, { desc = "toggle diagnostics on and off" })

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

-- align-markdown-table visually selected
vim.api.nvim_create_user_command("ShmAlignMDTable", function(opts)
  require("shm.functions.align-markdown-table").align_visual_range(opts.line1, opts.line2)
end, {
  range = true,
  desc = "Align a markdown table that is visually selected"
})

-- toggle diagnostics virtual lines
vim.api.nvim_create_user_command("ShmToggleVirtualLines", function()
  if #vim.diagnostic.get() > 0 then
    vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
  else
    print("Diagnostics not enabled.")
  end
end, { desc = "Toggle diagnostic virtual lines" })

-- Document Skeletons
local skeleton_path = vim.fn.stdpath("config") .. "/skeletons/"

vim.api.nvim_create_user_command("ShmSkeleton", function(opts)
  local file = opts.args
  if file ~= "" then
    vim.cmd(":-1read " .. skeleton_path .. file)
  end
end, {
  desc = "Insert a skeleton file at the top of the buffer",
  nargs = 1,
  complete = function(arglead)
    local matches = vim.fn.getcompletion(skeleton_path .. arglead, "file")
    return vim.tbl_map(function(item)
      return vim.fn.fnamemodify(item, ":t")
    end, matches)
  end,
})

