local builtin = require("telescope.builtin")

require("telescope").setup({
  defaults = {
    file_ignore_patterns = { ".git/", "node_modules/" }, -- Ignore common folders
    vimgrep_arguments = {
      "rg",
      "--hidden",         -- Include hidden files
      "--no-ignore",      -- Do not respect .gitignore
      "--follow",         -- Follow symlinks
      "--column",
      "--line-number",
      "--no-heading",
      "--smart-case",
    },
    find_command = { "fd", "--hidden", "--no-ignore", "--type", "file" }, -- fd settings
  },
  pickers = {
    find_files = {
      hidden = true, -- Show hidden files in `find_files`
      no_ignore = true, -- Do not respect .gitignore
    },
    live_grep = {
      additional_args = function()
        return { "--hidden", "--no-ignore" }
      end,
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = false,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
})

require("telescope").load_extension "file_browser"

-- telescope keymaps
vim.keymap.set('n', '<C-p>f', builtin.find_files, {})
vim.keymap.set('n', '<C-p>g', builtin.live_grep, {})
vim.keymap.set("n", "<C-p>b", function()
	require("telescope").extensions.file_browser.file_browser()
end)
