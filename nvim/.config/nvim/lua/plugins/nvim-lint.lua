local lint = require("lint")

lint.linters_by_ft = {
  bash = { "bash" },
  lua = { "luac" },
  rust = { "clippy" },
}

vim.keymap.set("n", "<F7>", function()
  require("lint").try_lint()
end, { desc = "Lint current file" })
