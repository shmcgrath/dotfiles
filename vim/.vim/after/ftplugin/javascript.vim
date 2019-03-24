"Makes tabs two spaces wide for javascript files
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal colorcolumn=101
setlocal foldmethod=syntax
" set makeprg to eslint
if executable('eslint')
    setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
    setlocal makeprg=eslint\ --format\ compact
    autocmd BufWritePost <buffer> silent make! % | silent redraw!
endif
:UltiSnipsAddFiletypes javascript.node
