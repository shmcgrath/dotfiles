-- config for neovide
-- additional options: https://neovide.dev/configuration.html
vim.opt.guifont = "CommitMono Nerd Font Mono:h13"

-- disable cursor animations
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_short_animation_length = 0

-- fix path on macos
vim.env.PATH = vim.fn.system([[bash --login -c 'printf %s "$PATH"']]):gsub("\n$", "")
