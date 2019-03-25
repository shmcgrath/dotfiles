" Settings for [UltiSnips](https://github.com/SirVer/ultisnips)
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir=$HOME."/.vim/ultisnips-shm"
let g:UltiSnipsSnippetDirectories=["ultisnips-shm"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
if exists("g:UltiSnipsListSnippets")
    unlet g:UltiSnipsListSnippets
endif
