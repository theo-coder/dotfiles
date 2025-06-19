return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local todo_comments = require("todo-comments")

		vim.keymap.set("n", "<leader>tn", function()
			todo_comments.jump_next()
		end)
		vim.keymap.set("n", "<leader>tp", function()
			todo_comments.jump_prev()
		end)
		vim.keymap.set("n", "<leader>pt", "<cmd>TodoTelescope<cr>")

		todo_comments.setup({})
	end,
}
