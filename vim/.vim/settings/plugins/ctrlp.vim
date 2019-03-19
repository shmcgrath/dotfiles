" Settings for [CtrlP](https://github.com/ctrlpvim/ctrlp.vim)
" Mapping to open CtrlP
let g:ctrlp_map = '<c-p>'
" Default command to run when invoking CtrlP
let g:ctrlp_cmd = 'CtrlP'
" Ignore fiels in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Extensions are optional. To enable an extension, add its name to the variable
" The order of the items will be the order they appear on the statusline
" :h ctrlp-extensions
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'rtscript',
                            \ 'undo', 'line', 'changes', 'mixed']
