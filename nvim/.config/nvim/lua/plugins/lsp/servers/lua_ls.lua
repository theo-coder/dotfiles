local M = {}

M.setup = function()
	require("lspconfig").lua_ls.setup({
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "opts" },
				},
			},
		},
	})
end

return M
