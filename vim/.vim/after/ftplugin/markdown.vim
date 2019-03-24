let g:markdown_syntax_conceal = 0
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal spell
setlocal spelllang=en_us
setlocal complete+=kspell
setlocal foldmethod=expr
setlocal foldexpr=MarkdownFold()
setlocal colorcolumn=0
:UltiSnipsAddFiletypes markdown.text
