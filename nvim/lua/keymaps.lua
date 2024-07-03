local opts = {
	noremap = true,
	silent = true,
}

-- vim.api.nvim_set_keymap("n", "<leader>pv", ":Ex<cr>", opts) -- NETRW
vim.api.nvim_set_keymap("n", "J", "mzJ`z", opts) -- merge next line with current
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", opts) -- center cursor line when going up
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", opts) -- center cursor line when going down
vim.api.nvim_set_keymap("n", "n", "nzzzv", opts)
vim.api.nvim_set_keymap("n", "N", "Nzzzv", opts)
vim.api.nvim_set_keymap("n", "*", "~h", opts) -- capitalize
vim.api.nvim_set_keymap("n", "<leader>y", [["+y]], opts) -- copy to system clipboard
vim.api.nvim_set_keymap("n", "<leader>Y", [["+Y]], opts)
vim.api.nvim_set_keymap("n", "Q", "", opts) -- unmap key
vim.api.nvim_set_keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts) -- change every occurence of the underlined word
vim.api.nvim_set_keymap("n", "<leader>x", ":!chmod +x %<cr>", opts) -- set current buffer to executable
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv'", opts) -- intervert lines
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv'", opts)
vim.api.nvim_set_keymap("n", "$", "<C-a>", opts) -- increment number
vim.api.nvim_set_keymap("n", "£", "<C-x>", opts) -- decrement number
vim.api.nvim_set_keymap("n", "<Esc>", ":nohlsearch<cr>", opts) -- clear highlights
