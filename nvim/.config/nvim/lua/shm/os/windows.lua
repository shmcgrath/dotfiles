-- On Windows, use .vim instead of vimfiles; this makes synchronization across
-- (heterogeneous) systems easier. Also make Windows use UTF-8 encoding.
-- http://vim.wikia.com/wiki/Synchronize_configuration_to_many_computers
-- TODO figure out how to make this work with other runtime path
-- modifications
-- set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
vim.o.encoding = "utf-8"

-- Markdown Rendering and HTML Previw
vim.keymap.set("n", "<F24>", ":!start 'C:\\Program Files\\Firefox Developer Edition\\firefox.exe' %<CR>", {
  noremap = true,
  silent = true,
  desc = "open current file in Firefox Developer Edition"
})

vim.keymap.set("n", "<F23>", ":!start 'C:\\Program Files\\Mozilla Firefox\\firefox.exe' %<CR>", {
  noremap = true,
  silent = true,
  desc = "open current file in Firefox"
})

vim.keymap.set("n", "<F22>", ":!start 'C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe' %<CR>", {
  noremap = true,
  silent = true,
  desc = "open current file in Chrome"
})
