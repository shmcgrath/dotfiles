local mason = require("mason")
local mason_registry = require("mason-registry")

mason.setup({
  PATH = "append",
  ui = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- tooling I want installed
local tooling = {
  -- tree-sitter
  "tree-sitter-cli",
  -- LSPs
  "lua-language-server",
  "tombi",
  "vim-language-server",
  -- DAPs
  -- Linters & Formatters
  "checkmake",
  "htmlhint",
  "sqlfluff",
  "sqlls",
  "stylelint",
  "stylua",
  "typstyle",
}

-- install tooling listed above

local function ensure_tooling_installed()
  for _, name in ipairs(tooling) do
    local ok, pkg = pcall(mason_registry.get_package, name)
    if ok and not pkg:is_installed() then
      pkg:install()
      vim.notify("Mason installing pkg: " .. pkg.name, vim.log.levels.INFO)
    end
  end
end

-- Check if registry needs to be refreshed (ie on first run or new plugin)
if mason_registry.refresh then
  mason_registry.refresh(ensure_tooling_installed)
  vim.notify("Mason mason_registry refreshed; ensuring tooling installed", vim.log.levels.INFO)
else
  ensure_tooling_installed()
  vim.notify("Mason ensuring tooling installed", vim.log.levels.INFO)
end
