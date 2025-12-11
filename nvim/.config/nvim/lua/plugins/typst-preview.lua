require("typst-preview").setup({
  port = 2455,
  dependencies_bin = {
    ['tinymist'] = vim.fn.exepath('tinymist'),
    ['websocat'] = vim.fn.exepath('websocat'),
  }
})
