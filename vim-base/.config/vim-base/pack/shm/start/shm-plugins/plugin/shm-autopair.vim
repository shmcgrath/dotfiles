" plugin/shm-autopair

if exists('g:loaded_shm_autopairs')
  finish
endif
let g:loaded_shm_autopairs = 1

augroup ShmAutoPair
  autocmd!
  autocmd FileType * call shm_autopair#setup()
augroup END
