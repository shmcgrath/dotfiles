local treesitter = require('nvim-treesitter')

treesitter.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

treesitter.install({
  "awk",
  "bash",
  "c",
  "comment",
  "css",
  "csv",
  "dockerfile",
  "editorconfig",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "html",
  "ini",
  "jq",
  "javascript",
  "json",
  "ledger",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "muttrc",
  "printf",
  "python",
  "query",
  "readline",
  "regex",
  "robots",
  "sql",
  "ssh_config",
  "tmux",
  "toml",
  "typst",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "zsh",
})

local treesitterStartGroup = vim.api.nvim_create_augroup("UserTreesitterStart", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = treesitterStartGroup,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    pcall(vim.treesitter.start, args.buf)
  end,
})
