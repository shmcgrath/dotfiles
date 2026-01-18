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
  -- dependencies
  { "nvim-tree/nvim-web-devicons" },
  -- nvim
  { "brenoprata10/nvim-highlight-colors" },
  { "ibhagwan/fzf-lua" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "scottmckendry/cyberdream.nvim" },
  { "stevearc/oil.nvim" },
  -- lsp
  { "williamboman/mason.nvim" },
  { "dense-analysis/ale" },
  { "rmagatti/goto-preview" },
  -- debugging / dap
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "nvim-neotest/nvim-nio" },
  -- snippets and completion
  -- git
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim" },
  -- vim plugins
  { "AndrewRadev/id3.vim" }, -- edit mp3 metadata with id3
  { "chrisbra/csv.vim" },
  { "justinmk/vim-sneak" },
  { "mbbill/undotree" },
  { "tpope/vim-commentary" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  --org
  { "nvim-orgmode/orgmode" },
  -- hledger
  { "ledger/vim-ledger" },
  -- golang
  --{ "olexsmir/gopher.nvim" },
  --{ "yanskun/gotests.nvim" },
  -- typst
  { "chomosuke/typst-preview.nvim" },
  -- need a csv plugin
  -- { "chrisbra/csv.vim" },
})

local function load_plugin_configs()
  local plugin_config_path = vim.fn.stdpath("config") .. "/lua/plugins"
  local files = vim.fn.readdir(plugin_config_path)

  -- Define an explicit load order for specific plugins
  local explicit_order = {
    "mason",
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
