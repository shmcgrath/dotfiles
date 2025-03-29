source $HOME/.config/vim-base/vimrc-common.vim

" Add vim-base to runtimepath {{{2
" add shared runtime directory to the runtimepath
set runtimepath+=$HOME/.config/vim-base
set runtimepath+=$HOME/.config/vim-base/after

" Add vim-base to packpath {{{2
" this is the shared plugin directory with neovim
set packpath+=~/.config/vim-base

" runtime config for plugins {{{2
" settings files for plugins
runtime! settings/plugins/*.vim

" vim-plug {{{2
" https://github.com/junegunn/vim-plug
" Automatically install vim-plug if it is not installed.
if empty(glob('$HOME/.vim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('$HOME/.local/share/vim/plug')

" Declare the list of plugins.
Plug 'AndrewRadev/id3.vim'
"Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter' " Shows git status in gutter
Plug 'chrisbra/csv.vim'
Plug 'davidoc/taskpaper.vim'
Plug 'dbeniamine/todo.txt-vim'
Plug 'glench/vim-jinja2-syntax'
Plug 'godlygeek/tabular' " Text filtering and alignment
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
"Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak' " Jump to any location via two characters
"Plug 'lervag/vimtex'
"Plug 'LnL7/vim-nix'
Plug 'mbbill/undotree'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nathangrigg/vim-beancount'
"Plug 'shmcgrath/vim-infolines' 
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' " A vim git wrapper
Plug 'tpope/vim-repeat' " Repeats all commands, not just native
Plug 'tpope/vim-surround' " Change surrounding punctuation and markup
Plug 'tpope/vim-vinegar'
"Plug 'vim-scripts/ReplaceWithRegister' " Replace without copying twice - learn
Plug 'w0rp/ale' " Async Lint Engine

" Trial Plugins

call plug#end()

" General Settings {{{2
" Issues with backspace in iTerm2 on macOS - Sierra
set backspace=2 " Should make backspace like most other apps

" Colors and Syntax {{{2
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme bubblegum-256-dark
"colorscheme desert " best out of the box colorscheme
highlight Comment cterm=italic gui=italic

let g:UltiSnipsSnippetsDir=$HOME."/.config/vim-base/ultisnips-shm"
" Undo and Redo {{{2
if has('persistent_undo')
	set undodir=$HOME/.local/state/vim/undodir//
	set undofile
	set undolevels=1000
	set undoreload=10000
else
	set undofile
	set undodir=$HOME/.local/state/vim/undo//
endif

" Backup and Swap Files {{{2
set backupdir=$HOME/.local/state/vim/backup//
set directory=$HOME/.local/state/vim/swap//
