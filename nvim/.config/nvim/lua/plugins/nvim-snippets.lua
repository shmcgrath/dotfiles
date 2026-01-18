require("snippets").setup({
  create_autocmd = true,
  create_cmp_source = false,
  friendly_snippets = false,
  ignored_filetypes = { "help", "man" },
  global_snippets = { "all" },
  search_paths = { vim.fn.stdpath("config") .. "/snippets" },
  extended_filetypes = {
    lua = { "luadoc", "lua-nvim" },
  },
})
