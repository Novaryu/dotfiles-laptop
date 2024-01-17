return {
"mfussenegger/nvim-dap", 
dependencies = {"rcarriga/nvim-dap-ui", "nvim-telescope/telescope-dap.nvim", "nvim-telescope/telescope.nvim"},
ft = {"gdscript", "gdresource"},
config = function()
	local dap = require('dap')
	dap.adapters.godot = {
	  type = "server",
	  host = '127.0.0.1',
	  port = 6006,
	}
	dap.configurations.gdscript = {
	  {
		type = "godot",
		request = "launch",
		name = "Launch scene",
		project = "${workspaceFolder}",
		launch_scene = true,
	  }
	}

	vim.fn.sign_define('DapBreakpoint',{ text ='🔴', texthl ='', linehl ='', numhl =''})
	vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

	-- telescope-dap Configuration
	require('telescope').load_extension('dap')

	-- nvim-dap-ui Configuration
	require("dapui").setup({
		layouts = { {
			elements = { {
				id = "watches",
				size = 0.10
			  }, {
				id = "stacks",
				size = 0.20
			  }, {
				id = "breakpoints",
				size = 0.20
			  }, {
				id = "scopes",
				size = 0.50
			  } },
			position = "left",
			size = 40
		  }, {
			elements = { {
				id = "repl",
				size = 0.5
			  }, {
				id = "console",
				size = 0.5
			  } },
			position = "bottom",
			size = 20
		  } },
	})

	local dap, dapui = require("dap"), require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
	  dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
	  dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
	  dapui.close()
	end
end,
}
