-- TODO: Pass to fzf-lua
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"olacin/telescope-cc.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"ahmedkhalf/project.nvim",
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
					find_command = {
						"rg",
						"--files",
						"--glob",
						"!{.git/*,.next/*,target/*,node_modules/*,.sqlx/*}",
						"--path-separator",
						"/",
					},
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("conventional_commits")
		telescope.load_extension("projects")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>")
		vim.keymap.set("n", "<leader>pg", "<cmd>Telescope git_files<cr>")
		vim.keymap.set("n", "<leader>pb", "<cmd>Telescope buffers<cr>")
		vim.keymap.set("n", "<leader>pn", "<cmd>Telescope notify<cr>")
		vim.keymap.set("n", "<leader>pp", "<cmd>Telescope projects<cr>")

		vim.keymap.set("n", "<leader>gc", "<cmd>Telescope conventional_commits<cr>")

		vim.keymap.set("n", "<leader>sh", builtin.help_tags)
		vim.keymap.set("n", "<leader>sw", builtin.grep_string)
		vim.keymap.set("n", "<leader>sg", builtin.live_grep)
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics)
	end,
}
