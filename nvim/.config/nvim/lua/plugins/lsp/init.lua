return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
			"VonHeikemen/lsp-zero.nvim",
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			require("fidget").setup({})
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"tsserver",
					"tailwindcss",
					"eslint",
					"emmet_ls",
					"jsonls",
				},
				handlers = {
					lsp_zero.default_setup,
				},
			})

			require("plugins.lsp.servers.lua_ls").setup()
			require("plugins.lsp.servers.rust_analyzer").setup()

			local cmp = require("cmp")
			local cmp_action = require("lsp-zero").cmp_action()

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-p>"] = cmp_action.luasnip_jump_backward(),
					["<C-n>"] = cmp_action.luasnip_jump_forward(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
			})

			lsp_zero.on_attach(function()
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
			end)

			-- 	sources = cmp.config.sources({
			-- 		{ name = "nvim_lsp" },
			-- 		{ name = "luasnip" },
			-- 	}, {
			-- 		{ name = "buffer" },
			-- 	}, {
			-- 		{ name = "path" },
			-- 	}),
			-- })
			--
			-- cmp.setup.cmdline({ "/", "?" }, {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = {
			-- 		{ name = "buffer" },
			-- 	},
			-- })
			--
			-- cmp.setup.cmdline(":", {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = cmp.config.sources({
			-- 		{ name = "path" },
			-- 	}, {
			-- 		{ name = "cmdline" },
			-- 	}),
			-- })
			--
			lsp_zero.setup()

			require("plugins.lsp.snippets.all")
		end,
	},
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			-- TODO: autocmds
			require("crates").setup({})
		end,
	},
}
