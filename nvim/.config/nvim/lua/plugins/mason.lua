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
  -- LSPs
  "lua-language-server",
  -- DAPs
  -- Linters & Formatters
  "stylua",
}

-- install tooling listed above

local function ensure_tooling_installed()
  for _, name in ipairs(tooling) do
    local ok, pkg = pcall(mason_registry.get_package, name)
    if ok and not pkg:is_installed() then
      pkg:install()
    end
  end
end

-- Check if registry needs to be refreshed (ie on first run or new plugin)
if mason_registry.refresh then
  mason_registry.refresh(ensure_tooling_installed)
else
  ensure_tooling_installed()
end
