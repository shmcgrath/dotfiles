setlocal colorcolumn=80
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

let b:ale_linters = ['stylelint']

if !exists('g:ale_css_stylelint_options')
    let g:ale_css_stylelint_options = '--config ' . expand('~/.config/stylelint/stylelint.config.js')
endif
