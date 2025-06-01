return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<leader>0]],
			direction = "float",
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
		})
	end,
}
