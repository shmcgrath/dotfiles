" what: ftplugin/vidir.vim
"  who: by Raimondi - updated by Sarah H. McGrath for personal use
" when: 2018-12-30 - 2025-01-13

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Disable list mode for clean alignment
setlocal nolist

setlocal noswapfile
setlocal buftype=acwrite

" Don't load another filetype plugin for this buffer
let b:did_ftplugin = 1

" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" Print warning on buffer start
echohl WarningMsg
  echom 'Vidir: do not change the leading numbers or the whitespace around them'
echohl Normal

" Snapshot immutable prefixes by INDEX VALUE (not line number)
" Map: index -> exact prefix (digits + whitespace)
let b:vidir_prefixes = {}

for lnum in range(1, line('$'))
  let line = getline(lnum)
  let m = matchlist(line, '^\s*\(\d\+\)\(\s\+\)')
  if !empty(m)
    let b:vidir_prefixes[m[1]] = m[1] . m[2]
  endif
endfor

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

" Validate structure ON COMMIT
function! s:validate_vidir()
  for lnum in range(1, line('$'))
    let line = getline(lnum)
    let m = matchlist(line, '^\s*\(\d\+\)\(\s\+\)')
    if empty(m)
      continue
    endif

    let idx = m[1]
    let prefix = m[1] . m[2]

    if !has_key(b:vidir_prefixes, idx)
      echohl ErrorMsg
      echom 'Vidir: unknown index ' . idx . ' on line ' . lnum
      echohl Normal
      return 1
    endif

    if prefix !=# b:vidir_prefixes[idx]
      echohl ErrorMsg
      echom 'Vidir: index column modified for ' . idx
      echohl Normal
      return 1
    endif
  endfor

  return 0
endfunction

" Intercept :write as vidir "apply"
function! s:vidir_write()
  if s:validate_vidir()
    echoerr 'Vidir: write aborted'
    return
  endif

  " Allow the write to proceed exactly once
  setlocal buftype=
  write
  setlocal buftype=acwrite
endfunction


augroup vidir
  autocmd!
  autocmd CursorMoved,CursorMovedI <buffer> call s:on_cursor_moved()
  autocmd BufWriteCmd <buffer> call s:vidir_write()
augroup END


" Restore things when changing filetype.
let b:undo_ftplugin = "setl ofu< | augroup vidir | exec 'au! CursorMoved,CursorMovedI <buffer>'|augroup END"
"reset &cpo back to users setting
let &cpo = s:save_cpo

" vim: set sw=2 sts=2 et fdm=marker:
