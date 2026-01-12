augroup ftdetect_vidir
	autocmd!
	" Linux /tmp/
	autocmd BufRead,BufNewFile /tmp/dir* setfiletype vidir | setlocal nolist
	" macOS /private/var/folders/.../T/
	autocmd BufRead,BufNewFile /private/var/folders/*/T/dir* setfiletype vidir | setlocal nolist
	" Windows temp directory
	autocmd BufRead,BufNewFile $TEMP/dir* setfiletype vidir | setlocal nolist
augroup END
