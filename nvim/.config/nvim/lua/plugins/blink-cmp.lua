require("blink.cmp").opts_extend = { "sources.default" }

require("blink.cmp").setup({
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
  keymap = {
    preset = "none",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "cancel", "fallback" },
    ["<C-y>"] = { "select_and_accept", "fallback" },

    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },

    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },
  appearance = {
    nerd_font_variant = "mono",
    kind_icons = require("shm.icons").symbol_kinds,
  },
  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    menu = { border = "bold" },
    documentation = {
      auto_show = true,
      window = {
        max_width = 80,
        max_height = 20,
        border = "bold",
      },
    },
  },
  signature = {
    enabled = true,
    window = {
      border = "bold",
    },
  },
  snippets = {},
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      snippets = {
        module = "blink.cmp.sources.snippets",
        opts = {
          -- Set to '+' to use the system clipboard, or '"' to use the unnamed register
          clipboard_register = "+",
          search_paths = { vim.fn.stdpath("config") .. "/snippets" },
          extended_filetypes = {
            lua = { "luadoc", "lua-nvim" },
            sh = { "shelldoc" },
          },
        },
      },
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
    prebuilt_binaries = {
      download = false,
      ignore_version_mismatch = false,
    },
  },
})

-- if there is an init_db issue, delete ~/.local/state/nvim/blink/cmp
