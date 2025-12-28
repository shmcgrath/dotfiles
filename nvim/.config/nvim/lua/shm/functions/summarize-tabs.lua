local M = {}

function M.summarize()
    vim.notify(
        string.format(
            "tabstop=%d shiftwidth=%d softtabstop=%d %s",
            vim.opt_local.tabstop:get(),
            vim.opt_local.shiftwidth:get(),
            vim.opt_local.softtabstop:get(),
            vim.opt_local.expandtab:get() and "expandtab" or "noexpandtab"
        ),
		vim.log.levels.INFO
    )
end

return M
