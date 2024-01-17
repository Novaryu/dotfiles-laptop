 return {
"folke/trouble.nvim",
lazy = true,
event = {"BufReadPre", "BufNewFile"},
dependencies = {"nvim-tree/nvim-web-devicons"},
opts = {padding = false},
config = function()
local wk = require("which-key")
wk.register({
["<leader>x"] = { name = "diagnostics" },
["<leader>xx"] = { function() require("trouble").toggle() end, "toggle diagnostics"},
["<leader>xw"] = { function() require("trouble").open("workspace_diagnostics") end, "workspace diagnostics"},
["<leader>xd"] = { function() require("trouble").open("document_diagnostics") end, "document diagnostics"},
["<leader>xq"] = { function() require("trouble").open("quickfix") end, "quickfix"},
["<leader>xl"] = { function() require("trouble").open("loclist") end, "loclist"},
["gR"] = { function() require("trouble").open("lsp_references") end, "LSP reference"},
})
end,
}
