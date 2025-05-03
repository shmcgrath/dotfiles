setlocal noexpandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal textwidth=90
setlocal colorcolumn=90

let b:ale_fixers = ['goimports', 'gofmt']
let b:ale_linters = ['gobuild', 'govet', 'gopls']
"let b:ale_linters = ['gobuild', 'staticcheck']
