vim.pack.add({
  {
    src = "https://github.com/chomosuke/typst-preview.nvim",
  },
})
require("typst-preview").setup({
  port = 2455,
  invert_colors = "always",
  dependencies_bin = {
    ['tinymist'] = vim.fn.exepath('tinymist'),
    ['websocat'] = vim.fn.exepath('websocat'),
  }
})
