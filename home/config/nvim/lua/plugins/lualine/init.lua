local components = require("plugins.lualine.components")

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"SmiteshP/nvim-navic",
	},
	event = "VeryLazy",
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = {},
			section_separators = {},
			disabled_filetypes = {
				statusline = { "lazy" },
				winbar = {
					"help",
					"lazy",
				},
			},
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { components.git_repo, "branch" },
			lualine_c = { components.diff, components.diagnostics, components.separator, components.lsp_client },
			lualine_x = { "filename", components.spaces, "encoding", "fileformat", "filetype", "progress" },
			lualine_y = {},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		-- TODO:
		-- winbar = {
		--     lualine_b = {
		--         { 'filetype', icon_only = true },
		--         { 'filename', path = 0, symbols = components.file_status_symbol },
		--     },
		--     lualine_c = { components.winbar_symbol },
		--     lualine_x = {
		--         function()
		--             return ' '
		--         end,
		--         { 'diagnostics', sources = { 'nvim_diagnostic' } },
		--         'diff',
		--     },
		-- },
		-- inactive_winbar = {
		--     lualine_a = {
		--         { 'filetype', icon_only = true },
		--         { 'filename', path = 0, symbols = components.file_status_symbol },
		--     },
		--     lualine_x = {
		--         { 'diagnostics', sources = { 'nvim_diagnostic' } },
		--         'diff',
		--     },
		-- },
		extensions = { "nvim-tree", "toggleterm", "quickfix" },
	},
}
