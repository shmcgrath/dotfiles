-- vimrc-common {{{2
-- Configure by dependencies {{{3
-- https://vimways.org/2018/make-your-setup-truly-cross-platform/

-- Multi-platform Setup (Configure by OS) {{{3
-- use function to determine os and set it to the global variable osEnv
vim.g.osEnv = vim.g.osEnv
  or (vim.fn.has("win32") == 1 and "windows" or vim.loop.os_uname().sysname:lower())

if vim.g.osEnv == "windows" then
  require("shm.os.windows")
elseif vim.g.osEnv == "darwin" then
  -- require("shm.os.mac")
elseif vim.g.osEnv == "linux" then
  -- require("shm.os.linux")
elseif vim.g.osEnv == "openbsd" then
  -- require("shm.os.openbsd")
else
  -- fallback / other OS
  -- require("shm.os.fallback")
end

-- Configure by Hostname {{{3
if vim.g.hostname == nil then
  vim.g.hostname = vim.fn.hostname()
end
-- require("shm.host.hostname")

-- General Settings {{{3
-- vim.o.nocompatible = true -- be vim not vi
vim.o.lazyredraw = false -- Turn off lazy redraw
vim.cmd("filetype plugin on") -- Enable plugins
vim.o.conceallevel = 0 -- Set conceal level to 0 to not conceal things

-- spellcheck and dictionary {{{3
vim.o.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
vim.o.spelllang = en_us
vim.opt.dictionary:append("/usr/share/dict/words")
vim.opt.dictionary:append(os.getenv("HOME") .. "/.local/share/doc/words/google-10000-english-usa.txt")


-- colors and syntax {{{3
vim.o.background = "dark"
vim.cmd("colorscheme cyberdream")

if vim.opt.diff:get() then
  vim.cmd("syntax off")
  vim.cmd("colorscheme diff-shm")
end

vim.o.termguicolors = true

-- Format options {{{3
-- r automatically insert comment leader on Enter
-- o automatically insert comment leader after o or O
-- removing r and o stops auto-inserting comment leader on new lines
vim.opt.formatoptions:remove({ "r", "o" })

-- Spaces, Tabs, and Indent {{{3
vim.cmd("filetype indent on") -- Allows loading of filetype-specific indent files
vim.o.autoindent = false -- Does not automatically indent
vim.o.expandtab = false -- Tabs do not become spaces
vim.o.smarttab = false -- Sets tabs based on others in the file
-- tabstop and softtabstop should be equal generally speaking consistent
-- behavior when shifting left and right when in insert mode or normal mode
vim.o.tabstop = 4
vim.o.softtabstop = 4
-- Determines the amount of whitespeace to be inserted or removed in normal mode
vim.o.shiftwidth = 4 -- Size of the indent. Hoping to fix iterm issue
--set noruler -- Hides ruler TODO

-- UI Config {{{3
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Shows the relative line number
vim.o.numberwidth = 3 -- Sets the gutter of the numbers
vim.o.foldcolumn = "2" -- Sows the fold column that allows for collapsing of text
vim.o.cursorline = true -- Highlight line with cursor
vim.o.showmatch = true -- Highlight matching [{()}]
vim.o.scrolloff = 8 -- If able show at least 8 lines at top and bottom
vim.o.splitbelow = true -- Sets split to below instead of above
vim.o.splitright = true -- Sets split to right instead of left
vim.o.signcolumn = "yes:2" --signcolumn always on with 2 characters

-- Invisibles - Show characters representing tabs and end of line {{{3
vim.o.list = true
vim.opt.listchars = {
  tab = "▸ ",
  eol = "¬",
  trail = "‽",
  nbsp = "␣",
  precedes = "←",
  extends = "→",
  -- precedes = "«",
  -- extends = "»",
}

-- Searching, Wildmenu, Grepping and Fuzzy File Search {{{3
vim.o.incsearch = true -- Search as characters are entered
vim.o.ignorecase = true -- Ignores case while searching
vim.o.smartcase = true -- If search contains upper case it is case sensitive
vim.o.hlsearch = true -- Highlight search result matches
vim.o.wildmenu = true -- Visual autocomplete for command menu
--set path+=** -- Search down into subfolders with :find TODO

-- wildignore settings
vim.opt.wildignore = {
  "*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.ico,*.tif,*.mov,*.unbound",
  "*.brush,*.cryptomator.bkup,*.cryptomator,*.opvault,*.kdbx",
  "*.torrent,*.pxm",
  "*.pdf,*.psd,*.epub,*.mobi,*.azw3,*.cbz,*.cbr",
  "*.zip,*.db",
  "*.doc,*.docx,*.xls,*.xlsx,*.ppt,*.pptx",
  "*.pages,*.numbers,*.keynote",
  "*.exe,*.dmg",
  "*/node_modules/*",
  "*/__pycache__/*",
  "*.swp",
  "Library/*,Applications/*",
  "*.DS_Store",
  ".dropbox.cache/*,*/.dropbox.cache/*",
}

-- bind K to grep word under cursor
-- Based off of https://robots.thoughtbot.com/faster-grepping-in-vim
-- nnoremap <leader>K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR> TODO fzf-lua?

-- Auto-Completion {{{3
-- http://vim.wikia.com/wiki/Omni_completion
vim.o.omnifunc = "syntaxcomplete#Complete" -- TODO

-- Folding {{{3
vim.o.foldenable = true -- Enable folding
vim.o.foldlevelstart = 1 -- Level of folds to close by default 1(most) - 99(all)
vim.o.foldnestmax = 7 -- Nested fold maximum
vim.o.foldmethod = "marker" -- Fold is based on marker

-- Sessions {{{3
-- removed persisting fold settings (folds) and options and mappings (options)
-- tabpages: Sessions for tabs only, not entire window
vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,terminal"
-- TODO set session directory?

-- Command Line Customization {{{3
vim.o.showcmd = true -- Show command in bottom bar"
vim.o.showmode = false -- Turns off mode information in bottom bar

-- Tab and Status Line Customization {{{3
vim.o.showtabline = 2 -- Last window will always have a tab line"
vim.o.laststatus = 2 -- Last window will always have a status line

-- netrw Customization {{{3
vim.cmd("let g:netrw_banner=0") -- disable top banner
vim.cmd("let g:netrw_listsytle=3") -- tree view
vim.cmd("let g:netrw_browse_split=4") -- open in prior window
vim.cmd("let g:netrw_altv=1") -- open splits to the right
vim.cmd("let g:netrw_winsize=25")
--augroup ProjectDrawer
--  autocmd!
--  autocmd VimEnter * :Vexplore
--augroup END
--vim.cmd("let g:netrw_list_hide=netrw_gitignore#Hide()")
--vim.cmd("let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'")

-- Document Skeletons {{{3
vim.api.nvim_create_user_command("ShmSkeleton", function(opts)
  local skeleton_path = vim.fn.stdpath("config") .. "/skeleton/"
  local file = opts.args
  if file ~= "" then
    vim.cmd(":-1read " .. skeleton_path .. file)
  end
end, {
  desc = "Insert a skeleton file at the top of the buffer",
  nargs = 1,
  complete = "file", -- lets Neovim complete files
})

-- Automatically call helptags on save for shm-cheatsheet.txt {{{3
vim.api.nvim_create_augroup("shmCheatsheetHelptags", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = "shmCheatsheetHelptags",
  pattern = "shm-cheatsheet.txt",
  callback = function()
    local file = vim.fn.expand("%:p:h")
    if vim.fn.filereadable(vim.fn.expand("%")) == 1 then
      vim.cmd("helptags " .. vim.fn.fnameescape(file))
      vim.notify("Updated helptags for " .. file, vim.log.levels.INFO)
    end
  end,
})

-- nvim options.lua {{{2
vim.o.inccommand = "split" -- preview substitutions live
vim.g.have_nerd_font = true -- from kickstart.nvim

-- vim.o.clipboard = "unnamedplus"

vim.o.winborder = "double"

-- set the menu for completion
-- cyberdream does not have enough contrast
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#7b8496", bg = "#1e2124" })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#f1ff5e", bg = "#3c4048" })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#3c4048" })
vim.api.nvim_set_hl(0, "PmenuThumb", {  bg = "#7b8496" })

