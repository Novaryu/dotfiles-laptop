return {
"L3MON4D3/LuaSnip",
event = "VeryLazy",
opts = {snip_env = {
		s = function(...)
			local ls = require("luasnip")
			local snip = ls.s(...)
			-- we can't just access the global `ls_file_snippets`, since it will be
			-- resolved in the environment of the scope in which it was defined.
			table.insert(getfenv(2).ls_file_snippets, snip)
		end,
		parse = function(...)
			local snip = ls.parser.parse_snippet(...)
			table.insert(getfenv(2).ls_file_snippets, snip)
		end,
		-- remaining definitions.
		...
	},
},
init = function()
	require("luasnip.loaders.from_lua").load({paths = "./snippets/"})
end,
}
