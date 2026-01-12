" what: ftplugin/vidir.vim
"  who: by Raimondi
" when: 2018-12-30

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Disable list mode for clean alignment
setlocal nolist


" Don't load another filetype plugin for this buffer
let b:did_ftplugin = 1

" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" Restore things when changing filetype.
let b:undo_ftplugin = "setl ofu< | augroup vidir | exec 'au! CursorMoved,CursorMovedI <buffer>'|augroup END"

" do not allow the cursor to move back into the line numbers
function! s:on_cursor_moved()
  let l:line = getline('.')

  " find first non-number character after the index
  let l:match = match(l:line, '^\s*\d\+\s\zs\S')
  if l:match == -1
    return
  endif

  " start of filename
  let l:fname_pos = l:match + 1

  " skip leading './' if present
  if l:line[l:fname_pos - 1 : l:fname_pos] ==# './'
    let l:fname_pos += 2
  endif

  " move cursor right if before allowed column
  if col('.') < l:fname_pos
    silent! call cursor(line('.'), l:fname_pos)
  endif
endfunction

" do not allow non-numeric changes to the file index column
function! s:on_text_changed()
  " Only check the number column (digits at the start of the line)
  for lnum in range(1, line('$'))
    let l:line = getline(lnum)
    if l:line =~ '^\d\+\s\+\S'
      " Number + at least one space + filename: good
      continue
    elseif l:line =~ '^\s*$'
      " empty line: ignore
      continue
    else
      " Something changed the number or whitespace
      silent undo
      echohl WarningMsg
      echom 'Vidir: do not change the leading numbers or the whitespace around them'
      echohl Normal
      return
    endif
  endfor
endfunct

augroup vidir
  autocmd!
  autocmd CursorMoved,CursorMovedI <buffer> call s:on_cursor_moved()
  autocmd TextChanged,TextChangedI <buffer> call s:on_text_changed()
augroup END

"reset &cpo back to users setting
let &cpo = s:save_cpo

" vim: set sw=2 sts=2 et fdm=marker:
