local M = {}

-- Optional: extended filetypes
M.extended_filetypes = {
  lua = { "lua-vim", "luadoc" },
  -- add more as needed
}


local snippets_path = vim.fn.stdpath("config") .. "/snippets"
local snippets_package_path = snippets_path .. "/package.json"

---[[ Utility functions{{{2
local function cmp_read_file(path)
  local f = io.open(path, "r")
  if not f then
    vim.notify("[snippets] File not found: " .. path, vim.log.levels.ERROR)
    return nil
  end
  local content = f:read("*a")
  f:close()
  return content
end

local function cmp_read_json(path)
  local content = cmp_read_file(path)
  if not content then
    return
  end

  local ok, data = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("[snippets] Failed to decode JSON: " .. path, vim.log.levels.ERROR)
    return nil
  end

  return data
end

---@type fun(filetype: string): boolean
local function is_filetype_ignored(filetype)
	local ignored_filetypes = Snippets.config.get_option("ignored_filetypes", {})
	return vim.tbl_contains(ignored_filetypes, filetype)
end
--]]
--}}}

-- package.json tells what snippets belong to which filetypes
local function load_package()
  local pkg = cmp_read_json(snippets_package_path)
  if not pkg or not pkg.contributes or not pkg.contributes.snippets then
    return {}
  end
  return pkg
end

M.package = load_package()

-- Find snippet file names for a buffer (global + filetype) from package.json
local function get_snippet_files_for_buffer()
  local ft = vim.bo.filetype
  local files = {}

  local function add_lang(lang)
    for _, s in ipairs(M.package.contributes.snippets) do
      local langs = type(s.language) == "string" and { s.language } or s.language
      for _, l in ipairs(langs) do
        if l == lang then
          table.insert(files, s.path)
          break
        end
      end
    end
  end

  add_lang("all")
  add_lang("global")

  if ft then
    add_lang(ft)
    local extended = M.extended_filetypes[ft]
    if extended then
      for _, ext_ft in ipairs(extended) do
        add_lang(ext_ft)
      end
    end
  end

  -- Remove duplicates
  local seen = {}
  local unique = {}
  for _, f in ipairs(files) do
    if not seen[f] then
      table.insert(unique, f)
      seen[f] = true
    end
  end

  return unique
end

-- Load all snippets from JSON files into a Lua table
local function collate_buffer_snippets()
  local files = get_snippet_files_for_buffer()
  local all_snips = {}

  for _, path in ipairs(files) do
    local full_path = vim.fs.normalize(vim.fs.joinpath(snippets_path, path))
    local data = cmp_read_json(full_path)
    if data then
      for key, snippet in pairs(data) do
        table.insert(all_snips, {
          trigger = snippet.prefix[1] or key,
          body = table.concat(snippet.body, "\n"),
          description = snippet.description,
        })
      end
    end
  end

  return all_snips
end

local function index_snippets(snips)
  local index = {}
  for _, snip in ipairs(snips) do
    index[snip.trigger] = snip
  end
  return index
end


function M.load_snippets_for_current_buffer()
  M.snippets_for_buffer = collate_buffer_snippets()
  M.snippets_by_trigger = index_snippets(M.snippets_for_buffer)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("SnippetsBufferLoad", { clear = true }),
  callback = function()
    M.load_snippets_for_current_buffer()
    vim.notify(
      string.format(
        "[snippets] Loaded %d snippets for %s", 
        #M.snippets_for_buffer, vim.bo.filetype
      ), vim.log.levels.INFO
    )
  end,
})

return M
