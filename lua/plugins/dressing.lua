return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			enabled = true,
			-- 👇 Center-align input
			relative = "editor",
			prefer_width = 0.5,
			title_pos = "center",
			border = "rounded",
			win_options = {
				winblend = 10,
				wrap = false,
			},
		},
	},
}
