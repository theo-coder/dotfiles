local icons = require("utils.icons").ui

return {
	"lewis6991/gitsigns.nvim",
	event = "User FileOpened",
	cmd = "Gitsigns",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		signs = {
			add = {
				hl = "GitSignsAdd",
				text = icons.BoldLineLeft,
				numhl = "GitSignsAddNr",
				linehl = "GitSignsAddLn",
			},
			change = {
				hl = "GitSignsChange",
				text = icons.BoldLineLeft,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
			delete = {
				hl = "GitSignsDelete",
				text = icons.Triangle,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			topdelete = {
				hl = "GitSignsDelete",
				text = icons.Triangle,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = icons.BoldLineLeft,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
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
		current_line_blame_formatter_opts = {
			relative_time = false,
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
		yadm = {
			enable = false,
		},
	},
}
