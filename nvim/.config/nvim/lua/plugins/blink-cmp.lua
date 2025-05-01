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
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },
  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    menu = { border = "rounded" },
    documentation = {
      auto_show = true,
      window = {
      max_width = 80,
      max_height = 20,
      border = "rounded",
      },
    },
  },
  signature = {
    enabled = true,
    window = {
      border = "rounded",
    },
  },
  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
    prebuilt_binaries = {
      -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`,
      -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
      -- Disabled by default when `fuzzy.implementation = 'lua'`
      download = false,

      -- Ignores mismatched version between the built binary and the current git sha, when building locally
      ignore_version_mismatch = false,
    },
  },
})

require("blink.cmp").opts_extend = { "sources.default" }
