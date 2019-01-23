" Sarah H. McGrath's .gvimrc
" sarah@shmcgrath.com
" https://github.com/shmcgrath/dotfiles
" --------------------------------------

" Fonts {{{1
if has ('win32') || has ('win64')
    " Set default font Windows machine
    set guifont=Source\ Code\ Pro:h09
    "set guifont=Fantasque\ Sans\ Mono:h10
elseif has ('gui_macvim') || has('mac') || has('macunix') || has ('osx')
    " Set default font for macOS machine
    set guifont=Operator\ Mono\ Book:h11
else
    " Set default font for non-macOS / non-Windows machine
    set guifont=Source\ Code\ Pro\ Light:h11
endif

" Window Options {{{1
set guioptions-=r " Remove right scrollbar
set guioptions-=R " Remove right scrollbar
set guioptions-=l " Remove left scrollbar
set guioptions-=L " Remove left scrollbar
set guioptions-=e " Use console-like tab bar
