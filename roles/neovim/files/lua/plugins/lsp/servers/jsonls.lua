local M = {}

M.setup = function(capabilities)
	return function()
		require("lspconfig").jsonls.setup({
			capabilities = capabilities,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
	end
end

return M
