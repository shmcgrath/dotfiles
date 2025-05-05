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
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "stevearc/oil.nvim" },
  { "scottmckendry/cyberdream.nvim" },
  { "ibhagwan/fzf-lua" },
  -- lsp
  { "williamboman/mason.nvim" },
  { "dense-analysis/ale" },
  { "rmagatti/goto-preview" },
  -- debugging / dap
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "nvim-neotest/nvim-nio" },
  -- snippets and completion
  { "Saghen/blink.cmp", run = require("shm.functions.blink-get-binary").run  },
  -- dependencies
  { "nvim-tree/nvim-web-devicons" },
  -- vim plugins
  { "AndrewRadev/id3.vim" },
  { "airblade/vim-gitgutter" },
  { "chrisbra/csv.vim" },
  { "justinmk/vim-sneak" },
  { "mbbill/undotree" },
  { "tpope/vim-commentary" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  -- hledger
  { "ledger/vim-ledger" },
  -- golang
  --{ "olexsmir/gopher.nvim" },
  --{ "yanskun/gotests.nvim" },
})

-- Functions to load all plugin configs dynamically
local function load_shared_configs()
  local plugin_settings_path = vim.fn.expand("$XDG_CONFIG_HOME")
  if plugin_settings_path == "" then
    print("Error: no shared_plugin_settings_path")
  else
    plugin_settings_path = plugin_settings_path .. "/vim-base/settings/plugins"
    for _, file in ipairs(vim.fn.glob(plugin_settings_path .. "/*.vim", 0, 1)) do
      vim.cmd("source " .. file)
    end
  end
end

local function load_plugin_configs()
  local plugin_config_path = vim.fn.stdpath("config") .. "/lua/plugins"
  local files = vim.fn.readdir(plugin_config_path)

  -- Define an explicit load order for specific plugins
  local explicit_order = {
    "mason",
    "blink-cmp",
    "dap",
    "dap-ui",
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
load_shared_configs()
