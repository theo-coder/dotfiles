return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "rust", "toml" },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
				config = {
					typescript = "// %s",
					css = "/* %s */",
					scss = "/* %s */",
					html = "<!-- %s -->",
					svelte = "<!-- %s -->",
					vue = "<!-- %s -->",
					json = "",
				},
			},
			autotag = { enable = true },
		})

		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "nvim-treesitter#foldexpr()"
	end,
}
