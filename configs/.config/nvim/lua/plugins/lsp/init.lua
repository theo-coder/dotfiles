return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"ray-x/lsp_signature.nvim",
		},
		config = function()
			-- Setup language servers.

			-- Rust
			vim.lsp.config("rust_analyzer", {
				-- Server-specific settings. See `:help lspconfig-setup`
				settings = {
					["rust-analyzer"] = {
						cargo = {
							features = "all",
						},
						checkOnSave = {
							enable = true,
						},
						check = {
							command = "clippy",
						},
						imports = {
							group = {
								enable = false,
							},
						},
						completion = {
							postfix = {
								enable = false,
							},
						},
					},
				},
			})
			vim.lsp.enable("rust_analyzer")

			-- Typescript LSP
			if vim.fn.executable("typescript-language-server") == 1 then
				vim.lsp.config("typescript-language-server", {
					cmd = { "typescript-language-server", "--stdio" },
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"javascript.jsx",
						"typescript.tsx",
					},
					root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
				})
				vim.lsp.enable("typescript-language-server")
			end

			-- TailwindCSS
			if vim.fn.executable("tailwindcss-language-server") == 1 then
				vim.lsp.config("tailwindcss", {
					cmd = { "tailwindcss-language-server", "--stdio" },
					filetypes = {
						"astro",
						"astro-markdown",
						"blade",
						"clojure",
						"django-html",
						"htmldjango",
						"edge",
						"eelixir",
						"elixir",
						"erb",
						"eruby",
						"gohtml",
						"gohtmltmpl",
						"haml",
						"handlebars",
						"hbs",
						"html",
						"html-eex",
						"heex",
						"jade",
						"leaf",
						"liquid",
						"markdown",
						"mdx",
						"mustache",
						"njk",
						"nunjucks",
						"php",
						"razor",
						"slim",
						"twig",
						"css",
						"less",
						"postcss",
						"sass",
						"scss",
						"stylus",
						"sugarss",
						"javascript",
						"javascriptreact",
						"reason",
						"rescript",
						"typescript",
						"typescriptreact",
						"vue",
						"svelte",
					},
					root_markers = {
						"tailwind.config.js",
						"tailwind.config.cjs",
						"tailwind.config.mjs",
						"tailwind.config.ts",
						"postcss.config.js",
						"postcss.config.cjs",
						"postcss.config.mjs",
						"postcss.config.ts",
						"package.json",
						"node_modules",
						".git",
					},
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									{ "tw`([^`]*)", "tw" },
									{ "clsx\\(([^)]*)\\)", "clsx" },
								},
							},
						},
					},
				})

				vim.lsp.enable("tailwindcss")
			end

			-- Bash LSP
			if vim.fn.executable("bash-language-server") == 1 then
				vim.lsp.enable("bashls")
			end

			-- texlab for LaTeX
			if vim.fn.executable("texlab") == 1 then
				vim.lsp.enable("texlab")
			end

			-- Ruff for Python
			if vim.fn.executable("ruff") == 1 then
				vim.lsp.enable("ruff")
			end

			-- nil for nix
			if vim.fn.executable("nil") == 1 then
				vim.lsp.enable("nil_ls")
			end

			-- prisma
			if vim.fn.executable("prisma-language-server") == 1 then
				vim.lsp.enable("prismals")
			end

			-- diagnostics
			vim.lsp.config("*", {
				on_attach = function(client, bufnr)
					-- some clients support workspace diagnostics natively
					if client:supports_method("workspace/diagnostic", bufnr) then
						vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
					else
						require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
					end
				end,
			})

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set("n", "<leader>dn", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end)
					vim.keymap.set("n", "<leader>dp", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client and client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
					end

					-- None of this semantics tokens business.
					-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
					client.server_capabilities.semanticTokensProvider = nil

					-- format on save for Rust
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("RustFormat", { clear = true }),
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
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
-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		dependencies = {
-- 			"mason-org/mason.nvim",
-- 			"mason-org/mason-lspconfig.nvim",
-- 			"WhoIsSethDaniel/mason-tool-installer.nvim",
-- 			"b0o/schemastore.nvim",
-- 			{ "j-hui/fidget.nvim", opts = {} },
-- 			{ "mrcjkb/rustaceanvim", version = "^6", lazy = false },
-- 		},
-- 		config = function()
-- 			require("mason").setup({})

-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = {
-- 					"lua_ls",
-- 					"jsonls",
-- 					"cssls",
-- 				},
-- 			})

-- 			require("mason-tool-installer").setup({
-- 				ensure_installed = {
-- 					"prettier",
-- 					"stylua",
-- 					"isort",
-- 					"black",
-- 					"pylint",
-- 					"eslint_d",
-- 				},
-- 			})

-- 			require("plugins.lsp.handlers")

-- 			vim.api.nvim_create_autocmd("LspAttach", {
-- 				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
-- 				callback = function()
-- 					vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
-- 					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>")
-- 					vim.keymap.set("n", "gD", "<cmd>Telescope lsp_declarations<cr>")
-- 					vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>")
-- 					vim.keymap.set("n", "gb", "<cmd>Telescope lsp_type_definitions<cr>")
-- 					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
-- 					vim.keymap.set("n", "K", vim.lsp.buf.hover)
-- 					vim.keymap.set("n", "gK", vim.lsp.buf.signature_help)
-- 					vim.keymap.set("n", "<leader>dn", function()
-- 						vim.diagnostic.jump({ count = 1, float = true })
-- 					end)
-- 					vim.keymap.set("n", "<leader>dp", function()
-- 						vim.diagnostic.jump({ count = -1, float = true })
-- 					end)
-- 					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
-- 				end,
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"Saecki/crates.nvim",
-- 		event = { "BufRead Cargo.toml" },
-- 		config = function()
-- 			require("crates").setup({})
-- 		end,
-- 	},
-- }

