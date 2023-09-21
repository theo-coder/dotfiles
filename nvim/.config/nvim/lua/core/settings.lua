local M = {}

function M:load()
	local undodir = string.format("%s/.config/nvim/.undodir", vim.env.HOME)

	local options = {
		backup = false, -- creates a backup file
		writebackup = false, -- creates a backup file while it's being written
		swapfile = false, -- creates a swap file
		undofile = true, -- enable persistent undo
		undodir = undodir, -- set an undo directory
		number = true, -- set numbered lines
		relativenumber = true, -- set number relative to the cursor line
		clipboard = "unnamedplus", -- allows neovim to access system clipboard
		encoding = "UTF-8", -- file encoding
		tabstop = 4, -- insert 4 spaces for a tab
		softtabstop = 4, -- insert 4 spaces for a tab
		shiftwidth = 4, -- the number of spaces inserted for each indentation
		expandtab = true, -- convert tabs to spaces
		hlsearch = true, -- highlight all matches on previous search pattern
		incsearch = true, -- for incremental searching
		ignorecase = true, -- ignore case when searching
		pumheight = 10, -- height of popups
		conceallevel = 0, -- so that `` is visible in markdown
		cmdheight = 2, -- more space in the neovim command for displaying messages
		splitright = true, -- where extra lines appears when closing a window
		splitbelow = true, -- where extra lines appears when closing a window
		smartindent = true, -- indent behavior
		termguicolors = true, -- for terminal colors
		background = "dark", -- for background colors
		shell = "/bin/bash", -- shell to use for ! commands
		wrap = false, -- display lines as one long line
		cursorline = true, -- display a line under cursor
		timeoutlen = 300, -- time for WK to appears
	}

	for k, v in pairs(options) do
		vim.opt[k] = v
	end

	-- NETRW settings
	vim.g.netrw_browse_split = 0
	vim.g.netrw_banner = 0
	vim.g.netrw_winsize = 25

	-- FZF
	vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden --follow --no-ignore-vcs --fixed-strings"
	vim.env.FZF_DEFAULT_OPTS =
		[[--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --bind ctrl-j:down,ctrl-k:up,ctrl-h:preview-down,ctrl-l:preview-up]]
end

return M
