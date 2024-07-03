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

autocmd("CursorHold", {
    group = "theo",
    pattern = "*",
    callback = function()
        vim.schedule(vim.diagnostic.open_float)
    end,
})
