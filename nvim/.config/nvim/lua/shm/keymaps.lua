vim.keymap.set("n", "<leader>lb", ":ls<CR>:b ", {
  noremap = true,
  silent = false,
  desc = "list buffers and pick one to edit",
})

vim.keymap.set("n", "<leader>_$", function()
  require("shm.functions.preserve").preserve("%s/\\s\\+$//e")
end, {
  noremap = true,
  silent = true,
  desc = "strip trailing whitespace while preserving state",
})

-- Copy and Paste
-- If you like Y to work from the cursor to the end of line (which is more logical, but not Vi-compatible) via :help Y
-- * Is the selection buffer in x11 systems
-- + Is the cut buffer in x11 systems
-- In Windows * and + are the same
-- Copy line to system clipboard

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", {
  noremap = true,
  desc = "copy to + register (CLIPBOARD)",
})

vim.keymap.set({ "n", "v" }, "<leader>Y", "\"*y", {
  noremap = true,
  desc = "copy to * register (PRIMARY)",
})

vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p", {
  noremap = true,
  desc = "paste from + register (CLIPBOARD)",
})

vim.keymap.set({ "n", "v" }, "<leader>P", "\"*p", {
  noremap = true,
  desc = "paste from * register (PRIMARY)",
})

vim.keymap.set({ "n", "v" }, "X", "\"_d", {
  noremap = true,
  desc = "delete without effecting registers",
})

vim.keymap.set({ "n", "v" }, "Y", "y$", {
  noremap = true,
  desc = "yank to end of line",
})

-- Poweful <esc> from MariaSolOs Config
vim.keymap.set({ "i", "s", "n" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { desc = "Escape, clear hlsearch", expr = true })

-- Toggle Boolean under cursor
vim.keymap.set("n", "<leader>t", function()
  require("shm.functions.toggle-boolean").toggle("forward")
end, {
  noremap = true,
  silent = true,
  desc = "Cycle toggle boolean under cursor forward",
})

vim.keymap.set("n", "<leader>T", function()
  require("shm.functions.toggle-boolean").toggle("backward")
end, {
  noremap = true,
  silent = true,
  desc = "Cycle toggle boolean under cursor backward",
})

vim.keymap.set("n", "<leader>lg", function()
  require("shm.functions.open-lazy-git").open_lazy_git()
end, {
  noremap = true,
  silent = true,
  desc = "Open lazygit in new tab",
})

vim.keymap.set("n", "<leader>fb", function()
  local view = vim.fn.winsaveview()

  vim.cmd("normal! gggqG")

  require("shm.functions.trim-whitespace-newlines").trim_whitespace_newlines()

  vim.fn.winrestview(view)
end, {
  noremap = true,
  silent = true,
  desc = "format buffer with formatexpr then formatprg and call custom trim_whitespace_newlines function",
})

vim.keymap.set("n", "<leader>fw", function()
  local view = vim.fn.winsaveview()

  require("shm.functions.trim-whitespace-newlines").trim_whitespace_newlines()

  vim.fn.winrestview(view)
end, {
  noremap = true,
  silent = true,
  desc = "trim whitespace and newlines in buffer",
})

vim.keymap.set("n", "<leader>fl", function()
  local view = vim.fn.winsaveview()

  vim.cmd("normal! ggq")

  vim.fn.winrestview(view)
end, {
  noremap = true,
  silent = true,
  desc = "format line with formatexpr then formatprg",
})

vim.keymap.set("n", "<leader>fi", function()
  local view = vim.fn.winsaveview()

  vim.cmd("normal! gg=G")

  vim.fn.winrestview(view)
end, {
  noremap = true,
  silent = true,
  desc = "fix indentation for whole buffer",
})
