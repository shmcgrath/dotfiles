local dap = require("dap")

vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "debugger continue" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "debugger toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, { desc = "debugger set breakpoint" })
--vim.keymap.set("n", "<Leader>d", dap., { desc = "debugger" })

-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
