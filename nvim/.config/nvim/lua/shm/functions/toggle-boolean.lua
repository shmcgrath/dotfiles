local M = {}

-- pairs: define in one direciton only; all lower case
local shm_pairs = {
  ["true"] = "false",
  ["yes"] = "no",
  ["on"] = "off",
  ["1"] = "0",
  ["high"] = "low",
  ["up"] = "down",
  ["allow"] = "deny",
  ["open"] = "closed",
  ["=="] = "!=",
  ["<"] = ">",
  ["<="] = ">=",
  ["&&"] = "||",
  ["and"] = "or",
}

local pair_lookup = {}
for k, v in pairs(shm_pairs) do
  pair_lookup[k] = v
  pair_lookup[v] = k
end


local shm_cycles = {
  { "todo", "doing", "done" },
  { "debug", "info", "warn", "error" },
  { "low", "medium", "high" },
  { "public", "protected", "private" },
  { "let", "const", "var" },
  { "dev", "test", "staging", "prod" },
  { "enabled", "disabled", "auto" },
  { "get", "post", "put", "delete" },
  { "#", "##", "###", "####", "#####" },
  { "monday", "tuesday", "wednesday", "thursday", "friday",
    "saturday", "sunday" },
  { "mon", "tue", "wed", "thu", "fri", "sat", "sun" },
  { "january", "february", "march", "april", "may", "june",
    "july", "august", "september", "october", "november", "december" },
  { "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep",
    "oct", "nov", "dec" },
}

local cycle_lookup = {}
for _, group in ipairs(shm_cycles) do
  for i, word in ipairs(group) do
    cycle_lookup[word] = { group = group, index = i }
  end
end

-- Case Preservation

local function apply_case(original, replacement)
  if original:match("^%u+$") then
    return replacement:upper()
  end

  if original:match("^%u%l+$") then
    return replacement:sub(1, 1):upper() .. replacement:sub(2):lower()
  end

  return replacement:lower()
end

local function get_replacement(word, direction)
  local key = word:lower()

  local cycle = cycle_lookup[key]
  if cycle then
    local step = (direction == "backward") and -1 or 1
    local i = cycle.index + step

    if i > #cycle.group then i = 1 end
    if i < 1 then i = #cycle.group end

    return apply_case(word, cycle.group[i])
  end

  local pair = pair_lookup[key]
  if pair then
    return apply_case(word, pair)
  end

  return nil
end

function M.toggle(direction)
  direction = direction or "forward"

  local word = vim.fn.expand("<cword>")
  local replacement = get_replacement(word, direction)

  if not replacement then
    vim.notify("No toggle found: " .. word, vim.log.levels.INFO)
    return
  end

  local cursor = vim.api.nvim_win_get_cursor(0)

  vim.cmd.normal({ args = { '"_ciw' .. replacement }, bang = true })

  vim.api.nvim_win_set_cursor(0, cursor)
end

return M
