return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"ahmedkhalf/project.nvim",
	},
	config = function()
		local telescope = require("telescope")

		telescope.load_extension("fzf")
		telescope.load_extension("projects")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>pf", builtin.find_files)
		vim.keymap.set("n", "<leader>sh", builtin.help_tags)
		vim.keymap.set("n", "<leader>sw", builtin.grep_string)
		vim.keymap.set("n", "<leader>sg", builtin.live_grep)
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics)
	end,
}
