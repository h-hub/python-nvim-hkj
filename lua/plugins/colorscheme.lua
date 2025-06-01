return {
	-- {
	-- 	-- Shortened Github Url
	-- 	"Mofiqul/dracula.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- Make sure to set the color scheme when neovim loads and configures the dracula plugin
	-- 		vim.cmd.colorscheme("dracula")
	-- 	end,
	-- },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- make sure it loads before other plugins
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				contrast = "hard", -- options: "soft", "medium", "hard"
				overrides = {},
			})

			-- Set colorscheme
			vim.cmd("colorscheme gruvbox")
		end,
	},
}
