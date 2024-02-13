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
		},
		config = function()
			require("fidget").setup({})
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer" },
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,

					["lua_ls"] = require("plugins.lsp.servers.lua_ls"),
					["rust_analyzer"] = require("plugins.lsp.servers.rust_analyzer"),
				},
			})

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

			local cmp = require("cmp")
			local ls = require("luasnip")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

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
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif ls.expand_or_jumpable() then
							ls.expand_or_jump()
						elseif require("utils").has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s", "c" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif ls.jumpable(-1) then
							ls.jump(-1)
						else
							fallback()
						end
					end, { "i", "s", "c" }),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}, {
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

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
