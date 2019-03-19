" Settings for [ack.vim](https://github.com/mileszs/ack.vim)
if executable('ag')
    let g:ackprg = 'ag -B 2 --nocolor --smart-case'
endif

" Highlight ack results
let g:ackhighlight = 1

" Change ack mappings for quickview window
let g:ack_mappings = {
    \ "t": "<C-W><CR><C-W>T",
    \ "T": "<C-W><CR><C-W>TgT<C-W>j",
    \ "o": "<CR>",
    \ "O": "<CR><C-W><C-W>:ccl<CR>",
    \ "go": "<CR><C-W>j",
    \ "h": "<C-W><CR><C-W>K",
    \ "gh": "<C-W><CR><C-W>K<C-W>b",
    \ "v": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t",
    \ "gv": "<C-W><CR><C-W>H<C-W>b<C-W>J" }
