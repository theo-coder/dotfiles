return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"b0o/schemastore.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "mrcjkb/rustaceanvim", version = "^6", lazy = false },
		},
		config = function()
			require("mason").setup({})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jsonls",
					"cssls",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"stylua",
					"isort",
					"black",
					"pylint",
					"eslint_d",
				},
			})

			require("plugins.lsp.handlers")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function()
					vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>")
					vim.keymap.set("n", "gD", "<cmd>Telescope lsp_declarations<cr>")
					vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>")
					vim.keymap.set("n", "gb", "<cmd>Telescope lsp_type_definitions<cr>")
					vim.keymap.set("n", "K", vim.lsp.buf.hover)
					vim.keymap.set("n", "gK", vim.lsp.buf.signature_help)
					vim.keymap.set("n", "<leader>dn", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end)
					vim.keymap.set("n", "<leader>dp", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
				end,
			})
		end,
	},
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup({})
		end,
	},
}
