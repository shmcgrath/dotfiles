-- File: lua/shm/functions/pack-delete.lua
local M = {}

-- Return a list of installed vim.pack package names
local function installed_packages()
  return vim.iter(vim.pack.get())
    :map(function(p) return p.spec.name end)
    :totable()
end

-- Delete a single or multiple packages
function M.delete(packages, opts)
  opts = opts or {}
  local force = opts.force or false

  -- Wrap single string into table
  if type(packages) == "string" then
    packages = { packages }
  end

  for _, pkg_name in ipairs(packages) do
    local installed = installed_packages()
    if vim.tbl_contains(installed, pkg_name) then
      local ok, err = pcall(vim.pack.del, { pkg_name }, { force = force }) -- <-- fix: pass list
      if ok then
        vim.notify("Deleted package: " .. pkg_name)
      else
        vim.notify("Failed to delete package " .. pkg_name .. ": " .. err, vim.log.levels.ERROR)
      end
    else
      vim.notify("Package not found: " .. pkg_name, vim.log.levels.WARN)
    end
  end
end

-- Completion function for user command
function M.complete()
  return installed_packages()
end

return M
