local M = {}

function M:load()
	local opts = {
		noremap = true,
		silent = true,
	}

	local keymap = vim.api.nvim_set_keymap

	keymap("n", "<leader>pv", ":Ex<cr>", opts) -- NETRW
	keymap("n", "J", "mzJ`z", opts) -- merge next line with current
	keymap("n", "<C-d>", "<C-d>zz", opts) -- center cursor line when going up
	keymap("n", "<C-u>", "<C-u>zz", opts) -- center cursor line when going down
	keymap("n", "n", "nzzzv", opts)
	keymap("n", "N", "Nzzzv", opts)
	keymap("n", "<leader>y", [["+y]], opts) -- copy to system clipboard
	keymap("n", "<leader>Y", [["+Y]], opts)
	keymap("n", "Q", "nop", opts) -- unmap key
	keymap("n", "f", ":Format<cr>", opts) -- format current buffer
	keymap("n", "<C-k>", ":cnext<cr>zz", opts) -- next error
	keymap("n", "<C-j>", ":cprev<cr>zz", opts) -- previous error
	keymap("n", "<leader>k", ":lnext<cr>zz", opts)
	keymap("n", "<leader>j", ":lprev<cr>zz", opts)
	keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts) -- change every occurence of the underline word
	keymap("n", "<leader>x", ":!chmod +x %<cr>", opts) -- set buffer to executable

	keymap("v", "J", ":m '>+1<CR>gv=gv'", opts)
	keymap("v", "K", ":m '<-2<CR>gv=gv'", opts)
	keymap("v", "<leader>y", [["+y]], opts) -- copy to system clipboard
	keymap("v", "<leader>d", [["_d]], opts)

	keymap("x", "<leader>p", [["_dP]], opts)

	keymap("t", "<esc>", "<c-\\><c-n>:q!<esc>", opts) -- escape terminal with escape
end

return M
