vim.g.markdown_syntax_conceal = 0

vim.cmd([[
  setlocal foldmethod=expr
  setlocal foldexpr=MarkdownFold()
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
  setlocal colorcolumn=
  setlocal complete+=kspell
  setlocal spell
  setlocal spelllang=en_us
]])
