return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-project.nvim",
			"ahmedkhalf/project.nvim",
			"olacin/telescope-cc.nvim",
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				pickers = {
					live_grep = {
						additional_args = function()
							return { "--ignore-file-case-insensitive", "--hidden", "-g", "!.git" }
						end,
					},
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("project")
			telescope.load_extension("projects")
			telescope.load_extension("conventional_commits")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>pf", require("utils").find_files)
			vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
			vim.keymap.set("n", "<leader>gc", "<cmd>Telescope conventional_commits<cr>")

			vim.keymap.set("n", "<leader>sh", builtin.help_tags)
			vim.keymap.set("n", "<leader>sw", builtin.grep_string)
			vim.keymap.set("n", "<leader>sg", builtin.live_grep)
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics)
		end,
	},
}
