" Settings for [ale](https://github.com/w0rp/ale)
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
"let g:ale_linters = { \}
"let g:ale_linter_aliases = {'html': ['html', 'javascript', 'css']}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 0

nnoremap <F6> :ALEFix<CR>
nnoremap <F7> :ALELint<CR>
