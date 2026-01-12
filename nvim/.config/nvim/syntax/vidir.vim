"   What: ls colors for vidir file listings
"  Where: $VIMRUNTIME/syntax/vidir.vim
" Author: Magnus Woldrich <m@japh.se>
" Update: 2012-07-01 22:07:28
"    URL: https://github.com/trapd00r/vim-syntax-vidir
"         http://devel.japh.se/vim-syntax-vidir/
"         http://devel.japh.se/vidir
"
" This is supposed to be used with vidir [0]:
"   export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir'
"
" The colors are generated from the LS_COLORS environment variable
" automatically. Please see the LS_COLORS repository [1] for a set of good
" colors.
"
" [0]: https://github.com/trapd00r/vidir
" [1]: https://github.com/trapd00r/LS_COLORS


if exists('b:current_syntax')
  finish
endif

" Mapping of color names to hex
let s:color_map = {
      \ 'cd_bg':            '#16181a',
      \ 'cd_bg_alt':        '#1e2124',
      \ 'cd_bg_highlight':  '#3c4048',
      \ 'cd_fg':            '#ffffff',
      \ 'cd_gray':          '#7b8496',
      \ 'cd_blue':          '#5ea1ff',
      \ 'cd_green':         '#5eff6c',
      \ 'cd_cyan':          '#5ef1ff',
      \ 'cd_red':           '#ff6e5e',
      \ 'cd_yellow':        '#f1ff5e',
      \ 'cd_magenta':       '#ff5ef1',
      \ 'cd_pink':          '#ff5ea0',
      \ 'cd_orange':        '#ffbd5e',
      \ 'cd_purple':        '#bd5eff',
      \}

function! <SID>MakeStyle(gui, fg, bg)
  let l:style = ''

	" Substitute fg with hex if in the color map, otherwise keep as-is
	let l:fg_hex = get(s:color_map, a:fg, a:fg)
	let l:style .= ' guifg=' . l:fg_hex
	let l:style .= ' ctermfg=' . l:fg_hex

	" Substitute bg with hex if in the color map, otherwise keep as-is
	let l:bg_hex = get(s:color_map, a:bg, a:bg)
	let l:style .= ' guibg=' . l:bg_hex
	let l:style .= ' ctermbg=' . l:bg_hex

	let l:style .= ' gui=' . a:gui
	let l:style .= ' cterm=' . a:gui

  return l:style
endfunction

function! <SID>MakeSyntax(ls_color)
  let [l:glob, l:gui, l:fg, l:bg] = split(a:ls_color, '|')

	if l:glob ==# 'rs'
	  return
	endif

	if l:glob =~ '^\*\..*'
		let l:regex = '\v/\zs.+[.]'
		let l:ext = substitute(l:glob, '^\*[.]', '', '')
		let l:regex .= substitute(l:ext, '[.~]', '[&]', 'g') . '$'
		let l:ext = substitute(l:ext, '[.~]', '_', 'g')
	elseif l:glob == 'di'
		let l:ext = 'DI'
		let l:regex = '\v.+[/].+[/]$'
	elseif l:glob == 'ln'
		let l:ext = 'LN'
		let l:regex = '\v.+\@$'
	else
		return
	endif

	if hlexists('ls_' . l:ext)
		return
	endi

	execute 'silent! hi ls_' . l:ext . <SID>MakeStyle(l:gui, l:fg, l:bg)
	execute 'silent! syn match ls_' . l:ext . ' display "' . l:regex . '"'
endfunction


let s:ls_colors = readfile($HOME . '/lscolors.txt')

for line in s:ls_colors
  call <SID>MakeSyntax(line)
endfor

let b:current_syntax = 'vidir'
