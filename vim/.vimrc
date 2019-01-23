" Sarah H. McGrath's .vimrc
" sarah@shmcgrath.com
" https://github.com/shmcgrath/dotfiles
" IMPLEMENT THIS: https://github.com/romainl/idiomatic-vimrc/blob/master/idiomatic-vimrc.vim
" --------------------------------------
" Multi-platform Setup {{{1
" On Windows, use .vim instead of vimfiles; this makes synchronization across
" (heterogeneous) systems easier. Also make Windows use UTF-8 encoding.
" http://vim.wikia.com/wiki/Synchronize_configuration_to_many_computers
if has ('win32') || has ('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    set encoding=utf-8
endif

" Pathogen " {{{1
" to use pathogen as a submodule in bundle change the runtime
"runtime bundle/vim-pathogen/autoload/pathogen.vim

" Enable Pathogen
"execute pathogen#infect()

" vim-plug {{{1

" Automatically install vim-plug if it is not installed. {{{2
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory. {{{2
call plug#begin('~/.vim/bundle')

" Declare the list of plugins. {{{2
" Chose vim-indent-guides over yggdroot/indentline because of conceallevel
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'ap/vim-css-color'            " Preview color in source code
"Plug 'digitaltoad/vim-jade'        " Pug syntax highlighting
"Plug 'ervandew/supertab'           " Use <Tab> for insert completion needs
"Plug 'lepture/vim-jinja'
"Plug 'mileszs/ack.vim'
"Plug 'mustache/vim-mustache-handlebars'
"Plug 'nathangrigg/vim-beancount'
"Plug 'scrooloose/nerdtree'
"Plug 'tomasiser/vim-code-dark'
"Plug 'tpope/vim-pathogen'
"Plug 'tpope/vim-vinegar'
Plug 'AndrewRadev/id3.vim'
Plug 'ElmCast/elm-vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'       " Shows git status in gutter
Plug 'ambv/black'
Plug 'arcticicestudio/nord-vim'
Plug 'chrisbra/csv.vim'
Plug 'chriskempson/base16-vim', { 'tag' : '2d991f14f688a38b7b2bcd397bad5efadd0f80a9' }      " Color themes
Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidoc/taskpaper.vim'
Plug 'godlygeek/tabular'           " Text filtering and alignment
Plug 'justinmk/vim-sneak'           " Jump to any location via two characters
Plug 'ledger/vim-ledger'
Plug 'mbbill/undotree'
Plug 'nathanaelkane/vim-indent-guides' " Visually show indent levels
Plug 'nathangrigg/vim-beancount'
Plug 'niftylettuce/vim-jinja'
Plug 'shmcgrath/vim-infolines'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'           " A vim git wrapper
Plug 'tpope/vim-repeat'             " Repeats all commands, not just native
Plug 'tpope/vim-surround'           " Change surrounding punctuation and markup
Plug 'w0rp/ale'                    " Asynchonoous Lint Engine

" Unmanaged plugins - installed from ~/.vim/bundle-unman {{{2
Plug '~/.vim/bundle-unman/shm-cheatsheet'

" List ends here. Plugins become visible to vim after this call. {{{2
call plug#end()

" Leader Mapping" {{{1
" Set leader to space
let mapleader ="\<space>"

" General Settings" {{{1
"set nocompatible    " Be Vim not Vi
set nolazyredraw    " Turn off lazy redraw
filetype plugin on  " Enable plugins
" Issues with backspace in iTerm2 on macOS - Sierra
set backspace=2     " Should make backspace like most other apps
set conceallevel=0  " Set conceal level to 0 to not coneceal things"

" http://vim.wikia.com/wiki/Omni_completion
set omnifunc=syntaxcomplete#Complete

" Colors and Syntax" {{{1
" Solution to tmux color issue
if &term == "screen"
    set t_Co=256
    set t_AB=^[[48;5;%dm
    set t_AF=^[[38;5;%dm
endif

syntax on
"colorscheme base16-default-dark
"colorscheme base16-tomorrow-night
colorscheme nord
let g:nord_italic = 1
let g:nord_italic_comments = 1
set termguicolors   " Turn on 24 bit color in terminal

" Make comments italic{{{
" https://www.reddit.com/r/vim/comments/24g8r8/italics_in_terminal_vim_and_tmux/
" Read above on italics in terminal Vim and tmux
" http://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic gui=italic"

" Spaces, Tabs, and Indent" {{{1
filetype indent on  " Allows loading of filetype-specific indent files
set noautoindent    " Does not automatically indent
"set smarttab       " Sets tabs based on others in the file
set expandtab       " Tabs become spaces
" tabstop and softtabstop should be equal generally speaking consistent
" behavior when shifting left and right when in insert mode or normal mode
set tabstop=4       " Number of visual spaces per tab
set softtabstop=4   " Number of spaces in tab when editing fixes backspace
" Determines the amount of whitespeace to be inserted or removed in normal
" mode shiftwidth
set shiftwidth=4    " Size of the indent. Hoping to fix iterm issue

" UI Config" {{{1
set number          " Show line numbers
set relativenumber  " Shows the relative line number
set numberwidth=3   " Sets the gutter of the numbers
set foldcolumn=2    " Sows the fold column that allows for collapsing of text
set cursorline      " Highlight current line
set showmatch       " Highlight matching [{()}]
set scrolloff=8     " If able show at least 8 lines at top and bottom
set splitbelow      " Sets split to below instead of above
set splitright      " Sets split to right instead of left
set colorcolumn=81  " Highlights column 81 to show when going over 80 chars

" Tabs {{{1
" Move to the next tab
nnoremap <leader>tk :tabnext<CR>
" Move to the previous tab
nnoremap <leader>tj :tabprev<CR>
" Move to the first tab
nnoremap <leader>th :tabfirst<CR>
" Move to the last tab
nnoremap <leader>tl :tablast<CR>
" Create a new tab
nnoremap <leader>tn :tabnew<CR>
" Close current tab
nnoremap <leader>tq :tabclose<CR>
" Move current tab to first
nnoremap <leader>tmh :tabmove 0<CR>
" Move current tab to last
nnoremap <leader>tml :tabmove<CR>
" Map first 10 tabs to <leader>t and the tab number
nnoremap <leader>t1 1gt
nnoremap <leader>t2 2gt
nnoremap <leader>t3 3gt
nnoremap <leader>t4 4gt
nnoremap <leader>t5 5gt
nnoremap <leader>t6 6gt
nnoremap <leader>t7 7gt
nnoremap <leader>t8 8gt
nnoremap <leader>t9 9gt

" Invisibles --> Show characters representing tabs and end of line" {{{1
" :help listchars
" shortcut to rapidly toggle 'set list'
nnoremap <leader>sl! :set list!<CR>

" Use the following symbols for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:‽

" Searching and Fuzzy File Search" {{{1
"set path+=**        " SEARCH DOWN INTO SUBFOLDERS WITH :find
set wildmenu        " VISUAL AUTOCOMPLETE FOR COMMAND MENU
set incsearch       " Search as characters are entered
set ignorecase      " IGNORES CASE WHILE SEARCHING - TOGGLE set noignorecase
set smartcase       " IF SEARCH CONTAINS UPPER CASE IT IS CASE SENSITIVE
set hlsearch        " HIGHLIGHT SEARCH RESULT MATCHES

" Folding" {{{1
set foldenable          " Enable folding
set foldlevelstart=1    " Level of folds to close by default 1(most) - 99(all)
set foldnestmax=7       " Nested fold maximum
set foldmethod=marker   " Fold is based on marker

" Sessions  {{{1
set sessionoptions-=options " Don't persist options and mappings
set sessionoptions-=folds   " Don't persist fold settings in sessions
set sessionoptions-=tabpages " Sessions for tabs only, not entire window

" Command Line Customization" {{{1
set showcmd         " Show command in bottom bar"
set noshowmode      " TURNS OFF MODE INFORMATION IN BOTTOM BAR

" Tab Line Customization" {{{1
set showtabline=2   " Last window will always have a tab line"

" Status Line Customization" {{{1
set laststatus=2    " Last window will always have a status line
"set noruler         " HIDES RUset statusline+=%03L    " TOTAL LINES - 000

" Source and Edit Vim" {{{1
"   Source vimrc and gvimrc file
nnoremap <leader>sv :source ~/.vimrc<cr>:source ~/.gvimrc<cr>
"   Open .vimrc, .gvimrc, and shm.vim in new tab
nnoremap <leader>ev :tabnew ~/.gvimrc<cr>:e ~/.vim/autoload/shm.vim<CR>:e ~/.vimrc<cr>

" Navigation {{{1

" Shortcut to :find - file find
nnoremap <leader>ff :find 
" Shortcut to b: - file buffer
nnoremap <leader>fb :b 
" Shortcut to netrw - file tree
nnoremap <leader>ft :edit .<cr>

" netrw Customization {{{1
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

" Mapping to Strip Out Trailing Whitespace {{{1
nnoremap <leader>_$ :call Preserve("%s/\\s\\+$//e")<CR>

" Backup and Swap Files {{{1
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" Undo and Redo" {{{1
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undodir//
    nnoremap <silent> <Space>ut :UndotreeToggle<CR>
    if !exists('g:undotree_SetFocusWhenToggle')
        let g:undotree_SetFocusWhenToggle = 1
    endif
    if !exists('g:undotree_WindowLayout')
        let g:undotree_WindowLayout = 2
    endif
    " diff window height
    if !exists('g:undotree_DiffpanelHeight')
        let g:undotree_DiffpanelHeight = 8
    endif
    set undolevels=1000
    set undoreload=10000
endif

" }}}
" Copy and Paste" {{{1
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

" Markdown Rendering and HTML Previw
nnoremap <silent> <F24> :!start C:\Program Files\Firefox Developer Edition\firefox.exe %<CR>
nnoremap <silent> <F23> :!start C:\Program Files\Mozilla Firefox\firefox.exe %<CR>
nnoremap <silent> <F22> :!start C:\Program Files (x86)\Google\Chrome\Application\chrome.exe %<CR>

" Searching {{{1
" Based off of https://robots.thoughtbot.com/faster-grepping-in-vim
" Use ag instead of grep 
if executable('ag')
    set grepprg =ag\ -B\ 2\ --nocolor\ --smart-case
endif

" ack.vim
" Opens ack.vim command prompt
nnoremap <leader>a :grep
" Uses ack.vim to search in notes
nnoremap <leader>an :grep "" ~/Dropbox/notes<home><right><right><right><right><right><right>
" Uses ack.vim to search for tags in notes 
nnoremap <leader>at :grep "\\\#" ~/Dropbox/notes<home><right><right><right><right><right><right><right><right><right><right>
" Uses ack.vim to search for tasks
nnoremap <leader>agt :grep "" ~/Dropbox/notes/00-tasks<home><right><right><right><right><right><right>
" Uses ack.vim to search all code files
nnoremap <leader>ac :grep! "" ~/Dropbox/code<home><right><right><right><right><right><right>

" Plugins {{{1
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
"nnoremap \ :Ag<SPACE>

" csv.vim {{{2
let g:csv_no_conceal = 1
" elm-vim {{{2
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0
" taskpaper {{{2
let g:task_paper_date_format = "%Y%m%d.%H%M"
let g:task_paper_follow_move = 0
" undotree {{{2 
nnoremap <F5> :UndotreeToggle<CR>
if !exists('g:undotree_SetFocusWhenToggle')
    let g:undotree_SetFocusWhenToggle = 1
endif
if !exists('g:undotree_WindowLayout')
    let g:undotree_WindowLayout = 2
endif
" diff window height
if !exists('g:undotree_DiffpanelHeight')
    let g:undotree_DiffpanelHeight = 8
endif
" use short indicators in undotree (m instead of minute, etc.)
if !exists('g:undotree_ShortIndicators')
    let g:undotree_ShortIndicators = 1
endif
" highlight changed text in undotree
if !exists('g:undotree_HighlightChangedText')
    let g:undotree_HighlightChangedText = 1
endif

" ALE (w0rp/ale) {{{2
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'json': ['jsonlint'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'html': ['eslint'],
\   'elm': ['elm-format']
\}
let g:ale_linter_aliases = {'html': ['html', 'javascript', 'css']}
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1

" vim-indent-guides " {{{2
" https://github.com/nathanaelkane/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
"let indent_guides_guide_size = 1
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
"let g:indent_guides_color_change_percent = 10

" Aack.vim {{{2
" Use ag with ack.vim
if executable('ag')
    let g:ackprg = 'ag -B 2 --nocolor --smart-case'
endif

" Highlight ack results
let g:ackhighlight = 1

" Change ack mappings for quickview window
let g:ack_mappings = {
    \ "t": "<C-W><CR><C-W>T",
    \ "T": "<C-W><CR><C-W>TgT<C-W>j",
    \ "o": "<CR>",
    \ "O": "<CR><C-W><C-W>:ccl<CR>",
    \ "go": "<CR><C-W>j",
    \ "h": "<C-W><CR><C-W>K",
    \ "gh": "<C-W><CR><C-W>K<C-W>b",
    \ "v": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t",
    \ "gv": "<C-W><CR><C-W>H<C-W>b<C-W>J" }

"Vim gitgutter {{{2
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_removed_first_line = '^-'
let g:gitgutter_sign_modified_removed = '~-'

"repeat.vim {{{2
" Allows repeat of all map functions with .
silent! call repeat#set("\<Plug>MyWonderfulMap",v:count)

" base16 {{{2
" base16 needs to use 24 bit color (iso-8613-3)
" http://vi.stackexchange.com/questions/8935/how-to-install-base16-for-iterm2
set termguicolors   " TURN ON 24 BIT COLOR IN TERMINAL
" Set thing for 24 bit color to work in tmux
" https://www.reddit.com/r/vim/comments/5416d0/true_colors_in_vim_under_tmux/
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" UltiSnips{{{2
let g:UltiSnipsUsePythonVersion=3
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir=$HOME."/.vim/ultisnips-shm"
let g:UltiSnipsSnippetDirectories=["ultisnips-shm"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Mappings {{{1
" H1 - H6 Headers for Markdown {{{2
nnoremap <leader>ah1 yypv$r=
nnoremap <leader>h1 i#<space>
nnoremap <leader>ah2 yypv$r-
nnoremap <leader>h2 i##<space>
nnoremap <leader>h3 i###<space>
nnoremap <leader>h4 i####<space>
nnoremap <leader>h5 i#####<space>
nnoremap <leader>h6 i######<space>

" HTML Mappings {{{2
nnoremap <leader>hbli i<li><a href=""></a></li><esc><left><left><left><left><left><left><left><left><left><left><left>

" Temporary Mappings / Specific Use Case Mappings {{{1
" Rename Hardcore History pods
"nnoremap <leader>dchh 3jf.D
" The Blizzard headings
"nnoremap <leader>bh 0i<h4>$a</h4>o<ul>kO</ul>j0
" The Blizzard artile list items
"nnoremap <leader>bm 0i<li><i>f,a</i>lli<b>f-hi</b>$a</li>0

" Document Skeletons and Abbreviations{{{1
" Abreviations
:iab <expr> dts strftime("%Y-%m-%d %H:%M")
" HTML {{{2
nnoremap <leader>shtml :-1read ~/.vim/snippets/skeleton-html.html<CR>
