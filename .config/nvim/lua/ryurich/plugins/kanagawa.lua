return {
"rebelot/kanagawa.nvim", lazy = false, priority = 1000,
config = function() require('kanagawa').setup({
	compile = true, -- !!Make sure to run :KanagawaCompile if making any changes!!
	colors = {
		theme = {
			wave = {
				ui = {
					-- bg = "black" -- Make the background a true black for OLED
				}
			},
			all = {
				ui = {
					bg_gutter = "none"
				}
			}
		}
	}
})
vim.cmd([[colorscheme kanagawa]]) end
}
