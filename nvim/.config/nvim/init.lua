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

-- require nvim specific options
require("shm.options")

-- require lsp config
require("shm.lsp")

-- require dap config
require("shm.dap-load-configs")

-- require toggle diagnostics
-- if I get more functions make a functions that requres them all
require("shm.functions.diagnostics-toggle")

-- functions to edit global and current lang snippet files
require("shm.functions.open-snippet-files")

-- load treesitter highlighting on all filetypes that are installed
require("shm.treesitter-cmd")

if vim.g.neovide then
    require("shm.neovide")
end
