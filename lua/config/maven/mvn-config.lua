-- Ensure this matches your earlier get_maven_env function
local function get_maven_env(custom_mvn, custom_settings)
	local mvn_cmd = custom_mvn or "mvn"
	local settings_xml = custom_settings or vim.fn.expand("~/.m2/settings.xml")

	vim.g.maven_env = {
		MAVEN_CMD = mvn_cmd,
		MAVEN_SETTINGS = settings_xml,
	}

	return vim.g.maven_env
end

-- Function to prompt for Maven path and settings.xml
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

-- Run Maven with a selected command
local function run_maven_command()
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
			-- Replace 'mvn' with custom path if set
			cmd = choice:gsub("^mvn", maven_env.MAVEN_CMD)
		end

		-- Append settings.xml if available
		if maven_env.MAVEN_SETTINGS and maven_env.MAVEN_SETTINGS ~= "" then
			cmd = cmd .. " -s " .. vim.fn.shellescape(maven_env.MAVEN_SETTINGS)
		end

		vim.notify("Running: " .. cmd)

		-- Open terminal and run command
		vim.cmd("botright split | terminal " .. cmd)
	end)
end

-- Create user commands
vim.api.nvim_create_user_command("MvnConfig", prompt_maven_config, {})
vim.api.nvim_create_user_command("MvnRun", run_maven_command, {})
