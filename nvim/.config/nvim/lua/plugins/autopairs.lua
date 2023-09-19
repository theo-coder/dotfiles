return {
	"windwp/nvim-autopairs",
	dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
	event = "InsertEnter",
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true,
			enable_check_bracket_line = false,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			disable_in_macro = false,
			ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
			enable_moveright = true,
			enable_afterquote = true,
			map_c_w = false,
			map_bs = true,
			disable_in_visualblock = false,
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0,
				end_keys = "$",
				keys = "azertyuiopqsdfghjklmwxcvbn",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})
	end,
}
