" fix htmldjango filetype annoyance
augroup force_html
	autocmd!
	autocmd BufEnter,BufRead *.html setlocal filetype=html
augroup END

setlocal colorcolumn=80
setlocal foldmethod=syntax
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

let b:ale_linters = ['htmlhint']

if !exists('g:ale_html_htmlhint_options')
    let g:ale_html_htmlhint_options = '--config ' . expand('~/.config/htmlhint/htmlhint.conf')
endif
