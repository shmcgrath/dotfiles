require("oil").setup({
  columns = {
    "icon",
  },
  view_options = {
    show_hidden = true,
  },
  delete_to_trash = true,
  use_default_keymaps = false,
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    ["<C-v>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["gw"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["q"] = { "actions.close", mode = "n" },
    ["<C-l>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  },
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Oil: Open parent directory" })
