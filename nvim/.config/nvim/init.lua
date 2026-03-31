-- leader mappings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- require nvim options
require("shm.options")

-- set backup and swap directories
vim.o.backupdir=os.getenv("HOME") .. "/.local/state/nvim/backup"
vim.o.directory=os.getenv("HOME") .. "/.local/state/nvim/swap"

-- plugins are now using built in vim.pack.add
-- the plugin/ directory is automatically sourced

-- require lsp and completion config
require("shm.completion")
require("shm.lsp")

-- require keymaps that are not tied to plugins
require("shm.keymaps")

-- require commands for custom functions
-- all commands are prefixed with Shm
require("shm.shm-commands")

-- require statusline
require("shm.statusline").setup()

-- require tabline
require("shm.tabline").setup()

-- require manpager for manpager settings
require("shm.manpager")

-- setup Thesaurusfunc so mthesaur.txt can be used with commas
require("shm.thesaurus")

-- setup spelling and dictionary
require("shm.spell-dictionary")

vim.cmd([[
function! Thesaurusfunc(findstart, base) abort
  return luaeval('require("shm.thesaurus").Thesaurusfunc(_A[1], _A[2])', [a:findstart, a:base])
endfunction
]])

vim.o.thesaurusfunc = "Thesaurusfunc"

if vim.g.neovide then
    require("shm.neovide")
end
