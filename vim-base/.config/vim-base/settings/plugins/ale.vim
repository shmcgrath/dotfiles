" Settings for [ale](https://github.com/dense-analysis/ale)
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
"let g:ale_linters = { \}
"let g:ale_linter_aliases = {'html': ['html', 'javascript', 'css']}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_linters_explicit = 1

" Error Message Formatting
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] [%linter%] %code: %%s'

if has('nvim')
	let g:ale_use_neovim_diagnostics_api = 1
	let g:ale_disable_lsp = 1
else
endif

nnoremap <F6> :ALEFix<CR>
nnoremap <F7> :ALELint<CR>
