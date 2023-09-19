local M = {}

function M:init()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	require("core.keymaps"):load()
	require("core.settings"):load()
	require("core.autocmds"):load()

	local plugin_loader = require("core.plugin-loader")
	local plugins = require("plugins")

	plugin_loader:init()
	plugin_loader.load(plugins)
end

return M
