vim.pack.add({
  {
    src= "https://github.com/mfussenegger/nvim-lint",
  },
})

vim.keymap.set("n", "<F6>", function()
  print("nvim-lint called for current buffer...")
  require("lint").try_lint()
end, {
  noremap = true,
  silent = false,
  desc = "Lint buffer with nvim-lint",
})

local function print_linters_for_current_ft()
  local lint = require("lint")
  local ft = vim.bo.filetype
  local names = lint.linters_by_ft[ft]

  if not names or vim.tbl_isempty(names) then
    vim.notify("No linters configured for filetype: " .. ft, vim.log.levels.INFO)
    return
  end

  vim.print({
    filetype = ft,
    linters = names,
  })

  for _, name in ipairs(names) do
    vim.print({
      name = name,
      definition = lint.linters[name],
    })
  end
end

vim.api.nvim_create_user_command("PrintLintersShm", print_linters_for_current_ft, {})
