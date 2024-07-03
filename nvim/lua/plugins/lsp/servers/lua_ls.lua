local M = {}

M.setup = function(capabilities)
    return function()
        require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = "Lua 5.1" },
                    completion = {
                        callSnippet = 'Replace'
                    },
                    diagnostics = {
                        globals = { "vim" }
                    }
                },
            },
        })
    end
end

return M
