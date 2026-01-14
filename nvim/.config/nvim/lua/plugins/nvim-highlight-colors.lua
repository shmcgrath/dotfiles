require("nvim-highlight-colors").setup({
  render = "virtual",
  virtual_symbol = "■",
  virtual_symbol_prefix = " ",
  virtual_symbol_suffix = "",
  virtual_symbol_position = "eol",
})

vim.keymap.set("n", "<F4>", "<cmd>HighlightColors Toggle<CR>", {
	noremap = true,
	silent = true,
	desc = "Toggle Highlight Colors",
})
