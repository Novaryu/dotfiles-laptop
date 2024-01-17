local port = os.getenv('GDScript_Port') or '6005'
local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
local pipe = '/tmp/godot.pipe'

local user_profile = vim.fn.expand('$USERPROFILE')
local godot_path = user_profile .. 'Godot/godot'

if vim.fn.has("win32") == 1 then
	cmd = {'ncat', '127.0.0.1', port}
	pipe = [[\\.\pipe\godot.pipe]]
	godot_path = user_profile .. '\\Documents\\Godot\\godot.exe'
end

vim.g.godot_executable = godot_path
local cwd = vim.fn.getcwd()
local is_running = false

-- Define key mappings
vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':GodotRun<CR>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<F6>', ':GodotRunCurrent<CR>', { noremap = true, silent = true })

vim.lsp.start({
	name = 'Godot',
	cmd = cmd,
	root_dir = cwd,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
	on_attach = function(client, bufnr)
		vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
		-- Set buffer-local options
		vim.api.nvim_exec([[
			setlocal foldmethod=expr
			setlocal tabstop=4
			setlocal shiftwidth=4
		]], true)
	end
})
