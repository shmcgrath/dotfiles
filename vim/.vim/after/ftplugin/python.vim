setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal colorcolumn=80
setlocal expandtab
setlocal autoindent
setlocal makeprg=flake8\ %:S
setlocal errorformat=%f:%l:%c:\ %t%n\ %m
:UltiSnipsAddFiletypes python
