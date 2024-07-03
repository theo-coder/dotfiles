return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			local icons = require("utils.icons").ui

			require("gitsigns").setup({
				signs = {
					add = {
						text = icons.BoldLineLeft,
					},
					change = {
						text = icons.BoldLineLeft,
					},
					delete = {
						text = icons.BoldLineLeft,
					},
					topdelete = {
						text = icons.BoldLineLeft,
					},
					changedelete = {
						text = icons.BoldLineLeft,
					},
				},
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
				},
				sign_priority = 6,
				status_formatter = nil,
				update_debounce = 150,
				max_file_length = 40000,
				preview_config = {
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},
}
