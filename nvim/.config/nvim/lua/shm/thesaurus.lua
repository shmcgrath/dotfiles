-- lua/thesaurus.lua

local M = {}

-- path to Moby Thesaurus
local thesaurus_file = vim.fn.expand("~/.local/share/doc/words/mthesaur.txt")

-- cache
local thesaurus = nil

local function load_thesaurus()
  if thesaurus ~= nil then
    return
  end

  thesaurus = {}

  local fd = io.open(thesaurus_file, "r")
  if not fd then
    vim.notify("Failed to open thesaurus file: " .. thesaurus_file, vim.log.levels.ERROR)
    thesaurus = {}
    return
  end

  for line in fd:lines() do
    -- strip CRLF junk
    line = line:gsub("\r$", "")
    local parts = vim.split(line, ",%s*")
    local key = parts[1]:lower()
    if key and key ~= "" then
      thesaurus[key] = parts
    end
  end

  fd:close()
end

-- thesaurusfunc must be global
function M.Thesaurusfunc(findstart, base)
  if findstart == 1 then
    -- find word start (same logic as Vim example)
    local col = vim.fn.col(".")
    local line = vim.fn.getline(".")
    local start = col - 1

    while start > 0 do
      local c = line:sub(start, start)
      if not c:match("[%w_]") then
        break
      end
      start = start - 1
    end

    return start
  end

  load_thesaurus()

  if base == nil or base == "" then
    return {}
  end

  base = base:lower()
  local entry = thesaurus[base]
  if not entry then
    return {}
  end

  return entry
end

return M
