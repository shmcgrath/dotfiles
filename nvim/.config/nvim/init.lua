-- leader mappings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- require nvim options
require("shm.options")

-- set backup and swap directories
vim.o.backupdir=os.getenv("HOME") .. "/.local/state/nvim/backup"
vim.o.directory=os.getenv("HOME") .. "/.local/state/nvim/swap"

-- require [paq plugin manager](https://github.com/savq/paq-nvim/)
require("shm.paq")

-- require lsp config
require("shm.lsp")

-- require dap config
require("shm.dap-load-configs")

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

if vim.g.neovide then
    require("shm.neovide")
end
