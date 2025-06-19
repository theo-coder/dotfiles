return {
	"utilyre/barbecue.nvim",
	event = "VeryLazy",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("barbecue").setup({})
	end,
}
