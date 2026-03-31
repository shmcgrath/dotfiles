vim.api.nvim_create_autocmd("PackChanged", { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "nvim-treesitter" and kind == "update" then
    if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
    vim.cmd('TSUpdate')
  end
end })

vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
  },
})
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
  "perl",
  "printf",
  "python",
  "query",
  "readline",
  "regex",
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

    -- defer tree-sitter until after ftplugins run
    vim.schedule(function()
      pcall(vim.treesitter.start, args.buf)
    end)

  end,
})
