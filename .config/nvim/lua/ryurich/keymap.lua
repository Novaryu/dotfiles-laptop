local function safeRequire(module)
	local success, loadedModule = pcall(require, module)
	if success then return loadedModule end
	vim.cmd.echo ("Error loading " .. module)
end

local wk = safeRequire("which-key")

local nvim_path = vim.fn.stdpath("config")

local dir_table

if vim.fn.has("win32") == 1 then
	dir_table =
	{
		[1] = "C:\\Users\\Ryu\\Documents\\Godot\\Omega\\",
		[2] = "I:\\Music\\",
		[3] = "C:\\Users\\Ryu\\Documents\\AutoIt\\",
		[4] = "C:\\Users\\Ryu\\Documents\\Obsidian\\ryurich\\FPGEE",
		[0] = "C:\\Users\\Ryu\\AppData\\Local\\nvim\\",
		[9] = "C:\\Users\\Ryu\\AppData\\Local\\nvim-data\\",
	}
else
	dir_table =
	{
		[1] = os.getenv("HOME") .. '/Godot/omega/',
		[2] = os.getenv("HOME") .. '/Music',
		[0] = nvim_path,
	}
end

local function navigate_to(id)
	if dir_table[id] then
		safeRequire("nvim-tree.api").tree.open(dir_table[id])
	else
		print("No directory of id " .. id .. " ")
	end
end

local function new_file()
	local file_dir
	if vim.fn.has("win32") == 1 then
		file_dir = os.getenv("USERPROFILE") .. '/Documents/Neovim/'
	else
		file_dir = os.getenv("HOME") .. '/Documents/Neovim/'
	end
	local file_name = vim.fn.input("File Name (+extension): ")
	if file_name and file_name ~= "" then
		vim.api.nvim_command('e ' .. file_dir .. file_name)
	else
		print("File creation aborted.")
	end
end

local function session_operation(operation, session_name)
    local session_path = nvim_path .. "/sessions/"

    if not session_name then
        session_name = vim.fn.input("Session Name: ")
        vim.api.nvim_command('echo ' .. vim.fn.shellescape(session_name))
    end
    if session_name and session_name ~= "" then
        if operation == 'save' then
            vim.api.nvim_command('SessionsSave ' .. session_path .. session_name .. ".session")
        elseif operation == 'load' then
            vim.api.nvim_command('SessionsLoad ' .. session_path .. session_name .. ".session")
        end
    else
        print("Save/Load aborted: No session name provided.")
    end
end

-- Git Mappings
local function git_commit()
    local commit_message = vim.fn.input("Commit message: ")
    if commit_message and commit_message ~= "" then
        vim.api.nvim_command([[!git commit -m ]] .. vim.fn.shellescape(commit_message))
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', true)
    else
        print("Commit aborted: No commit message provided.")
    end
end

-- Navigation Mappings
for i = 0, 9 do
	local key = i == 0 and '<leader>0' or '<leader>' .. i
	if dir_table[i] then
	wk.register({
		[key] = { function() navigate_to(i) end, "go to " .. dir_table[i]},
		["<leader>c" .. i] = { function() vim.cmd('cd ' .. dir_table[i]) navigate_to(i) end, "cd + go to " .. dir_table[i]},
	})
	end
end

-- CMP Mappings
local function toggle_menu()
	if safeRequire('cmp').visible() then
		safeRequire('cmp').close()
	else
		safeRequire('cmp').complete()
	end
end
vim.keymap.set({'i', 'n'}, '<C-e>', toggle_menu, { noremap = false, silent = true })

-- vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true, nowait = true})
-- Movement Remaps
vim.keymap.set('n', '<C-d>', '<C-d>zz', {noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', {noremap = true })
vim.keymap.set('n', 'G', 'Gzz', {noremap = true })
vim.keymap.set('n', 'n', 'nzzzv', {noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', {noremap = true })
-- Motion Remaps
vim.keymap.set({'n'}, '<A-j>', ":m +1<CR>", { noremap = true })
vim.keymap.set({'n'}, '<A-k>', ":m -2<CR>", { noremap = true })
vim.keymap.set({'v'}, '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set({'v'}, '<A-k>', ":m '>-2<CR>gv=gv", { noremap = true })
vim.keymap.set({'n'}, '<leader>o', 'o<Esc>k', { noremap = true })
vim.keymap.set({'n'}, '<leader>O', 'O<Esc>j', { noremap = true })
vim.keymap.set({'n', 'v', 'i'}, '<C-a>', '<esc>ggVG', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, '<leader>d', '\"_d', { noremap = true, silent = true, nowait = true})
vim.keymap.set({'n', 'v'}, '<leader>pa', ':put! \"<CR>', { noremap = true })
vim.keymap.set({'n', 'v'}, '<leader>pb', ':put \"<CR>', { noremap = true })
-- Window Remaps
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
-- Window Resizing Remaps
vim.keymap.set('n', '<C-Up>', '<C-W>+', { noremap = true })
vim.keymap.set('n', '<C-Down>', '<C-W>-', { noremap = true })
vim.keymap.set('n', '<C-Left>', '<C-W>>', { noremap = true })
vim.keymap.set('n', '<C-Right>', '<C-W><', { noremap = true })
-- Intendation Remaps
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
-- Program Remaps
vim.keymap.set({'n'}, '<leader>lp', ':term python %<CR>', { noremap = true })
-- Miscellaneous Remaps
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', ':update<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader><esc>', ':qa!<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>zt', ':Twilight<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>zz', ':ZenMode<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>zsh', ':set laststatus=0 ruler<CR>:set cmdheight=0<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>zss', ':set laststatus=3 ruler<CR>:set cmdheight=1<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<Esc>', '<Esc><Esc>:nohl<CR>:echo<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("n", "dd", function ()
	if vim.fn.getline(".") == "" then return '"_dd' end
	return "dd"
end, {expr = true})
vim.keymap.set("n", "J", "6j")
vim.keymap.set("n", "K", "6k")
vim.keymap.set("n", "H", "0^")
vim.keymap.set("n", "L", "$")

local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-K>", function() ls.jump(-1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

vim.keymap.set('n', '<leader>jt', require('treesj').toggle)
vim.keymap.set('n', '<leader>js', require('treesj').split)
vim.keymap.set('n', '<leader>jj', require('treesj').join)

wk.register({

["<C-S-j>"] = { "<cmd>CtrlSpaceGoDown<cr>", "Navigate to next buffer" },
["<C-S-k>"] = { "<cmd>CtrlSpaceGoUp<cr>", "Navigate to previous buffer" },
["<C-S-l>"] = { "<cmd>tabnext<cr>", "Natigate to next tab" },
["<C-S-h>"] = { "<cmd>tabprevious<cr>", "Navigate to previous tab" },

["<leader>t"] = { name = "tab" },
["<leader>tn"] = { "<cmd>tabnew<cr>", "Open a new tab" },
["<leader>q"] = { "<cmd>tabclose<cr>", "Close tab" },

["<leader>nf"] = { function() new_file() end, "new scratch file" },

["<S-q>"] = { "<cmd>bdelete<cr>", "close current buffer" },

-- Null-ls Mappings
["<leader>lf"] = { function() vim.lsp.buf.format() end, "LSP format" },
["<leader>ao"] = { function() safeRequire("sidebar-nvim").focus() end, "Open/Focus sidebar" },
["<leader>aq"] = { function() safeRequire("sidebar-nvim").close() end, "Close sidebar" },

-- Settings Remaps
["<leader>ln"] = { function() vim.cmd('set number!') vim.cmd('set relativenumber!') end, "toggle relative numbers"},
["<leader>lw"] = { function() vim.cmd('set wrap!') end, "toggle line wrap"},
["<leader>la"] = { function() vim.lsp.buf.code_action() end, "open code actions"},
["<leader>lc"] = { ":execute 'set colorcolumn=' . (&colorcolumn == '' ? '80,100' : '')<CR>", "toggle columns"},
["<leader>ls"] = { function() vim.cmd('set spell!') end, "toggle spell checker"},

-- Configuration Mappings
["<leader>v"] = { name = "neovim" },
["<leader>vi"] = { function() vim.cmd('edit ' .. nvim_path .. '/init.lua') end, "open init.lua"},
["<leader>vk"] = { function() vim.cmd('edit ' .. nvim_path .. '/lua/ryurich/keymap.lua') end, "open keymap.lua" },
["<leader>vp"] = { function() vim.cmd('edit ' .. nvim_path .. '/lua/ryurich/plugins/init.lua') end, "open plugins/init.lua"},
["<leader>vg"] = { function() vim.cmd('edit ' .. nvim_path .. '/lua/ryurich/config.lua') end, "open config.lua"},
["<leader>vc"] = { function() vim.cmd('cd ' .. vim.fn.expand('%:p:h')) end, "change directory to current file"},

-- Nvim-Tree Mappings
["<leader>e"] = { name = "explorer" },
["<leader>ex"] = { function() safeRequire("nvim-tree.api").tree.toggle() end, "toggle explorer" },
["<leader>eX"] = { function() safeRequire("nvim-tree.api").tree.toggle() vim.cmd('only') end, "toggle explorer (maximized)" },
["<leader>ed"] = { function() safeRequire("nvim-tree.api").tree.open(vim.fn.expand('%:p:h')) end, "explore current dir" },
["<leader>eD"] = { function() safeRequire("nvim-tree.api").tree.open(vim.fn.expand('%:p:h')) vim.cmd('only') end, "explorer current dir (maximized)" },
["<leader>ec"] = { function() safeRequire("nvim-tree.api").tree.open(vim.fn.getcwd()) end, "explore working dir" },
["<leader>eC"] = { function() safeRequire("nvim-tree.api").tree.open(vim.fn.getcwd()) vim.cmd('only') end, "explore working dir (maximized)" },

-- Telescope Mappings
["<leader>f"] = { name = "find" },
["<leader>ff"] = { function() safeRequire('telescope.builtin').find_files() end, "search files" },
["<leader>fg"] = { function() safeRequire('telescope.builtin').live_grep() end, "grep files" },
["<leader>fr"] = { function() safeRequire('telescope.builtin').oldfiles() end, "search recent files" },
["<leader>fh"] = { function() safeRequire('telescope.builtin').help_tags() end, "search help" },
["<leader>fb"] = { function() safeRequire('telescope.builtin').buffers(); vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true) end, "search buffers" },

-- Git Mappings
["<leader>g"] = { name = "git"},
["<leader>gs"] = { function() vim.cmd('!git status') end, "git status"},
["<leader>ga"] = { function() vim.cmd('!git add .') end, "git add all"},
["<leader>gc"] = { function() git_commit() end, "git commit"},
["<leader>gp"] = { function() vim.cmd('!git push') end, "git push"},
["<leader>gl"] = { function() vim.cmd('!git pull') end, "git pull"},

-- Session Mappings
["<leader>s"] = { name = "session"},
["<leader>ss"] = { function() session_operation('save') end, "save session"},
["<leader>sl"] = { function() session_operation('load') end, "load session"},
["<leader>so"] = { function() vim.cmd('SessionsStop') end, "stop session"},

-- Flash Mappings
["<leader>lt"] = { function() safeRequire("flash").toggle() end, "toggle flash search"},

-- Nvim-DAP Mappings
["<F4>"] = { function() safeRequire('dapui').toggle() end, "Toggle DAP Interface"},
["<F7>"] = { function() safeRequire('dap').terminate() end, "Terminate DAP"},
["<F8>"] = { function() safeRequire('dap').pause() end, "Pause DAP"},
["<F9>"] = { function() safeRequire('dap').continue() end, "Continue DAP"},
["<F10>"] = { function() safeRequire('dap').step_over() end, "Step over"},
["<F11>"] = { function() safeRequire('dap').step_into() end, "Step into"},
["<F12>"] = { function() safeRequire('dap').step_out() end, "Step out"},
["<Leader>bb"] = { function() safeRequire('dap').toggle_breakpoint() end, "Toggle Breakpoint"},
["<Leader>dr"] = { function() safeRequire('dap').repl.open() end, "Open repl"},
["<Leader>dl"] = { function() safeRequire('dap').run_last() end, "Run last"},

-- Cpp Mappings
["<leader>cs"] = { function() vim.cmd('Ouroboros') end, "switch between header and source"},

["<leader>es"] = { function() require("luasnip.loaders").edit_snippet_files() end, "edit snippets"},

})
