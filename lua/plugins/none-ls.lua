return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"williamboman/mason.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-null-ls").setup({
			ensure_installed = {
				"black",
				"flake8",
				"isort",
				"mypy",
			},
			automatic_installation = true,
		})

		-- get access to the none-ls functions
		local null_ls = require("null-ls")

		local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

		local util = require("lspconfig.util")

		-- Detect project root
		local root_dir = util.root_pattern("pyproject.toml", "setup.py", "requirements.txt", ".git")(vim.fn.getcwd())

		-- Construct path to mypy inside venv
		local mypy_path = root_dir and (root_dir .. "/myvenv/bin/mypy") or "mypy"

		-- run the setup function for none-ls to setup our different formatters
		null_ls.setup({

			sources = {
				-- Formatters
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,

				-- require("none-ls.diagnostics.flake8"),
				-- null_ls.builtins.diagnostics.mypy,

				null_ls.builtins.diagnostics.mypy.with({
					command = mypy_path,
					extra_args = { "--ignore-missing-imports" },
				}),
			},
			-- Format on save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					-- Clear autocommands for this group and buffer
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					-- Set up format-on-save
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								filter = function(c)
									return c.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})

		-- set up a vim motion for <Space> + c + f to automatically format our code based on which langauge server is active
		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
	end,
}
