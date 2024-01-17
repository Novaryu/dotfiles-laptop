return {
"xiyaowong/transparent.nvim",
lazy = false,
init = function()
	require("which-key").register({
	["<leader>tt"] = { "<cmd>TransparentToggle<cr>", "toggle transparent background"},
	}) 
end,
config = function()
	-- Defaults to off
	vim.cmd("TransparentDisable")
end,
}
