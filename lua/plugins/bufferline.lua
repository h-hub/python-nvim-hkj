return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers", -- You can also set this to "tabs"
				diagnostics = "nvim_lsp",
				show_buffer_close_icons = false,
				separator_style = "slant",
			},
		})
		-- Optional keymaps
		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
	end,
}
