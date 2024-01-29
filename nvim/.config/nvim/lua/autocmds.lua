local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("theo", {})

autocmd("TextYankPost", {
	group = "theo",
	pattern = "*",
	desc = "Highlight text on yank",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
	end,
})

autocmd("BufWritePre", {
	group = "theo",
	pattern = "*",
	desc = "Remove trailing whitespace on save",
	command = [[%s/\s\+$//e]],
})

-- autocmd("BufReadPost", {
-- 	group = "theo",
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
-- 			vim.fn.setpos(".", vim.fn.getpos("'\""))
-- 			vim.api.nvim_feed_keys("zz", "n", true)
-- 		end
-- 	end,
-- })

autocmd("CursorHold", {
	group = "theo",
	pattern = "*",
	callback = function()
		vim.schedule(vim.diagnostic.open_float)
	end,
})
