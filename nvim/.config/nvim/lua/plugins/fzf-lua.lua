require("fzf-lua").setup({
  -- MISC GLOBAL SETUP OPTIONS, SEE BELOW
  -- fzf_bin = ...,
  -- each of these options can also be passed as function that return options table
  -- e.g. winopts = function() return { ... } end
  --winopts = { ...  },     -- UI Options
  winopts = {
    height = 0.85,            -- window height
    width = 0.80,            -- window width
    row = 0.35,            -- window row position (0=top, 1=bottom)
    col = 0.50,            -- window col position (0=left, 1=right)
    border = "rounded",
    backdrop = 60,
    fullscreen = false,           -- start fullscreen?
    treesitter = {
      enabled = true,
      fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" }
    },
    preview = {
      default = 'bat',           -- override the default previewer?
      border = "rounded",       -- preview border: accepts both `nvim_open_win`
      wrap = true,           -- preview line wrap (fzf's 'wrap|nowrap')
      hidden = false,           -- start preview hidden
      vertical = "down:45%",      -- up|down:size
      horizontal = "right:60%",     -- right|left:size
      layout = "vertical",          -- horizontal|vertical|flex
      flip_columns = 100,             -- #cols to switch to horizontal on flex
      -- Only used with the builtin previewer:
      title = true,            -- preview border title (file/buf)?
      title_pos = "center",        -- left|center|right, title alignment
      scrollbar = "float",         -- `false` or string:'float|border'
      scrolloff = -1,              -- float scrollbar offset from right
      delay = 20,              -- delay(ms) displaying the preview
                                        -- prevents lag on fast scrolling
      winopts = {
        number = true,
        relativenumber = false,
        cursorline = true,
        cursorlineopt = "both",
        cursorcolumn = false,
        signcolumn = "no",
        list = false,
        foldenable = false,
        foldmethod = "manual",
      },
    },
    on_create = function()
      -- called once upon creation of the fzf main window
      -- can be used to add custom fzf-lua mappings, e.g:
      --   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
    end,
    -- called once _after_ the fzf interface is closed
    -- on_close = function() ... end
  },
  --keymap = { ...  },      -- Neovim keymaps / fzf binds
  --actions = { ...  },     -- Fzf "accept" binds
  --fzf_opts = { ...  },    -- Fzf CLI flags
  --fzf_colors = { ...  },  -- Fzf `--color` specification
  --hls = { ...  },         -- Highlights
  --previewers = { ...  },  -- Previewers options
  -- SPECIFIC COMMAND/PICKER OPTIONS, SEE BELOW
  -- files = { ... },
    grep = {
      rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --no-ignore",
  },
})

-- set fzf-lua as the backend for vim.ui.select
-- this may be breaking nvim-dap
-- vim.ui.select = require("fzf-lua").fzf_select

local fzf = require("fzf-lua")

vim.keymap.set("n", "<C-p>b", fzf.lgrep_curbuf, { desc = "fzf-lua to grep through current buffer" })
vim.keymap.set("n", "<C-p>d", fzf.diagnostics_document, { desc = "search through diagnostics_document" })
vim.keymap.set("n", "<C-p>f", fzf.files, { desc = "search for files in the current working directory" })
vim.keymap.set("n", "<C-p>g", fzf.live_grep, { desc = "live grep in the current working directory" })
vim.keymap.set("n", "<C-p>k", fzf.keymaps, { desc = "search through neovim keymaps" })
vim.keymap.set("n", "<C-p>o", fzf.oldfiles, { desc = "search through recently opened/edited files" })
vim.keymap.set("n", "<C-p>z", fzf.builtin, { desc = "search through fzf-lua builtin pickers" })

vim.keymap.set("n", "<C-p>c", function()
  fzf.files({ cwd=vim.fn.expand("$HOME/dotfiles") })
end, { desc = "search for files in dotfiles" })

vim.keymap.set("n", "<C-p>n", function()
  fzf.live_grep({
    search_paths= { vim.fn.expand("$HOME/Dropbox/shm") },
  })
end, { desc = "live grep in notes" })
