" Settings for [ale](https://github.com/w0rp/ale)
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'json': ['jsonlint'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'html': ['eslint'],
\   'elm': ['elm-format']
\}
let g:ale_linter_aliases = {'html': ['html', 'javascript', 'css']}
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
