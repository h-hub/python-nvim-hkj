return {
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				stages = "fade", -- or "slide", "fade_in_slide_out", etc.
				timeout = 3000,
				background_colour = "#000000",
			})

			-- Make it the default notification system
			vim.notify = require("notify")
		end,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
		dependencies = { "rcarriga/nvim-notify" },
	},
}
