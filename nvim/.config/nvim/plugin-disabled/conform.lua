vim.pack.add({
  {
    src = "https://github.com/stevearc/conform.nvim",
  },
})

require("conform").setup({
  formatters_by_ft = {
    ["*"] = { "trim_newlines", "trim_whitespace" },
  },
  format_on_save = false,
})

vim.keymap.set("n", "<F7>", function()
  print("conform.nvim called for current buffer...")
  require("conform").format({
    bufnr = 0,
    async = true,
    lsp_format = "fallback",
  })
end, {
  noremap = true,
  silent = false,
  desc = "Format/fix buffer with conform.nvim",
})
