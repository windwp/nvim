local npairs = require('nvim-autopairs')
-- local Cond= require('nvim-autopairs.conds')
-- local ts_conds = require('nvim-autopairs.ts-conds')

-- local endwise = require('nvim-autopairs.ts-rule').endwise
npairs.setup({
    fast_wrap = {
        end_key = 'L',
        highlight = 'HopNextKey',
    },
    -- check_ts = true
    -- ignored_next_char = false
    -- enable_check_bracket_line = false
})



vim.keymap.imap({
    '<cr>',
    function()
        if vim.fn.pumvisible() ~= 0 then
            if vim.fn.complete_info()['selected'] ~= -1 then
                return vim.fn['compe#confirm'](vim.keymap.t('<cr>'))
            else
                vim.defer_fn(function()
                    vim.fn['compe#confirm']('<cr>')
                end, 20)
                return vim.keymap.t('<c-n>')
            end
        else
            return npairs.autopairs_cr()
        end
    end,
    expr = true,
    noremap = true,
})

require("nvim-autopairs.completion.compe").setup({map_cr = false, map_complete = true})
