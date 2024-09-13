local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	require("plugins.colorscheme"),
	require("plugins.treesitter"),
	require("plugins.harpoon"),
	require("plugins.lsp"),
	require("plugins.cmp"),
	require("plugins.win_bar"),
	require("plugins.status_line"),
	require("plugins.autopairs"),
	require("plugins.colorizer"),
	require("plugins.comment"),
	require("plugins.telescope"),
	require("plugins.git"),
	require("plugins.format"),
	require("plugins.test"),
	require("plugins.trouble"),
	require("plugins.lint"),
	require("plugins.oil"),
	require("plugins.lazydev"),
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			vim.notify = require("notify")
		end,
	},
	{
		"andymass/vim-matchup",
		event = "BufReadPost",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "BufReadPre",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
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

			todo_comments.setup({})
		end,
	},
	{
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			ft = { "markdown" },
			build = function(plugin)
				if vim.fn.executable("npx") then
					vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
				else
					vim.cmd([[Lazy load markdown-preview.nvim]])
					vim.fn["mkdp#util#install"]()
				end
			end,
			init = function()
				if vim.fn.executable("npx") then
					vim.g.mkdp_filetypes = { "markdown" }
				end
			end,
		},
	},
	{
		"lervag/vimtex",
		lazy = false,
		config = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_latexmk = {
				out_dir = "dist",
			}
		end,
	},
}

require("lazy").setup(plugins)
