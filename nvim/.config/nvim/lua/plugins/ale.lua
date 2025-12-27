-- Settings for [ale](https://github.com/dense-analysis/ale)
vim.g.ale_fixers = {
    ["*"] = { "remove_trailing_lines", "trim_whitespace" },
}

vim.g.ale_sign_error = ">>"
vim.g.ale_sign_warning = "--"
vim.g.ale_lint_on_save = 0
vim.g.ale_lint_on_text_changed = 0
vim.g.ale_lint_on_enter = 0
vim.g.ale_linters_explicit = 1
vim.g.ale_virtualtext_cursor=0

-- Error Message Formatting
vim.g.ale_echo_msg_error_str = "E"
vim.g.ale_echo_msg_info_str = "I"
vim.g.ale_echo_msg_warning_str = "W"
vim.g.ale_echo_msg_format = "[%severity%] [%linter%] %code: %%s"

if vim.fn.has("nvim") == 1 then
	vim.g.ale_use_neovim_diagnostics_api = 1
	vim.g.ale_disable_lsp = 1
end

vim.keymap.set("n", "<F6>", "<cmd>ALELint<CR>", {
	noremap = true,
	silent = true,
	desc = "ALELint",
})

vim.keymap.set("n", "<F7>", "<cmd>ALEFix<CR>", {
	noremap = true,
	silent = true,
	desc = "ALEFix",
})
