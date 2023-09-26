local M = {}

function M:load()
	local autocmds = {
		{
			"TextYankPost",
			{
				group = "HighlightYank",
				pattern = "*",
				desc = "Highlight text on yank",
				callback = function()
					vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
				end,
			},
		},
		{
			"BufWritePre",
			{
				group = "TheoGroup",
				pattern = "*",
				desc = "Remove trailing whitespace on save",
				command = [[%s/\s\+$//e]],
			},
		},
		{
			"BufReadPost",
			{
				group = "BufCheck",
				pattern = "*",
				callback = function()
					if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
						vim.fn.setpos(".", vim.fn.getpos("'\""))
						vim.api.nvim_feedkeys("zz", "n", true)
					end
				end,
			},
		},
		{
			"CursorHold",
			{
				callback = function()
					vim.schedule(vim.diagnostic.open_float)
				end,
			},
		},
	}

	for _, entry in ipairs(autocmds) do
		local event = entry[1]
		local opts = entry[2]

		if type(opts.group) == "string" and opts.group ~= "" then
			local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
			if not exists then
				vim.api.nvim_create_augroup(opts.group, {})
			end
		end
		vim.api.nvim_create_autocmd(event, opts)
	end
end

return M
