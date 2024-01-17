return {
"nvimtools/none-ls.nvim",
ft = {"gdscript", "gdresource", "python", "c", "cpp"},
dependencies = {"nvim-lua/plenary.nvim"},
config = function()
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.gdformat.with({
			timeout = 10000,
		}),
		-- null_ls.builtins.diagnostics.gdlint,

		-- null_ls.builtins.diagnostics.cpplint,
		-- null_ls.builtins.diagnostics.clang_check,
		-- null_ls.builtins.formatting.clang_format,

		-- null_ls.builtins.formatting.autoflake,
		-- null_ls.builtins.diagnostics.ruff, 
	},
})
end,
}
