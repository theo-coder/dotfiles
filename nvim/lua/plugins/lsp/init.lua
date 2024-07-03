return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "j-hui/fidget.nvim", opts = {} },
			{ "mrcjkb/rustaceanvim", version = "^4", lazy = false },
		},
		config = function()
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			require("mason").setup({
				"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"emmet_ls",
				"jsonls",
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

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({ capabilities = capabilities })
				end,
				["lua_ls"] = require("plugins.lsp.servers.lua_ls").setup(capabilities),
			})

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
					vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
					vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
				end,
			})

			require("plugins.lsp.snippets.all")
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
