return {

	-- PLUGINS NOT YET ADDED BUT CONSIDERING:
	-- https://github.com/monaqa/dial.nvim -- increment/decrement plugin
	-- https://github.com/debugloop/telescope-undo.nvim -- undo tree
	-- https://github.com/nvim-neorg/neorg -- organization plugin

	-- Keymapper and Key Legend
	{"folke/which-key.nvim", lazy = true},
	{"alexanderbluhm/black.nvim", event = "VeryLazy"},

	-- Session manager
	{ "natecraddock/sessions.nvim", config = true, event = "VeryLazy",},

	-- Visually display indentation lines
    {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, config = true, event = {"BufReadPre", "BufNewFile"}},
	-- Visually display marks
    {"chentoast/marks.nvim", config = true, event = {"BufReadPre", "BufNewFile"}},
	-- Visually display "TODO" labels, etc.
    {"folke/todo-comments.nvim", config = true, dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "folke/trouble.nvim",},
	event = {"BufReadPre"},
	keys = {
		{"<leader>tf", "<cmd>TodoTelescope<cr><esc>", desc = "Todo Search"},
		{"<leader>tx", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble"},
	},},

	-- Effortlessly leave insert mode with custom mapping
	{"max397574/better-escape.nvim", config = true, opts = {mapping = {"jj", "kk", "jk", "kj"}}, event = "VeryLazy",},

	-- Easily comment/uncomment
	{"numToStr/Comment.nvim", config = true, event = {"BufReadPre", "BufNewFile"}},

	{"windwp/nvim-autopairs", opts = {}, event = "InsertEnter"},
	{"folke/neodev.nvim", opts = {lspconfig = false} },

	-- Training for motions
	{"tjdevries/train.nvim", keys = {
		{"<leader>tv", "<cmd>TrainUpDown<cr>", desc = "Train Up/Down"},
		{"<leader>tw", "<cmd>TrainWord<cr>", desc = "Train Words"},
		{"<leader>to", "<cmd>TrainTextObj<cr>", desc = "Train Text Objects"},
	},},

	-- Visual Productivity
	{ "folke/zen-mode.nvim", opts = {
		plugins = {
			options = {
				laststatus = 1,
			},
			twilight = { enabled=false },
		},
	}, cmd = "ZenMode"},
	{ "folke/twilight.nvim", opts = {}, cmd = "Twilight"},
	{ "shortcuts/no-neck-pain.nvim", config = true, cmd = "NoNeckPain", opts = {width = 100},
		keys = {{"<leader>nn", "<cmd>NoNeckPain<cr>", desc = "No Neck Pain"}}, },
	{ "norcalli/nvim-colorizer.lua", config = true, opts = {'*';}, event = "VeryLazy"},

	-- LSP and context-specific
	{ "neovim/nvim-lspconfig", event = "VeryLazy"},
	{ "habamax/vim-godot", ft = {"gdscript", "gdresource"}},
	{ "iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},

	-- CPP specific
	{ "jakemason/ouroboros.nvim", dependencies = {"nvim-lua/plenary.nvim"}, event = "BufEnter" },

	{ "vim-ctrlspace/vim-ctrlspace"},

	-- Integrate in after/ftplugin later
	-- { "artempyanykh/marksman", lazy = true, config = true, ft = "markdown"},

	-- { "nvim-telescope/telescope-dap.nvim", event = "VeryLazy"},
	{
	  "Wansmer/treesj",
	  keys = { '<space>jj', '<space>js', '<space>jt' },
	  dependencies = { 'nvim-treesitter/nvim-treesitter' },
	  config = function()
		require('treesj').setup({use_default_keymaps=false,})
	  end,
	}

}
