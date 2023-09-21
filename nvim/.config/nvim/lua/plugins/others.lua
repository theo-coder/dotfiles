return {
	{ "nvim-lua/plenary.nvim" },
	{ "nacro90/numb.nvim", event = "BufReadPre", config = true },
	{ "nvim-tree/nvim-web-devicons", config = true },
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			-- background_colour = "#A3CCBE",
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		config = function(_, opts)
			require("notify").setup(opts)
			vim.notify = require("notify")
		end,
	},
	{
		"andymass/vim-matchup",
		event = { "BufReadPost" },
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{ "kylechui/nvim-surround", event = "BufReadPre" },
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		config = true,
		keys = { { "<leader>lt", "<cmd>TodoTelescope<cr>", desc = "ToDo" } },
	},
	{
		"m4xshen/hardtime.nvim",
		cmd = { "HardTime" },
		enabled = true,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
}
