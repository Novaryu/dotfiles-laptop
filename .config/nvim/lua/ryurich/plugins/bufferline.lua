-- Trying the "vim way" of using buffers + tabs appropriately
return {
-- "akinsho/bufferline.nvim",
-- version = "*",
-- dependencies = {"moll/vim-bbye", "nvim-tree/nvim-web-devicons", "nvim-tree/nvim-tree.lua",},
-- event = {"UIEnter"},
-- config = function()
-- 	require("bufferline").setup({
-- 	options = {
-- 		diagnostics = "nvim_lsp",
-- 		indicator = {icon = '▎', style = 'icon', },
-- 		show_close_icon = false,
-- 		hover = {enabled = true, delay = 100, reveal = {'close'}},
-- 		offsets = {
-- 				{
-- 				filetype = "NvimTree",
-- 				text = "File Explorer",
-- 				text_align = "center",
-- 				separator = true,
-- 				}
-- 			},
-- 	},
-- 	
-- })
--
-- local wk = require("which-key")
-- wk.register({
-- ["<S-k>"] = { "<cmd>BufferLineCycleNext<cr>", "navigate to next buffer" },
-- ["<S-j>"] = { "<cmd>BufferLineCyclePrev<cr>", "navigate to previous buffer" },
-- ["<S-l>"] = { "<cmd>BufferLineMoveNext<cr>", "move buffer to the right" },
-- ["<S-h>"] = { "<cmd>BufferLineMovePrev<cr>", "move buffer to the left" },
--
-- ["<leader>b"] = { name = "buffer" },
-- ["<leader>bn"] = { "<cmd>enew<cr>", "open a new buffer" },
-- ["<leader>be"] = { "<cmd>BufferLineCloseOthers<cr>", "close all other buffers" },
-- ["<leader>bw"] = { "<cmd>BufferLineCloseLeft<cr>", "close buffers to the left" },
-- ["<leader>br"] = { "<cmd>BufferLineCloseRight<cr>", "close buffers to the right" },
--
-- ["<S-q>"] = { "<cmd>Bdelete<cr>", "close current buffer" },
-- })
--
-- end,
}
