-- settings for nvim as MANPAGER
-- Disable 'q' in man pages, so only :q works
vim.api.nvim_create_autocmd("FileType", {
    pattern = "man",
    callback = function()
        -- <buffer> scope ensures it only affects the man page buffer
        vim.api.nvim_buf_set_keymap(0, "n", "q", "<Nop>", {
          noremap = true,
          silent = true,
          desc = "disable q in MANPAGER",
        })
    end,
})
