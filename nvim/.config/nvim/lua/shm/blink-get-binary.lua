-- ~/.config/nvim/lua/shm/blink-get-binary.lua.lua

local M = {}

local function detect_platform()
  local osname = vim.loop.os_uname().sysname
  local arch = vim.loop.os_uname().machine

  -- Normalize arch
  if arch == "x86_64" or arch == "amd64" then
    arch = "x86_64"
  elseif arch == "arm64" then
    arch = "aarch64"
  end

  -- Normalize OS and determine target triple
  if osname == "Darwin" then
    return arch .. "-apple-darwin", ".dylib"
  elseif osname == "Linux" then
    -- Choose between gnu and musl (default to gnu)
    local musl_test = vim.fn.systemlist("ldd --version 2>&1")[1] or ""
    local libc = musl_test:match("musl") and "musl" or "gnu"
    return arch .. "-unknown-linux-" .. libc, ".so"
  elseif osname == "Windows_NT" then
    return arch .. "-pc-windows-msvc", ".dll"
  else
    error("Unsupported OS: " .. osname)
  end
end

function M.run()
  local triple, ext = detect_platform()
  local filename = triple .. ext
  local base_url = "https://github.com/saghen/blink.cmp/releases/latest/download"
  local binary_url = base_url .. "/" .. filename
  local sha_url = binary_url .. ".sha256"

  local target_dir = vim.fn.stdpath("data") .. "/site/pack/paqs/start/blink.cmp/target/release"
  local binary_path = target_dir .. "/libblink_cmp_fuzzy" .. ext
  local sha_path = binary_path .. ".sha256"

  vim.fn.mkdir(target_dir, "p")

  -- Download SHA256
  local sha_result = vim.fn.system({
    "curl", "--fail", "--location", "--output", sha_path, sha_url
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to download SHA256 file: " .. sha_result)
  end

  local sha_f = io.open(sha_path, "r")
  if not sha_f then error("Could not open SHA256 file") end
  local expected_sha256 = sha_f:read("*l"):match("^(%w+)")
  sha_f:close()
  if not expected_sha256 then error("Invalid SHA256 file format") end

  -- Download binary
  local bin_result = vim.fn.system({
    "curl", "--fail", "--location", "--output", binary_path, binary_url
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to download binary: " .. bin_result)
  end

  -- Verify SHA256
  local actual_sha256 = vim.fn.system({ "shasum", "-a", "256", binary_path }):match("^(%w+)")
  if not actual_sha256 then error("Could not compute SHA256") end

  if actual_sha256 ~= expected_sha256 then
    error("SHA256 mismatch!\nExpected: " .. expected_sha256 .. "\nActual:   " .. actual_sha256)
  else
    print("Downloaded and verified libblink_cmp_fuzzy" .. ext .. " for " .. triple)
  end
end

vim.api.nvim_create_user_command(
  "BlinkGetBinarySHM",
  function()
    require("shm.blink-get-binary").run()
  end,
  { desc = "Download and verify blink.cmp platform binary" }
)

return M
