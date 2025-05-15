vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

vim.lsp.config("cssls", {
	settings = {
		css = {
			lint = { unknownAtRules = "ignore" },
		},
	},
})
