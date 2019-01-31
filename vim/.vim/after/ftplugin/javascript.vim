"MAKES TABS TWO SPACES WIDE FOR JAVASCRIPT FILES
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
" Highlights column 101 to show when going over 100 chars
setlocal colorcolumn=101
setlocal foldmethod=syntax
" In after/ftplugin/javascript.vim
if executable('eslint')
    setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
    setlocal makeprg=eslint\ --format\ compact
    autocmd BufWritePost <buffer> silent make! % | silent redraw!
endif
