setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal textwidth=100
setlocal colorcolumn=100

let b:ale_fixers = ['stylua']

if !exists('g:ale_lua_stylua_options')
    let g:ale_lua_stylua_options = '--config-path ' . expand('~/.config/stylua/stylua.toml')
endif
