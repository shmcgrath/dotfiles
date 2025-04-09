-- source the common .vimrc settings and paths
vim.cmd("source $HOME/.config/vim-base/vimrc-common.vim")

-- set backup and swap directories
vim.opt.backupdir=os.getenv("HOME") .. "/.local/state/nvim/backup//"
vim.opt.directory=os.getenv("HOME") .. "/.local/state/nvim/swap//"

-- set runtimepath and packpath
vim.opt.runtimepath:append(os.getenv("HOME") .. "/.config/vim-base")
vim.opt.runtimepath:append(os.getenv("HOME") .. "/.config/vim-base/after")
vim.opt.packpath:append(os.getenv("HOME") .. "/.config/vim-base")

-- require [paq plugin manager](https://github.com/savq/paq-nvim/)
require("shm.paq")
require("shm.lsp")
require("shm.options")
