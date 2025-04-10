local function install_paq()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print("Installing Paq.nvim...")
    vim.fn.system({
      "git",
      "clone",
      "--depth=1",
      "https://github.com/savq/paq-nvim.git",
      install_path,
    })
    vim.cmd("packadd paq-nvim")
  end
end

-- Ensure Paq is installed
install_paq()

-- Load Paq

local paq = require("paq")

paq({
  { "savq/paq-nvim" },
  { "kylechui/nvim-surround" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "stevearc/oil.nvim" },
  { "scottmckendry/cyberdream.nvim" },
  { "ibhagwan/fzf-lua" },
  -- lsp
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  -- linter and formatter
  { "mfussenegger/nvim-lint" },
  { "stevearc/conform.nvim" },
  -- dap
  -- snippets and completion
  { "Saghen/blink.cmp", build = "cargo build --release" },
  { "L3MON4D3/LuaSnip" },
  --{ "saadparwaiz1/cmp_luasnip" }, -- luasnip
  -- dependencies
  { "nvim-tree/nvim-web-devicons" },
  -- vim plugins
  { "AndrewRadev/id3.vim" },
  { "justinmk/vim-sneak" },
  { "mbbill/undotree" },
  { "tpope/vim-commentary" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
})

-- Function to load all plugin configs dynamically

local function load_plugin_configs()
  local plugin_config_path = vim.fn.stdpath("config") .. "/lua/plugins"
  local files = vim.fn.readdir(plugin_config_path)

  -- Define an explicit load order for specific plugins
  local explicit_order = {
    "mason",
    "mason-lspconfig",
    "blink-cmp",
    "LuaSnip",
  }

  -- Load explicitly ordered plugins first
  for _, module_name in ipairs(explicit_order) do
    local success, err = pcall(require, "plugins." .. module_name)
    if not success then
      vim.notify("Error loading " .. module_name .. ": " .. err, vim.log.levels.ERROR)
    end
  end

  -- Load remaining plugins dynamically, skipping explicitly ordered ones
  for _, file in ipairs(files) do
    if file:match("%.lua$") then
      local module_name = file:gsub("%.lua$", "") -- Remove .lua extension

      -- Skip plugins already loaded explicitly
      if not vim.tbl_contains(explicit_order, module_name) then
        local success, err = pcall(require, "plugins." .. module_name)
        if not success then
          vim.notify("Error loading " .. module_name .. ": " .. err, vim.log.levels.ERROR)
        end
      end
    end
  end
end

-- Load all plugin configurations automatically
load_plugin_configs()
