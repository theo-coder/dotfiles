return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local format_options = { lsp_fallback = true, async = false, timeout = 500 }

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
			},
			format_on_save = format_options,
		})

		vim.keymap.set("n", "<leader>f", function()
			conform.format(format_options)
		end)
	end,
}
