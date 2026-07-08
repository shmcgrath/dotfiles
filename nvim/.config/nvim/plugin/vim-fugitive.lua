vim.pack.add({
  {
    src = "https://github.com/tpope/vim-fugitive",
  },
})

vim.keymap.set("n", "<leader>gg", function()
  vim.cmd("tab Git")
end, {
  noremap = true,
  silent = true,
  desc = "Open fugitive in new tab",
})

vim.keymap.set("n", "<leader>gd", function()
  vim.cmd("Gvdiffsplit")
end, {
  noremap = true,
  silent = true,
  desc = "Open fugitive vertical diff to HEAD",
})

vim.keymap.set("n", "<leader>gD", function()
  vim.cmd("Gvdiffsplit!")
end, {
  noremap = true,
  silent = true,
  desc = "Open fugitive vertical diff; merge conflict resolution",
})

vim.keymap.set("n", "<leader>gi", function()
  vim.cmd("vertical Git diff %")
end, {
  noremap = true,
  silent = true,
  desc = "Open git diff for this file",
})

vim.keymap.set("n", "<leader>gl", function()
  vim.cmd("vertical Git log --patch -- %")
end, {
  noremap = true,
  silent = true,
  desc = "Open git log for this file",
})

vim.keymap.set("n", "<leader>gL", function()
  vim.cmd("tab Git log")
end, {
  noremap = true,
  silent = true,
  desc = "Open git log for the repo",
})

vim.keymap.set("n", "<leader>gc", function()
  vim.cmd("tab Git commit --verbose")
end, {
  noremap = true,
  silent = true,
  desc = "Open git commit in new tab",
})

vim.keymap.set("n", "<leader>gB", function()
  vim.cmd("tab Git blame")
end, {
  noremap = true,
  silent = true,
  desc = "Open fugitive git blame",
})
