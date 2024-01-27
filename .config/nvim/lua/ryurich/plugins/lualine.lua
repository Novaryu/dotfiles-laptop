return {
"nvim-lualine/lualine.nvim",
dependencies = {"nvim-tree/nvim-web-devicons"},
event = "UIEnter",
lazy = true,
config = function()
	local lualine = require("lualine")
	local lazy_status = require("lazy.status")

	local function lineinfo()
	  local current_line = vim.fn.line('.')
	  local current_col = vim.fn.col('.')
	  local total_lines = vim.fn.line('$')
	  local total_cols = vim.fn.col('$')
	  -- local ln_symbol = vim.fn.nr2char(0xE0A1) -- Unicode for "LN" symbol
	  -- local cn_symbol = vim.fn.nr2char(0xE0A3) -- Unicode for "CN" symbol
	  local ln_symbol = vim.fn.nr2char(0x2630)
	  local cn_symbol = vim.fn.nr2char(0x2637)
		return string.format('%s %d/%d %s %d/%d', ln_symbol, current_line, total_lines, cn_symbol, current_col, total_cols)
	end

	lualine.setup({
		sections = {
			lualine_x = {
			{
				lazy_status.updates,
				cond = lazy_status.has_updates,
				color = { fg = "#ff9e64" },
			},
			{ "encoding" },
			{ "fileformat" },
			{ "filetype" },
			
			},
			lualine_z = {
			{ lineinfo },
			},
		},
	})
	-- Hide statusline by default
	vim.api.nvim_command('set laststatus=0 ruler')
end,
}
