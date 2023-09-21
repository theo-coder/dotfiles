local function get_codelldb()
	local mason_registry = require("mason-registry")
	local codelldb = mason_registry.get_package("codelldb")
	local extension_path = codelldb:get_install_path() .. "/extension/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = ""
	if vim.loop.os_uname().sysname:find("Windows") then
		liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
	elseif vim.fn.has("mac") == 1 then
		liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
	else
		liblldb_path = extension_path .. "lldb/lib/liblldb.so"
	end
	return codelldb_path, liblldb_path
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", config = true },
			{ "j-hui/fidget.nvim", tag = "legacy", config = true },
			{ "smjonas/inc-rename.nvim", config = true },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"simrat39/rust-tools.nvim",
			"rust-lang/rust.vim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		opts = {
			servers = {
				dockerls = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								runBuildScripts = true,
							},
							-- Add clippy lints for Rust.
							checkOnSave = {
								allFeatures = true,
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
				taplo = {},
			},
			setup = {
				rust_analyzer = function(_, opts)
					local codelldb_path, liblldb_path = get_codelldb()
					local lsp_utils = require("plugins.lsp.utils")
					lsp_utils.on_attach(function(client, bufnr)
						local map = function(mode, lhs, rhs, desc)
							if desc then
								desc = desc
							end
							vim.keymap.set(
								mode,
								lhs,
								rhs,
								{ silent = true, desc = desc, buffer = bufnr, noremap = true }
							)
						end
						if client.name == "rust_analyzer" then
							map("n", "<leader>le", "<cmd>RustRunnables<cr>", "Runnables")
							map("n", "<leader>ll", function()
								vim.lsp.codelens.run()
							end, "Code Lens")
							map("n", "<leader>lt", "<cmd>Cargo test<cr>", "Cargo test")
							map("n", "<leader>lR", "<cmd>Cargo run<cr>", "Cargo run")
						end
					end)

					vim.api.nvim_create_autocmd({ "BufEnter" }, {
						pattern = { "Cargo.toml" },
						callback = function(event)
							local bufnr = event.buf

							-- Register keymappings
							-- local wk = require "which-key"
							-- local keys = { mode = { "n", "v" }, ["<leader>lc"] = { name = "+Crates" } }
							-- wk.register(keys)

							local map = function(mode, lhs, rhs, desc)
								if desc then
									desc = desc
								end
								vim.keymap.set(
									mode,
									lhs,
									rhs,
									{ silent = true, desc = desc, buffer = bufnr, noremap = true }
								)
							end
							map("n", "<leader>lc", function() end, "+Crates")
							map("n", "<leader>lcy", "<cmd>lua require'crates'.open_repository()<cr>", "Open Repository")
							map("n", "<leader>lcp", "<cmd>lua require'crates'.show_popup()<cr>", "Show Popup")
							map("n", "<leader>lci", "<cmd>lua require'crates'.show_crate_popup()<cr>", "Show Info")
							map(
								"n",
								"<leader>lcf",
								"<cmd>lua require'crates'.show_features_popup()<cr>",
								"Show Features"
							)
							map(
								"n",
								"<leader>lcd",
								"<cmd>lua require'crates'.show_dependencies_popup()<cr>",
								"Show Dependencies"
							)
						end,
					})

					require("rust-tools").setup({
						tools = {
							hover_actions = { border = "solid" },
							on_initialized = function()
								vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
							end,
						},
						server = opts,
						dap = {
							adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
						},
					})
					return true
				end,
			},
			format = {
				timeout_ms = 3000,
			},
		},
		config = function(plugin, opts)
			require("plugins.lsp.servers").setup(plugin, opts)
		end,
	},
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			null_ls = {
				enabled = true,
				name = "crates.nvim",
			},
			popup = {
				border = "rounded",
			},
		},
		config = function(_, opts)
			require("crates").setup(opts)
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"stylua",
				"ruff",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim", "nvim-lua/plenary.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf", "Makefile", ".git"),
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.diagnostics.ruff.with({ extra_args = { "--max-line-length=180" } }),
				},
			}
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		opts = { ensure_installed = nil, automatic_installation = true, automatic_setup = false },
	},
	{
		"utilyre/barbecue.nvim",
		event = "VeryLazy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local bbq = require("barbecue")

			bbq.setup({
				exclude_filetypes = {},
			})
		end,
	},
}
