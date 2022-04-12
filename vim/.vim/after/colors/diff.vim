" Colorscheme from https://github.com/joeytwiddle/vim-diff-traffic-lights-colors
" Moved into my vimconfig when there were errors loading

" When using vimdiff or diff mode
if &background == "light"
" When using vimdiff or diff mode
	highlight DiffAdd ctermbg=none ctermfg=green guibg=none  guifg=green
	highlight DiffText ctermbg=none ctermfg=black guibg=none  guifg=black
	highlight DiffChange ctermbg=none ctermfg=yellow guibg=none  guifg=yellow
	highlight DiffDelete ctermbg=none ctermfg=red guibg=none  guifg=red
	highlight DiffRemoved ctermbg=none ctermfg=red guibg=none  guifg=red
" When viewing a diff or patch file
	highlight DiffAdded ctermbg=none ctermfg=green guibg=none  guifg=green
	highlight DiffChanged ctermbg=none ctermfg=yellow guibg=none  guifg=yellow
	highlight DiffLine ctermbg=none ctermfg=cyan guibg=none  guifg=cyan
	highlight DiffFile ctermbg=none ctermfg=magenta guibg=none  guifg=magenta
else
" When using vimdiff or diff mode
	highlight DiffAdd ctermbg=none ctermfg=green guibg=none  guifg=green
	highlight DiffText ctermbg=none ctermfg=white guibg=none  guifg=white
	highlight DiffChange ctermbg=none ctermfg=yellow guibg=none  guifg=yellow
	highlight DiffDelete ctermbg=none ctermfg=red guibg=none  guifg=red
	highlight DiffRemoved ctermbg=none ctermfg=red guibg=none  guifg=red
" When viewing a diff or patch file
	highlight DiffAdded ctermbg=none ctermfg=green guibg=none  guifg=green
	highlight DiffChanged ctermbg=none ctermfg=yellow guibg=none  guifg=yellow
	highlight DiffLine ctermbg=none ctermfg=cyan guibg=none  guifg=cyan
	highlight DiffFile ctermbg=none ctermfg=magenta guibg=none  guifg=magenta
endif
