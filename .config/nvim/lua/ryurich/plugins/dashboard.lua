return {
"nvimdev/dashboard-nvim",
lazy = false,
dependencies = {"nvim-tree/nvim-web-devicons"}, 
  config = function()
	require('dashboard').setup {
	theme = 'doom',
	config = {
		header = {
		'',
		'',
		'',
		'',
		'',
		'',			
		'	░███▄▄▄▄      ▄████████   ▄██████▄     ▄█    █▄    ▄█     ▄▄▄▄███▄▄▄▄   ',
		'	░███▀▀▀██▄   ░███    ███ ░███    ███ ░███    ███ ░███   ▄██▀▀▀███▀▀▀██▄ ',
		'	░███   ███   ░███    █▀  ░███    ███ ░███    ███ ░███▌ ░███   ███   ███ ',
		'	░███   ███   ▄███▄▄▄     ░███    ███ ░███    ███ ░███▌ ░███   ███   ███ ',
		'	░███   ███  ▀▀███▀▀▀     ░███    ███ ░███    ███ ░███▌ ░███   ███   ███ ',
		'	░███   ███   ░███    █▄  ░███    ███ ░███    ███ ░███  ░███   ███   ███ ',
		'	░███   ███   ░███    ███ ░███    ███ ░███    ███ ░███  ░███   ███   ███ ',
		'	 ░▀█   █▀    ░██████████   ▀██████▀    ▀██████▀  ░█▀     ▀█   ███   █▀  ',
		'',
		'',
		'    <<----------------------------------------------------------------------->>',	
		'    ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ === ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++',
		'',
		'',		
		},
		center = {
		  {
			icon = ' ',
			icon_hl = 'Title',
			desc = 'New File                    ',
			desc_hl = 'String',
			key = '1',
			keymap = 'SPC n f',
			key_hl = 'Number',
			action = ''
		  },
		  {
			icon = ' ',
			desc = 'Recent Files',
			desc_hl = 'String',
			key = '2',
			keymap = 'SPC f r',
			key_hl = 'Number',
			action = 'Telescope oldfiles'
		  },
		  {
			icon = ' ',
			desc = 'Find File',
			desc_hl = 'String',
			key = '3',
			keymap = 'SPC f f',
			key_hl = 'Number',
			action = 'Telescope find_files'
		  },
		  {
			icon = ' ',
			desc = 'Explore Files',
			desc_hl = 'String',
			key = '4',
			keymap = 'SPC e x',
			key_hl = 'Number',
			action = 'NvimTreeToggle'
		  },
		  {
			icon = ' ',
			desc = 'Load Session',
			desc_hl = 'String',
			key = '5',
			keymap = 'SPC s l',
			key_hl = 'Number',
			action = ''
		  },
		},
		footer = {
		'',
		'    ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ === ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++ ++',
		'    <<----------------------------------------------------------------------->>',
		},
	},
}
end
}
