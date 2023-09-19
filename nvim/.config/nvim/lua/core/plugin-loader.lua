local M = {}

local lazy_config = {
	install = {
		missing = true,
		colorscheme = { "nightfox", "habamax" },
	},
	ui = {
		border = "rounded",
	},
}

function M:init()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			lazypath,
		})
	end

	vim.opt.runtimepath:append(lazypath)
end

function M.load(plugins)
	local lazy_available, lazy = pcall(require, "lazy")

	if not lazy_available then
		return nil
	end

	local status_ok = xpcall(function()
		lazy.setup(plugins, lazy_config)
	end, debug.traceback)

	if not status_ok then
		print("problem detected loading plugin's configurations")
	end
end

return M
