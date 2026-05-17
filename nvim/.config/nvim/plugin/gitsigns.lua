vim.pack.add({
  {
    src = "https://github.com/lewis6991/gitsigns.nvim",
  },
})


local icons_misc = require("shm.icons").misc
local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "‾" },
    changedelete = { text = "_" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = icons_misc.git_blame .. " <author>, <author_time:%R> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
})

vim.keymap.set("n", "<leader>gb", function()
  gitsigns.blame_line()
end, {
  noremap = true,
  silent = true,
  desc = "Gitsigns show git blame for current line",
})

vim.keymap.set("n", "<leader>gd", function()
  gitsigns.diffthis()
end, {
  noremap = true,
  silent = true,
  desc = "Gitsigns diffthis file to HEAD",
})

vim.keymap.set("n", "<leader>gh", function()
  gitsigns.next_hunk()
end, {
  noremap = true,
  silent = true,
  desc = "Gitsigns go to next hunk",
})

vim.keymap.set("n", "<leader>gs", function()
  gitsigns.stage_hunk()
end, {
  noremap = true,
  silent = true,
  desc = "Gitsigns stage hunk",
})

vim.keymap.set("n", "<leader>gS", function()
  gitsigns.undo_stage_hunk()
end, {
  noremap = true,
  silent = true,
  desc = "Gitsigns unstage hunk",
})

vim.keymap.set("n", "<leader>gq", function()
  gitsigns.setqflist("all")
end, {
  noremap = true,
  silent = true,
  desc = "Gitsigns set quickfix list for all files in working directory",
})

vim.keymap.set("n", "<leader>gl", function()
  gitsigns.setlocllist()
end, {
  noremap = true,
  silent = true,
  desc = "Gitsigns set local list for all files in working directory",
})
