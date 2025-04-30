local function load_dap_configs()
  local dap_config_path = vim.fn.stdpath("config") .. "/lua/dap"
  local files = vim.fn.readdir(dap_config_path)

  -- Load dap configs dynamically
  for _, file in ipairs(files) do
    if file:match("%.lua$") then
      local module_name = file:gsub("%.lua$", "") -- Remove .lua extension
        local success, err = pcall(require, "dap." .. module_name)
        if not success then
          vim.notify("Error loading dap " .. module_name .. ": " .. err, vim.log.levels.ERROR)
        end
    end
  end
end

-- Load all dap configurations automatically
load_dap_configs()
