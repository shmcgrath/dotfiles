local function install_paq()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print("Installing Paq.nvim...")
    vim.fn.system({
      "git",
      "clone",
      "--depth=1",
      "https://github.com/savq/paq-nvim.git",
      install_path
    })
    vim.cmd("packadd paq-nvim")
  end
end

-- Ensure Paq is installed
install_paq()

-- Load Paq

local paq = require("paq")

paq({
  "savq/paq-nvim",

  "kylechui/nvim-surround",
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  -- telescope and plugins --
  "nvim-telescope/telescope.nvim",
  -- end telescope --
  --"neovim/nvim-lspconfig",
  "AndrewRadev/id3.vim",
  "justinmk/vim-sneak",
  "mbbill/undotree",
  "tpope/vim-commentary",
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  -- dependencies
  "nvim-lua/plenary.nvim" -- telescope
})

-- Function to load all plugin configs dynamically
local function load_plugin_configs()
  local plugin_config_path = vim.fn.stdpath("config") .. "/lua/plugins"
  for _, file in ipairs(vim.fn.readdir(plugin_config_path)) do
    if file:match("%.lua$") then
      local module_name = file:gsub("%.lua$", "") -- Remove .lua extension
      require("plugins." .. module_name)
    end
  end
end

-- Load all plugin configurations automatically
load_plugin_configs()
