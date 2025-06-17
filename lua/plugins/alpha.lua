return {
	"goolord/alpha-nvim",
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		local logo = [[





                c==o
              _/____\_
       _.,--'" ||^ || "`z._
      /_/^ ___\||  || _/o\ "`-._
    _/  ]. L_| || .||  \_/_  . _`--._
   /_~7  _ . " ||. || /] \ ]. (_)  . "`--.
  |__7~.(_)_ []|+--+|/____T_____________L|
  |__|  _^(_) /^   __\____ _   _|
  |__| (_){_) J ]K{__ L___ _   _]
  |__| . _(_) \v     /__________|________
  l__l_ (_). []|+-+-<\^   L  . _   - ---L|
   \__\    __. ||^l  \Y] /_]  (_) .  _,--'
     \~_]  L_| || .\ .\\/~.    _,--'"
      \_\ . __/||  |\  \`-+-<'"
        "`---._|J__L|X o~~|[\\      "Millenium Falcon"
               \____/ \___|[//      Modified Corellian YT-1300 Transport (1)
                `--'   `--+-'


                    ▒█░░▒█ █▀▀ █▀▀▄ ▒█▀▀▄ █▀▀ ▀█░█▀ 
                    ▒█▒█▒█ █▀▀ █▀▀▄ ▒█░▒█ █▀▀ ░█▄█░ 
                    ▒█▄▀▄█ ▀▀▀ ▀▀▀░ ▒█▄▄▀ ▀▀▀ ░░▀░░
    ]]

		dashboard.section.header.val = vim.split(logo, "\n")

		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
			dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		require("alpha").setup(dashboard.config)
	end,
}
