vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.CtrlSpaceDefaultMappingKey = "<C-space> "
vim.g.CtrlSpaceSaveWorkspaceOnSwitch = 1
vim.g.CtrlSpaceSaveWorkspaceOnExit = 1

-- NEOVIM OPTIONS

local opt = vim.opt

vim.o.sessionoptions = vim.o.sessionoptions .. ",globals"
opt.termguicolors = true -- for highlight groups

-- opt.number = true
-- opt.relativenumber = true
opt.mouse='a'
opt.mousemoveevent = true
opt.clipboard = opt.clipboard + 'unnamedplus'

opt.autoindent = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.wrap = false

opt.swapfile = false
opt.shadafile='NONE'
opt.scrolloff=8
opt.sidescrolloff=8

-- opt.colorcolumn = '80,100'
opt.cursorline = true
opt.showmode = false
opt.completeopt = 'menuone,preview'

opt.laststatus=3
-- Hide command bar and tabline
opt.cmdheight=0
opt.showtabline=0

opt.encoding = 'UTF-8'
opt.guifont = 'FiraCode\\ Nerd\\ Font\\ Mono:h12'

opt.timeout = true
opt.timeoutlen = 300
-- PROVIDERS

if vim.fn.has("win32") == 1 then
    -- Windows
    vim.g.python3_host_prog = 'C:/Python311/python.exe'
else
    -- Linux or other OS
    vim.g.python3_host_prog = '/usr/bin/python' -- Replace with the correct path for your Linux system
end

-- vim.g.python3_host_prog= 'C:/Python311/python.exe'
-- vim.g.ruby_host_prog = 'C:/tools/ruby31/bin/ruby.exe'
-- vim.g.nodejs_host_prog = 'C:/Program Files/nodejs/node.exe'
-- let g:perl_host_prog = 'C:/Strawberry/perl/bin/perl.exe'
vim.g.loaded_perl_provider = 0

_G.new_file = function()
	local file_dir = os.getenv("USERPROFILE") .. '\\Documents\\Neovim\\'
	file_name = vim.fn.input("File Name (+extension): ")
	if file_name and file_name ~= "" then
		vim.api.nvim_command('e ' .. file_dir .. file_name)
	else
		print("File creation aborted.")
	end
end
