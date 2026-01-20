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
