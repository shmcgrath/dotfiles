require("fzf-lua").setup({
  -- MISC GLOBAL SETUP OPTIONS, SEE BELOW
  -- fzf_bin = ...,
  -- each of these options can also be passed as function that return options table
  -- e.g. winopts = function() return { ... } end
  --winopts = { ...  },     -- UI Options
  winopts = {
    preview = {
      default = "bat",
    },
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

local fzf = require("fzf-lua")

vim.keymap.set("n", "<C-p>f", fzf.files, { desc = "search for files in the current working directory" })

vim.keymap.set("n", "<C-p>d", function()
  fzf.files({ cwd=vim.fn.expand("$HOME/dotfiles") })
end, { desc = "search for files in the current working directory" })

vim.keymap.set("n", "<C-p>g", fzf.live_grep, { desc = "live grep for files in the current working directory" })
