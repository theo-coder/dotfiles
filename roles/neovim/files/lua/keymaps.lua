local opts = {
	noremap = true,
	silent = true,
}

vim.keymap.set({ "n" }, "J", "mzJ`z", opts) -- merge next line with current
vim.keymap.set({ "n" }, "<C-d>", "<C-d>zz", opts) -- center cursor line when going up
vim.keymap.set({ "n" }, "<C-u>", "<C-u>zz", opts) -- center cursor line when going down
vim.keymap.set({ "n" }, "n", "nzzzv", opts)
vim.keymap.set({ "n" }, "N", "Nzzzv", opts)
vim.keymap.set({ "n" }, "*", "~h", opts) -- capitalize
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts) -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], opts)
vim.keymap.set({ "n" }, "Q", "", opts) -- unmap key
vim.keymap.set({ "n" }, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts) -- change every occurence of the underlined word
vim.keymap.set({ "n" }, "<leader>x", ":!chmod +x %<cr>", opts) -- set current buffer to executable
-- FIXME: bug with marks
vim.keymap.set({ "v" }, "J", ":m '>+1<CR>gv=gv'", opts) -- intervert lines
vim.keymap.set({ "v" }, "K", ":m '<-2<CR>gv=gv'", opts)
--
vim.keymap.set({ "n" }, "$", "<C-a>", opts) -- increment number
vim.keymap.set({ "n" }, "£", "<C-x>", opts) -- decrement number
vim.keymap.set(
	{ "n" },
	"<Esc>",
	"<cmd>nohlsearch<cr><cmd>lua pcall(function() require('notify').dismiss() end)<cr>",
	opts
) -- clear highlights and notifications
