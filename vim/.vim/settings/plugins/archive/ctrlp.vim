" Settings for [CtrlP](https://github.com/ctrlpvim/ctrlp.vim)
" Mapping to open CtrlP
let g:ctrlp_map = '<c-p>'
" Default command to run when invoking CtrlP
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif

" Extensions are optional. To enable an extension, add its name to the variable
" The order of the items will be the order they appear on the statusline
" :h ctrlp-extensions
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'rtscript',
                            \ 'undo', 'line', 'changes', 'mixed']
"if executable("ag")
    "set grepprg=ag\ --nogroup\ --nocolor
    "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"endif
