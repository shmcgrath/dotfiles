require("luasnip").setup({
})

require("luasnip.loaders.from_vscode").lazy_load({ paths = { os.getenv("XDG_CONFIG_HOME") .. "/vim-base/snippets" } })
