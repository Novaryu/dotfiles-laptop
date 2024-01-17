return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {"nvim-tree/nvim-web-devicons"},
	-- lazy = false,
	lazy = not (#vim.v.argv > 1 and vim.fn.isdirectory(vim.v.argv[#vim.v.argv]) ~= 0),
	config = function()
		
		local current_dir = vim.fn.expand('%:p:h')
		local wk = require("which-key")
		
		local function my_on_attach(bufnr)
			local api = require "nvim-tree.api"
			wk.register({["<leader>r"] = { vim.cmd.NvimTreeRefresh, "refresh file explorer" },})
			
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
				
			-- default mappings
			api.config.mappings.default_on_attach(bufnr)
			
			-- custom mappings
			vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
		end
		
		require("nvim-tree").setup({
			on_attach = my_on_attach,
			view = {width = 40,},
			actions = {
				open_file = {
					quit_on_open = true,
				}
			}
		})

	end,
}
