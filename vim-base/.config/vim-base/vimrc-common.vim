" Configure by dependencies
" https://vimways.org/2018/make-your-setup-truly-cross-platform/

" Multi-platform Setup (Configure by OS) {{{2
" use function to determine os and set it to a global variable
if !exists("g:osEnv")
	if has ('win64') || has ('win32') || has ('win16')
		let g:osEnv = "windows"
	else
		let g:osEnv = tolower(substitute(system('uname'), '\n', '', ''))
	endif
endif

" On Windows, use .vim instead of vimfiles; this makes synchronization across
" (heterogeneous) systems easier. Also make Windows use UTF-8 encoding.
" http://vim.wikia.com/wiki/Synchronize_configuration_to_many_computers
if (g:osEnv == "windows")
	" TODO figure out how to make this work with other runtime path
	" modifications
	"set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	set encoding=utf-8
elseif (g:osEnv == "darwin")
	" macos settings
elseif (g:osEnv == "linux")
	" linux settings
elseif (g:osEnv == "openbsd")
	" openbsd settings
else
	" other settings
endif

" Configure by Hostname {{{2
if !exists("g:hostname")
	let g:hostname = hostname()
endif

" Leader Mapping {{{2
let mapleader = "\<space>"
let maplocalleader = "\\"

" General Settings and spellfile {{{2
"set nocompatible " Be Vim not Vi
set nolazyredraw " Turn off lazy redraw
filetype plugin on " Enable plugins
set conceallevel=0 " Set conceal level to 0 to not coneceal things
set spellfile=$HOME/.config/vim-base/spell/en.utf-8.add

" Colors and Syntax {{{2
set background=dark

if &diff
    syntax off
	colorscheme diff-shm
endif

" Spaces, Tabs, and Indent {{{2
filetype indent on " Allows loading of filetype-specific indent files
set noautoindent " Does not automatically indent
set noexpandtab " Tabs do not become spaces
"set smarttab " Sets tabs based on others in the file
" tabstop and softtabstop should be equal generally speaking consistent
" behavior when shifting left and right when in insert mode or normal mode
set tabstop=4 " Number of visual spaces per tab
set softtabstop=4 " Number of spaces in tab when editing fixes backspace
" Determines the amount of whitespeace to be inserted or removed in normal
" mode shiftwidth
set shiftwidth=4 " Size of the indent. Hoping to fix iterm issue
"set noruler " Hides ruler

" UI Config {{{2
set number " Show line numbers
set relativenumber " Shows the relative line number
set numberwidth=3 " Sets the gutter of the numbers
set foldcolumn=2 " Sows the fold column that allows for collapsing of text
set cursorline " Highlight current line
set showmatch " Highlight matching [{()}]
set scrolloff=8 " If able show at least 8 lines at top and bottom
set splitbelow " Sets split to below instead of above
set splitright " Sets split to right instead of left

" Invisibles - Show characters representing tabs and end of line" {{{2
" Use the following symbols for tabstops and EOLs
",precedes:←,extends:→
",precedes:«,extends:»
set listchars=tab:▸\ ,eol:¬,trail:‽,nbsp:␣,precedes:←,extends:→
set list

" TODO Mapping to Strip Out Trailing Whitespace {{{2
nnoremap <leader>_$ :call shm#Preserve("%s/\\s\\+$//e")<CR>

" Buffer Switching and Management {{{2
nnoremap <leader>lb :ls<CR>:b<space>

" Searching, Wildmenu, Grepping and Fuzzy File Search {{{2
set incsearch " Search as characters are entered
set ignorecase " Ignores case while searching
set smartcase " If search contains upper case it is case sensitive
set hlsearch " Highlight search result matches

"set path+=**		 " Search down into subfolders with :find
set wildmenu " Visual autocomplete for command menu
" wildignore settings
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.ico,*.tif,*.mov,*.unbound
set wildignore+=*.brush,*.cryptomator.bkup,*.cryptomator,*.opvault,*.kdbx
set wildignore+=*.torrent,*.pxm
set wildignore+=*.pdf,*.psd,*.epub,*.mobi,*.azw3,*.cbz,*.cbr
set wildignore+=*.zip,*.db
set wildignore+=*.doc,*.docx,*.xls,*.xlsx,*.ppt,*.pptx
set wildignore+=*.pages,*.numbers,*.keynote
set wildignore+=*.exe,*.dmg
set wildignore+=*/node_modules/*,/node_modules/*,node_modules/*
set wildignore+=*/__pycache__/*
set wildignore+=*.swp
set wildignore+=Library/*,Applications/*
set wildignore+=*.DS_Store
set wildignore+=.dropbox.cache/*,*/.dropbox.cache/*

" bind K to grep word under cursor
" Based off of https://robots.thoughtbot.com/faster-grepping-in-vim
nnoremap <leader>K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Auto-Completion {{{2
" http://vim.wikia.com/wiki/Omni_completion
set omnifunc=syntaxcomplete#Complete

" Folding {{{2
set foldenable " Enable folding
set foldlevelstart=1 " Level of folds to close by default 1(most) - 99(all)
set foldnestmax=7 " Nested fold maximum
set foldmethod=marker " Fold is based on marker

" Sessions {{{2
set sessionoptions-=options " Don't persist options and mappings
set sessionoptions-=folds " Don't persist fold settings in sessions
set sessionoptions-=tabpages " Sessions for tabs only, not entire window

" Command Line Customization {{{2
set showcmd " Show command in bottom bar"
set noshowmode " Turns off mode information in bottom bar

" Tab and Status Line Customization {{{2
set showtabline=2 " Last window will always have a tab line"
set laststatus=2 " Last window will always have a status line

" Source and Edit Vim {{{2
" TODO: make this a command instead of a mapping
" Source vimrc and gvimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>:source $MYGVIMRC<cr>

" Navigation {{{2
" Shortcut to :find - file find
"nnoremap <leader>ff :find 
" Shortcut to b: - file buffer
"nnoremap <leader>fb :b 
" Shortcut to netrw - file tree
"nnoremap <leader>ft :edit .<cr>

" netrw Customization {{{2
"let g:netrw_banner=0 " DISABLE TOP BANNER
"let g:netrw_listsytle=3 " TREE VIEW
"let g:netrw_browse_split=4 " OPEN IN PRIOR WINDOW
"let g:netrw_altv=1	 " OPEN SPLITS TO THE RIGHT
"let g:netrw_winsize = 25
"let g:netrw_browse_split = 4
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


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

nnoremap X "_d
vnoremap X "_d

vnoremap Y y$
nnoremap Y y$

if (g:osEnv == "windows")
" Markdown Rendering and HTML Previw {{{2
	nnoremap <silent> <F24> :!start C:\Program Files\Firefox Developer Edition\firefox.exe %<CR>
	nnoremap <silent> <F23> :!start C:\Program Files\Mozilla Firefox\firefox.exe %<CR>
	nnoremap <silent> <F22> :!start C:\Program Files (x86)\Google\Chrome\Application\chrome.exe %<CR>
endif

" Document Skeletons {{{2
" TODO: make this a command instead of a mapping
nnoremap <leader>skel :-1read $HOME/.vim/skeletons/

