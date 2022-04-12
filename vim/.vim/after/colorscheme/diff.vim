" Colorscheme from https://github.com/joeytwiddle/vim-diff-traffic-lights-colors
" Moved into my vimconfig when there were errors loading

" When using vimdiff or diff mode
	highlight DiffAdd ctermbg=green ctermfg=black guibg=green  guifg=black
	highlight DiffText ctermbg=lightblue ctermfg=black guibg=lightblue  guifg=black
	highlight DiffChange ctermbg=yellow ctermfg=black guibg=yellow  guifg=black
	highlight DiffDelete ctermbg=red ctermfg=black guibg=red  guifg=black
	highlight DiffRemoved ctermbg=red ctermfg=black guibg=red  guifg=black
" When viewing a diff or patch file
	highlight DiffAdded ctermbg=green ctermfg=black guibg=green guifg=black
	highlight DiffChanged ctermbg=yellow ctermfg=black guibg=yellow  guifg=black
	highlight DiffLine ctermbg=cyan ctermfg=black guibg=cyan guifg=black
	highlight DiffFile ctermbg=magenta ctermfg=black guibg=magenta  guifg=black
