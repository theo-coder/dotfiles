return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {},
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},
}
