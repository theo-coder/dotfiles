local icons = require("utils.icons").ui
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	cmd = "WhichKey",
	config = function()
		local status_ok, wk = pcall(require, "which-key")
		if not status_ok then
			return
		end

		wk.register({
			[";"] = { "<cmd>Alpha<cr>", "Dashboard" },
			["w"] = { "<cmd>w!<cr>", "Save" },
			["Q"] = { "<cmd>confirm q<cr>", "Quit" },
			[":"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
			["h"] = { "<cmd>nohlsearch<cr>", "No Highlight" },
			["e"] = { "<cmd>Ex<cr>", "Explorer" },
			p = {
				name = "PLUGINS",
				i = { "<cmd>Lazy install<cr>", "[PLUGINS] Install" },
				s = { "<cmd>Lazy sync<cr>", "[PLUGINS] Sync" },
				S = { "<cmd>Lazy clear<cr>", "[PLUGINS] Status" },
				c = { "<cmd>Lazy clean<cr>", "[PLUGINS] Clean" },
				u = { "<cmd>Lazy update<cr>", "[PLUGINS] Update" },
				p = { "<cmd>Lazy profile<cr>", "[PLUGINS] Profile" },
				l = { "<cmd>Lazy log<cr>", "[PLUGINS] Log" },
				d = { "<cmd>Lazy debug<cr>", "[PLUGINS] Debug" },
			},
			q = {
				name = "TELESCOPE",
				f = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find file" },
				g = { "<cmd>Telescope live_grep<cr>", "[TELESCOPE] Search by grep" },
				b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
			},
			l = {
				name = "LSP",
				a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "[LSP] Code Action" },
				d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "[LSP] Buffer diagnostics" },
				w = { "<cmd>Telescope diagnostics<cr>", "[LSP] Diagnostics" },
				f = { "<cmd>Format<cr>", "[LSP] Format" },
				i = { "<cmd>LspInfo<cr>", "[LSP] Info" },
				I = { "<cmd>Mason<cr>", "[LSP] Mason Info" },
				j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "[LSP] Next diagnostic" },
				k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "[LSP] Previous diagnostic" },
				l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "[LSP] CodeLens Action" },
				q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "[LSP] Quickfix" },
				r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[LSP] Rename" },
				s = { "<cmd>Telescope lsp_document_symbols<cr>", "[LSP] Document symbols" },
				S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "[LSP] Workspace symbols" },
				e = { "<cmd>Telescope quickfix<cr>", "[LSP] Telescope quickfix" },
			},
			g = {
				name = "GIT",
				s = { "<cmd>Gitsigns toggle_signs<cr>", "[GIT] Toggle signs" },
				h = { "<cmd>Gitsigns preview_hunk<cr>", "[GIT] Preview hunk" },
				d = { "<cmd>Gitsigns diffthis<cr>", "[GIT] Diff" },
				n = { "<cmd>Gitsigns next_hunk<cr>", "[GIT] Next hunk" },
				p = { "<cmd>Gitsigns prev_hunk<cr>", "[GIT] Prev hunk" },
				f = { "<cmd>Telescope git_status<cr>", "[GIT] Files status" },
				c = { "<cmd>Telescope conventional_commits<cr>", "[GIT] Commits" },
				b = { "<cmd>Telescope git_branches<cr>", "[GIT] Branches" },
			},
			b = {
				name = "BUFFERS",
				n = { "<cmd>bn<cr>", "[BUFFER] Next buffer" },
				p = { "<cmd>bp<cr>", "[BUFFER] Previous buffer" },
				q = { "<cmd>bd<cr>", "[BUFFER] Close current buffer" },
				Q = { "<cmd>%bd|e#|bd#<cr>", "[BUFFER] Close other buffers" },
			},
		}, {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		})

		wk.setup({
			plugins = {
				makrs = false,
				registers = false,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = false,
					motions = false,
					text_objects = false,
					windows = false,
					nav = false,
					z = false,
					g = false,
				},
			},
			operators = { gc = "Comments" },
			key_labels = {},
			icons = {
				breadcrumb = icons.ArrowOutlineRight,
				separator = icons.DividerRight,
				group = icons.Label .. " ",
			},
			popup_mappings = {
				scroll_down = "<c-d>",
				scroll_up = "<c-u>",
			},
			window = {
				border = "single",
				position = "bottom",
				margin = { 1, 0, 1, 0 },
				padding = { 2, 2, 2, 2 },
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 },
				width = { min = 20, max = 50 },
				spacing = 3,
				align = "left",
			},
			ignore_missing = true,
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "<cr>", "call", "lua", "^:", "^ " },
			show_help = true,
			show_keys = true,
			triggers = "auto",
			triggers_blacklist = {
				i = { "j", "k" },
				v = { "j", "k" },
			},
			disable = {
				buftypes = {},
				filetypes = { "TelescopePrompt" },
			},
		})
	end,
}
