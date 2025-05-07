local M = {}

M.setup = function()
	return function()
		require("lspconfig").cssls.setup({
			settings = {
				css = {
					lint = { unknownAtRules = "ignore" },
				},
			},
		})
	end
end

return M
