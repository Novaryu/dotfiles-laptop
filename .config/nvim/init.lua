local function safeRequire(module)
	local success, loadedModule = pcall(require, module)
	if success then return loadedModule end
	vim.cmd.echo ("Error loading " .. module)
end
safeRequire("ryurich.config")
safeRequire("ryurich.lazy")
safeRequire("ryurich.keymap")
