return {
"nvim-telescope/telescope.nvim",
dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"},
lazy = true,

config = function()
	require("telescope").setup{}
end
}
