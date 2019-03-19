" Sarah H. McGrath's .vimrc
" sarah@shmcgrath.com
" https://github.com/shmcgrath/dotfiles
" IMPLEMENT THIS: https://github.com/romainl/idiomatic-vimrc/blob/master/idiomatic-vimrc.vim
" --------------------------------------
" Multi-platform Setup {{{2
" On Windows, use .vim instead of vimfiles; this makes synchronization across
" (heterogeneous) systems easier. Also make Windows use UTF-8 encoding.
" http://vim.wikia.com/wiki/Synchronize_configuration_to_many_computers
if has ('win64') || has ('win32') || has ('win16')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    set encoding=utf-8
endif

" runtimepath config {{{2
" settings files for plugins
runtime! settings/plugins/*.vim

" vim-plug {{{2
" Automatically install vim-plug if it is not installed.
if empty(glob('$HOME/.vim/autoload/plug.vim'))
    silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('$HOME/.vim/bundle')

" Declare the list of plugins.
Plug 'AndrewRadev/id3.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter' " Shows git status in gutter
Plug 'arcticicestudio/nord-vim'
Plug 'chrisbra/csv.vim'
Plug 'chriskempson/base16-vim', { 'tag' : '2d991f14f688a38b7b2bcd397bad5efadd0f80a9' } " Color themes
Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidoc/taskpaper.vim'
Plug 'glench/vim-jinja2-syntax'
Plug 'godlygeek/tabular' " Text filtering and alignment
Plug 'justinmk/vim-sneak' " Jump to any location via two characters
Plug 'LnL7/vim-nix'
Plug 'mbbill/undotree'
"Plug 'mileszs/ack.vim'
Plug 'nathanaelkane/vim-indent-guides' " show indent levels; Chose over yggdroot/indentline because of conceallevel
Plug 'nathangrigg/vim-beancount'
Plug 'shmcgrath/vim-infolines' "Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' " A vim git wrapper
Plug 'tpope/vim-repeat' " Repeats all commands, not just native
Plug 'tpope/vim-surround' " Change surrounding punctuation and markup
"Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale' " Async Lint Engine

" Unmanaged plugins - installed from $HOME/.vim/bundle-unman
Plug '$HOME/.vim/bundle-unman/shm-cheatsheet'

" List ends here. Plugins become visible to vim after this call.
call plug#end()

" Leader Mapping {{{2
" Set leader to space
let mapleader ="\<space>"

" General Settings {{{2
"set nocompatible    " Be Vim not Vi
set nolazyredraw    " Turn off lazy redraw
filetype plugin on  " Enable plugins
set conceallevel=0  " Set conceal level to 0 to not coneceal things"
" Issues with backspace in iTerm2 on macOS - Sierra
set backspace=2     " Should make backspace like most other apps

" Colors and Syntax {{{2
set termguicolors   " Turn on 24 bit color in terminal
highlight Comment cterm=italic gui=italic"
"colorscheme base16-default-dark
"colorscheme base16-tomorrow-night
colorscheme nord
if g:colors_name == "nord"
    let g:nord_italic = 1
    let g:nord_italic_comments = 1
endif

" Make comments italic and fix tmux/terminal issues {{{3
" https://www.reddit.com/r/vim/comments/24g8r8/italics_in_terminal_vim_and_tmux/
" Read above on italics in terminal Vim and tmux
" http://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Solution to tmux color issue
syntax on
if &term == "screen"
    set t_Co=256
    set t_AB=^[[48;5;%dm
    set t_AF=^[[38;5;%dm
endif

" base16 needs to use 24 bit color (iso-8613-3)
" http://vi.stackexchange.com/questions/8935/how-to-install-base16-for-iterm2
" Set thing for 24 bit color to work in tmux
" https://www.reddit.com/r/vim/comments/5416d0/true_colors_in_vim_under_tmux/
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Spaces, Tabs, and Indent" {{{2
filetype indent on  " Allows loading of filetype-specific indent files
set noautoindent    " Does not automatically indent
set expandtab       " Tabs become spaces
"set smarttab       " Sets tabs based on others in the file
" tabstop and softtabstop should be equal generally speaking consistent
" behavior when shifting left and right when in insert mode or normal mode
set tabstop=4       " Number of visual spaces per tab
set softtabstop=4   " Number of spaces in tab when editing fixes backspace
" Determines the amount of whitespeace to be inserted or removed in normal
" mode shiftwidth
set shiftwidth=4    " Size of the indent. Hoping to fix iterm issue
"set noruler         " Hides ruler

" UI Config {{{2
set number          " Show line numbers
set relativenumber  " Shows the relative line number
set numberwidth=3   " Sets the gutter of the numbers
set foldcolumn=2    " Sows the fold column that allows for collapsing of text
set cursorline      " Highlight current line
set showmatch       " Highlight matching [{()}]
set scrolloff=8     " If able show at least 8 lines at top and bottom
set splitbelow      " Sets split to below instead of above
set splitright      " Sets split to right instead of left

" Tab Management {{{2
" Move to the next tab
nnoremap <leader>tl :tabnext<CR>
" Move to the previous tab
nnoremap <leader>th :tabprev<CR>
" Create a new tab
nnoremap <leader>tn :tabnew<CR>

" Invisibles - Show characters representing tabs and end of line" {{{2
" Use the following symbols for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:‽

" Mapping to Strip Out Trailing Whitespace {{{2
nnoremap <leader>_$ :call shm#Preserve("%s/\\s\\+$//e")<CR>

" Searching and Fuzzy File Search {{{2
"set path+=**        " Search down into subfolders with :find
set wildmenu        " Visual autocomplete for command menu
set incsearch       " Search as characters are entered
set ignorecase      " Ignores case while searching - toggle set noignorecase
set smartcase       " If search contains upper case it is case sensitive
set hlsearch        " Highlight search result matches

" Searching and grepping {{{2
" TODO: Update this so that is uses the $NOTES environment variable
"       check and see if $NOTES exists and set a variable to that path
"       else see if you can have a variable be that path
"       ddg vimscript variable path
nnoremap <leader>a :grep
" Uses ack.vim to search in notes
nnoremap <leader>an :grep "" $HOME/Dropbox/notes<home><right><right><right><right><right><right>
" Uses ack.vim to search for tags in notes 
nnoremap <leader>at :grep "\\\#" $HOME/Dropbox/notes<home><right><right><right><right><right><right><right><right><right><right>
" Uses ack.vim to search for tasks
nnoremap <leader>agt :grep "" $HOME/Dropbox/notes/00-tasks<home><right><right><right><right><right><right>

" bind K to grep word under cursor
nnoremap <leader>K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" The Silver Searcher (ag)
" Based off of https://robots.thoughtbot.com/faster-grepping-in-vim
" Use ag instead of grep 
if executable('ag')
    set grepprg =ag\ -B\ 2\ --nocolor\ --smart-case

    "set grepprg=ag\ --nogroup\ --nocolor
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    " let g:ctrlp_use_caching = 0
endif


" bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
"nnoremap \ :Ag<SPACE>

" Auto-Completion {{{2
" http://vim.wikia.com/wiki/Omni_completion
set omnifunc=syntaxcomplete#Complete

" Folding {{{2
set foldenable          " Enable folding
set foldlevelstart=1    " Level of folds to close by default 1(most) - 99(all)
set foldnestmax=7       " Nested fold maximum
set foldmethod=marker   " Fold is based on marker

" Sessions  {{{2
set sessionoptions-=options " Don't persist options and mappings
set sessionoptions-=folds   " Don't persist fold settings in sessions
set sessionoptions-=tabpages " Sessions for tabs only, not entire window

" Command Line Customization {{{2
set showcmd         " Show command in bottom bar"
set noshowmode      " Turns off mode information in bottom bar

" Tab and Status Line Customization {{{2
set showtabline=2   " Last window will always have a tab line"
set laststatus=2    " Last window will always have a status line

" Source and Edit Vim {{{2
"   Source vimrc and gvimrc file
nnoremap <leader>sv :source $HOME/.vimrc<cr>:source $HOME/.gvimrc<cr>
"   Open .vimrc, .gvimrc, and shm.vim in new tab
nnoremap <leader>ev :15sp $HOME/.gvimrc<cr>:e $HOME/.vim/autoload/shm.vim<CR>:e $HOME/.vim/bundle-unman/shm-cheatsheet/doc/shm-cheatsheet.txt<cr>:e $HOME/.vim/pythonx/shm_snippet_helpers.py<cr>:e $HOME/.vimrc<cr>

" Navigation {{{2
" Shortcut to :find - file find
nnoremap <leader>ff :find 
" Shortcut to b: - file buffer
nnoremap <leader>fb :b 
" Shortcut to netrw - file tree
nnoremap <leader>ft :edit .<cr>

" netrw Customization {{{2
"let g:netrw_banner=0        " DISABLE TOP BANNER
"let g:netrw_listsytle=3     " TREE VIEW
"let g:netrw_browse_split=4  " OPEN IN PRIOR WINDOW
"let g:netrw_altv=1         " OPEN SPLITS TO THE RIGHT
"let g:netrw_winsize = 25
"let g:netrw_browse_split = 4
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Backup and Swap Files {{{2
set backupdir=$HOME/.vim/.backup//
set directory=$HOME/.vim/.swp//

" Undo and Redo {{{2
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undodir//
    set undolevels=1000
    set undoreload=10000
endif

" Copy and Paste {{{2
" If you like Y to work from the cursor to the end of line (which is more logical, but not Vi-compatible) via :help Y
" * Is the selection buffer in x11 systems
" + Is the cut buffer in x11 systems
" In Windows * and + are the same
" Copy line to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "*y
vnoremap <leader>Y "*y
" Paste from sysem clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "*p
vnoremap <leader>P "*p

vnoremap Y y$
nnoremap Y y$

" Markdown Rendering and HTML Previw {{{2
nnoremap <silent> <F24> :!start C:\Program Files\Firefox Developer Edition\firefox.exe %<CR>
nnoremap <silent> <F23> :!start C:\Program Files\Mozilla Firefox\firefox.exe %<CR>
nnoremap <silent> <F22> :!start C:\Program Files (x86)\Google\Chrome\Application\chrome.exe %<CR>

" Document Skeletons {{{2
nnoremap <leader>htmlskele :-1read $HOME/.vim/snippets/skeleton-html.html<CR>
