
-- Ensure personal spellfile exists and compile on startup
local spell_dir = vim.fn.stdpath("config") .. "/spell"
local spell_file = spell_dir .. "/en.utf-8.add"
local spell_blob = spell_dir .. "/en.utf-8.add.spl"

-- Compile only if the file exists and the blob does not exist
if vim.fn.filereadable(spell_file) == 1 and vim.fn.filereadable(spell_blob) == 0 then
  vim.cmd("mkspell! " .. spell_file)
end

vim.opt.spellfile = spell_file
vim.o.spelllang = "en_us"

vim.opt.dictionary:append("/usr/share/dict/words")
vim.opt.dictionary:append(os.getenv("HOME") .. "/.local/share/doc/words/google-10000-english-usa.txt")

vim.keymap.set("n", "<F11>", "<cmd>set spell!<CR>", {
  noremap = true,
  silent = true,
  desc = "toggle spellcheck",
})

vim.api.nvim_create_user_command("ShmMakeSpellBlob", function()
  vim.cmd("mkspell! " .. spell_file)
end, { desc = "make the spell file blob file ending in .spl" })
