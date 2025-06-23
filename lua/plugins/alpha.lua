return {
	"goolord/alpha-nvim",
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		local logo = [[





                 ,  ,
                / \/ \,'| _
               ,'    '  ,' |,|
              ,'           ' |,'|
             ,'                 ;'| _
            ,'                    '' |
           ,'                        ;-,
          (___                        /
        ,'    `.  ___               ,'
       :       ,`'   `-.           /
       |-._ o /         \         /
      (    `-(           )       /
     ,'`.     \      o  /      ,'
    /    `     `.     ,'      /
   (             `"""'       /
    `._                     /
       `--.______        '"`.
          \__,__,`---._   '`;
               ))`-^--')`,-'
             ,',_____,'  |
             \_          `).
     -hrr-     `.      _,'  `
               /`-._,-'      \
               

                        ▗▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖ ▗▖ ▗▄▖ ▗▖  ▗▖
                        ▐▌ ▐▌▝▚▞▘   █  ▐▌ ▐▌▐▌ ▐▌▐▛▚▖▐▌
                        ▐▛▀▘  ▐▌    █  ▐▛▀▜▌▐▌ ▐▌▐▌ ▝▜▌
                        ▐▌    ▐▌    █  ▐▌ ▐▌▝▚▄▞▘▐▌  ▐▌
                                                      
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
