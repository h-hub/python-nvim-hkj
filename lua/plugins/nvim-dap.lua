return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- UI plugins for debugging
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		-- Mason for managing debug adapters
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		-- Python DAP support
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		-- Setup mason.nvim and mason-nvim-dap.nvim
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "python" }, -- Installs debugpy
			automatic_installation = true,
			handlers = {}, -- Use default handlers
		})

		-- Gain access to the dap plugin and its functions
		local dap = require("dap")
		-- Gain access to the dap-ui plugin and its functions
		local dapui = require("dapui")
		-- Gain access to the dap-python plugin
		local dap_python = require("dap-python")

		-- Setup the dap-ui with default configuration
		dapui.setup()

		-- Setup debugpy from Mason
		local python_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
		dap_python.setup(python_path)

		-- Python debug configuration
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}", -- Debug the current file
				pythonPath = function()
					-- Use project-specific Python or fallback to system Python
					return vim.fn.exepath("python3") or vim.fn.exepath("python") or "/usr/bin/python3"
				end,
			},
		}

		-- Setup event listeners for debugger
		dap.listeners.before.launch.dapui_config = function()
			-- When the debugger is launched, open the debug UI
			dapui.open()
		end
		dap.listeners.before.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		-- Keybindings
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })
		vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })
		vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "[D]ebug [C]lose" })
		-- Additional useful keybindings
		vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "[D]ebug [N]ext" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebug [I]nto" })
		vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "[D]ebug [O]ut" })
	end,
}
