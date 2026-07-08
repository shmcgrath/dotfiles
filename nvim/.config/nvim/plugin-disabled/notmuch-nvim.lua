vim.pack.add({
  {
    src= "https://github.com/yousefakbar/notmuch.nvim",
  },
})

local xdg_data_dir = os.getenv("XDG_DATA_HOME") or error("$XDG_DATA_HOME is not set")
local maildir = xdg_data_dir .. "/mail"

require("notmuch").setup({
  notmuch_db_path = maildir,
  maildir_sync_cmd = "mbsync -a",
  sync = {
    sync_mode = "buffer" -- OR "background" OR "terminal"
  },
  render_html_body = false, -- set to true if w3m is installed
  suppress_deprecation_warning = false,
  -- Custom open handler
  open_handler = function(attachment)
    -- attachment.path contains the full file path
    vim.fn.system({ 'my-custom-opener', attachment.path })
  end,

  -- Custom view handler
  view_handler = function(attachment)
    -- Must return a string to display in the floating window
    local path = attachment.path
    if path:match('%.pdf$') then
      return vim.fn.system({ "pdftotext", "-layout", path, "-" })
    end
    return vim.fn.system({ "cat", path })
  end,
  keymaps = {
  },
})
