return {
    "shortcuts/no-neck-pain.nvim",
    opts = {
        mappings = {
            enabled = true,
            toggle = false,
            toggleLeftSide = false,
            toggleRightSide = false,
            widthUp = false,
            widthDown = false,
            scratchPad = false,
        }
    },
    config = function()
        vim.keymap.set('', '<leader>t', function()
            vim.cmd([[
                :NoNeckPain
                :set formatoptions-=tc linebreak tw=0 cc=0 wrap wm=20 noautoindent nocindent nosmartindent indentkeys=
            ]])
            -- make 0, ^ and $ behave better in wrapped text
            vim.keymap.set('n', '0', 'g0')
            vim.keymap.set('n', '$', 'g$')
            vim.keymap.set('n', '^', 'g^')
        end)
    end
}
