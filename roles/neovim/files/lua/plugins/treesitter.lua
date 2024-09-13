return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

			autotag = {
				enable = true,
			},

			auto_install = true,
			sync_install = false,
			ignore_install = { "latex" },
			modules = {},

			highlight = {
				enable = true,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>ss",
					node_incremental = "<leader>si",
					scope_incremental = "<leader>sc",
					node_decremental = "<leader>sd",
				},
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["as"] = { query = "@scope", query_group = "locals", desc = "select language scope" },
					},
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "v",
						["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = true,
				},
			},

			context_commentstring = {
				config = {
					javascript = {
						__default = "// %s",
						jsx_element = "{/* %s */}",
						jsx_fragment = "{/* %s */}",
						jsx_attribute = "// %s",
						comment = "// %s",
					},
					typescript = { __default = "// %s", __multiline = "/* %s */" },
				},
			},
		})
	end,
}
