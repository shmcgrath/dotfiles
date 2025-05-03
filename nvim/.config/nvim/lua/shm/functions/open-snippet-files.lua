local M = {}

local SNIPPET_DIR = os.getenv("XDG_CONFIG_HOME") .. "/vim-base/snippets"
local PACKAGE_JSON = SNIPPET_DIR .. "/package.json"

-- Look up snippet file path for a given filetype
local function parse_snippet_path(filetype)
  local ok, json = pcall(function()
    local content = vim.fn.readfile(PACKAGE_JSON)
    return vim.fn.json_decode(table.concat(content, "\n"))
  end)

  if not ok or not json or not json.contributes or not json.contributes.snippets then
    vim.notify("Failed to parse snippet package.json", vim.log.levels.ERROR)
    return nil
  end

  for _, entry in ipairs(json.contributes.snippets) do
    for _, lang in ipairs(entry.language) do
      if lang == filetype then
        return SNIPPET_DIR .. "/" .. entry.path:gsub("^./", "")
      end
    end
  end

  return nil
end

-- Open file in new tab if it exists
local function open_file_in_tab(filepath, label)
  local f = io.open(filepath, "r")
  if f then
    io.close(f)
    vim.cmd("tabnew " .. vim.fn.fnameescape(filepath))
    vim.notify("Opened snippet file: " .. label, vim.log.levels.INFO)
  else
    vim.notify("Snippet file not found: " .. filepath, vim.log.levels.WARN)
  end
end

-- Open snippet file for current filetype
function M.open_current()
  local ft = vim.bo.filetype
  if not ft or ft == "" then
    vim.notify("No filetype detected", vim.log.levels.ERROR)
    return
  end

  local filepath = parse_snippet_path(ft)
  if not filepath then
    vim.notify("No snippet found for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  open_file_in_tab(filepath, ft)
end

-- Open global.json
function M.open_global()
  local filepath = SNIPPET_DIR .. "/global.json"
  open_file_in_tab(filepath, "global")
end

-- Commands
vim.api.nvim_create_user_command("ShmSnippetOpenFiletype", function()
  require("shm.functions.open-snippet-files").open_current()
end, { desc = "Open snippet file for current filetype in new tab" })

vim.api.nvim_create_user_command("ShmSnippetOpenGlobal", function()
  require("shm.functions.open-snippet-files").open_global()
end, { desc = "Open global.json snippet file in new tab" })

return M
