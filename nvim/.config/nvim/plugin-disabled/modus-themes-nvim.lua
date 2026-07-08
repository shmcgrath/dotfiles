vim.pack.add({
  {
    src= "https://github.com/miikanissi/modus-themes.nvim",
  },
})

require("modus-themes").setup({
	style = "modus_operandi",
	variants = {
		modus_operandi = "tinted", -- opts are tinted, deuteranopia, tritanopia
		modus_vivendi = "deuteranopia ",
	},
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
	},

	on_colors = function(colors)
		colors.error = colors.red_faint -- Change error color to the "faint" variant
	end,
	-- on_highlights = function(highlight, color)
	-- 	highlight.Boolean = { fg = color.green } -- Change Boolean highlight to use the green color
	-- end,
})

-- vim.cmd("colorscheme modus")
