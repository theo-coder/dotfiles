return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/nvim-nio",
		"mrcjkb/rustaceanvim",
	},
	config = function()
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				require("neotest-vitest"),
				require("neotest-plenary"),
				require("rustaceanvim.neotest"),
			},
		})

		vim.keymap.set("n", "<leader>tc", function()
			neotest.run.run()
		end)
	end,
}
