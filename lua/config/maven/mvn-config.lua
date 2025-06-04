-- Ensure this function sets your Maven env
local function get_maven_env(custom_mvn, custom_settings)
	local mvn_cmd = custom_mvn or "mvn"
	local settings_xml = custom_settings or vim.fn.expand("~/.m2/settings.xml")

	vim.g.maven_env = {
		MAVEN_CMD = mvn_cmd,
		MAVEN_SETTINGS = settings_xml,
	}

	return vim.g.maven_env
end

-- Select and run Maven command via ToggleTerm
local function run_maven_command()
	if not package.loaded["toggleterm"] then
		require("lazy").load({ plugins = { "toggleterm.nvim" } })
	end

	local Terminal = require("toggleterm.terminal").Terminal

	local maven_env = vim.g.maven_env or get_maven_env(nil, nil)

	local commands = {
		"mvn install",
		"mvn clean install",
		"mvn test",
		"mvn package",
		"mvn verify",
		"mvn compile",
		"mvn dependency:tree",
	}

	vim.ui.select(commands, { prompt = "Select Maven command to run:" }, function(choice)
		if not choice then
			return
		end

		local cmd = choice
		if maven_env.MAVEN_CMD ~= "mvn" then
			cmd = choice:gsub("^mvn", maven_env.MAVEN_CMD)
		end

		if maven_env.MAVEN_SETTINGS and maven_env.MAVEN_SETTINGS ~= "" then
			cmd = cmd .. " -s " .. vim.fn.shellescape(maven_env.MAVEN_SETTINGS)
		end

		-- Echo the command before execution
		local full_cmd = string.format(
			[[
  zsh -c "printf '\e[1;32m%s\e[0m\n%s\n\n'; %s; exec zsh"
]],
			"┏━━ Running Maven Command ━━┓",
			"┃ " .. cmd,
			cmd
		)

		local term = Terminal:new({
			cmd = full_cmd,
			direction = "float",
			close_on_exit = false,
			hidden = true,
			start_in_insert = true,
			float_opts = {
				border = "double",
			},
		})

		term:toggle()
	end)
end

-- Prompt user for mvn config
local function prompt_maven_config()
	vim.ui.input({ prompt = "Enter Maven binary path (leave blank for 'mvn'): " }, function(mvn_path)
		vim.ui.input(
			{ prompt = "Enter settings.xml path (leave blank for ~/.m2/settings.xml): " },
			function(settings_path)
				get_maven_env(mvn_path, settings_path)
				vim.notify("Maven config set.")
			end
		)
	end)
end

-- Create user commands
vim.api.nvim_create_user_command("MvnConfig", prompt_maven_config, {})
vim.api.nvim_create_user_command("MvnRun", run_maven_command, {})
