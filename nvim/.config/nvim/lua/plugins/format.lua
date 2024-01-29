return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local format_options = { lsp_fallback = true, async = false, timeout = 500 }

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = format_options,
		})

		vim.keymap.set("n", "<leader>f", function()
			conform.format(format_options)
		end)
	end,
}
