" Colorschem from https://github.com/joeytwiddle/vim-diff-traffic-lights-colors
" Moved into my vimconfig when there were errors loading

" When using vimdiff or diff mode
highlight DiffAdd ctermbg=none ctermfg=green guibg=none  guifg=green
highlight DiffText ctermbg=none ctermfg=white guibg=none  guifg=white
highlight DiffChange ctermbg=none ctermfg=yellow guibg=none  guifg=yellow
highlight DiffDelete ctermbg=none ctermfg=red guibg=none  guifg=red
if &background == "light"
	" Changes when bg=white fg=black
	highlight DiffAdd ctermbg=none ctermfg=green guibg=none  guifg=green
	highlight DiffText ctermbg=none ctermfg=black guibg=none  guifg=white
	highlight DiffChange ctermbg=none ctermfg=yellow guibg=none  guifg=yellow
	highlight DiffDelete ctermbg=none ctermfg=red guibg=none  guifg=red
endif

" When viewing a diff or patch file
highlight DiffRemoved ctermbg=none ctermfg=red guibg=none  guifg=red
highlight DiffAdded ctermbg=none ctermfg=green guibg=none  guifg=green
highlight DiffChanged ctermbg=none ctermfg=yellow guibg=none  guifg=yellow
highlight DiffLine ctermbg=none ctermfg=white guibg=none  guifg=white
highlight DiffFile ctermbg=none ctermfg=magenta guibg=none  guifg=magenta
if &background == "light"
	" Changes when bg=white fg=black
	highlight DiffRemoved ctermbg=none ctermfg=red guibg=none  guifg=red
	highlight DiffAdded ctermbg=none ctermfg=green guibg=none  guifg=green
	highlight DiffChanged ctermbg=none ctermfg=yellow guibg=none  guifg=yellow
	highlight DiffLine ctermbg=none ctermfg=black guibg=none  guifg=black
	highlight DiffFile ctermbg=none ctermfg=magenta guibg=none  guifg=magenta
endif
