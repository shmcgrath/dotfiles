" autoload/shm_autopair.vim

function! shm_autopair#setup() abort
  let l:plain_text_ft = ['', 'text', 'txt', 'gitcommit', 'mail']
  let l:markdown_ft = ['markdown', 'md', 'vimwiki', 'rst']

  inoremap <buffer> ( ()<Left>
  inoremap <buffer> [ []<Left>
  inoremap <buffer> { {}<Left>
  inoremap <buffer> " ""<Left>

  if index(l:plain_text_ft, &filetype) < 0 && index(l:markdown_ft, &filetype) < 0
    inoremap <buffer> ' ''<Left>
  endif

  if index(l:markdown_ft, &filetype) >= 0
    inoremap <buffer> * *<Left>
  endif

endfunction
