return {
	"hrsh7th/nvim-cmp",
	event = {"InsertEnter", "CmdlineEnter"}, 
	dependencies = {
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-calc",
	},

	config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = {
		['<M-m>'] = cmp.mapping.scroll_docs(-4),
		['<M-n>'] = cmp.mapping.scroll_docs(4),
		['<C-c>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_next_item()
		  -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
		  -- that way you will only jump inside the snippet region
		  elseif luasnip.expand_or_locally_jumpable() then
			luasnip.expand_or_jump()
		  elseif has_words_before() then
			cmp.complete()
		  else
			fallback()
		  end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
		  if cmp.visible() then
			cmp.select_prev_item()
		  elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		  else
			fallback()
		  end
		end, { "i", "s" }),
		},
		formatting = {
			fields = { "abbr", "menu", "kind" },
			format = function(entry, item)
				-- Define menu shorthand for different completion sources.
				local menu_icon = {
					nvim_lsp = "NLSP",
					nvim_lua = "NLUA",
					luasnip  = "LSNP",
					buffer   = "BUFF",
					path     = "PATH",
				}
				-- Set the menu "icon" to the shorthand for each completion source.
				item.menu = menu_icon[entry.source.name]

				-- Set the fixed width of the completion menu to 60 characters.
				-- fixed_width = 20

				-- Set 'fixed_width' to false if not provided.
				-- local fixed_width = 30
				fixed_width = fixed_width or false

				-- Get the completion entry text shown in the completion window.
				local content = item.abbr

				-- Set the fixed completion window width.
				if fixed_width then
					vim.o.pumwidth = fixed_width
				end

				-- Get the width of the current window.
				local win_width = vim.api.nvim_win_get_width(0)

				-- Set the max content width based on either: 'fixed_width'
				-- or a percentage of the window width, in this case 20%.
				-- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
				local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.4)

				-- Truncate the completion entry text if it's longer than the
				-- max content width. We subtract 3 from the max content width
				-- to account for the "..." that will be appended to it.
				if #content > max_content_width then
					item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
				-- else
				-- 	item.abbr = content .. (" "):rep(max_content_width - #content)
				end
				return item
			end,
		},
		sources = cmp.config.sources({
			{ name = 'nvim_lsp', max_item_count = 100 },
			{ name = 'nvim_lsp_signature_help' },
			{ name = 'luasnip' },
			{ name = 'calc' },
		}, {
		{ name = 'buffer' },
		})
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
		},	{
			{ name = 'buffer' },
		})
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp_document_symbol' }
		},  {
			{ name = 'buffer' }
		})
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		},	{
			{ name = 'cmdline', 
			  option = { 
				ignore_cmds = {'Man', '!', '%s'}
			  }
			}
		})
	}) 
  end
}
