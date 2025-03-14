-- source the common .vimrc settings
vim.cmd("source $HOME/.config/vim-base/vimrc-common.vim")
vim.opt.runtimepath:append('~/.config/vim-base/')
-- [require the lazy.nvim package manager](https://lazy.folke.io/)
require("shm.lazy")
