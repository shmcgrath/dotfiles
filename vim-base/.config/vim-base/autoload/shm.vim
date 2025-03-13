" Sarah H. McGrath's Functions
" sarah@shmcgrath.com
" https://github.com/shmcgrath/dotfiles
" --------------------------------------

" Preserve: A Vim Function that keeps your state"{{{
" https://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
" Why not instead of let l = line(“.”) let c = col(“.”) use getpos() and setpos()?
function! shm#Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  "let preservePos = getpos('.')
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
  "setpos(., preservePos)
endfunction
"}}}

" SetTabs: Set tabstop, softtabstop and shiftwidth to the same value"{{{
command! -nargs=* SetTabs call SetTabs()
function! shm#SetTabs()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call shm#SummarizeTabs()
endfunction
"}}}

" SummarizeTabs: summarize current state of tab settings"{{{
function! shm#SummarizeTabs()
    try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction
"}}}
