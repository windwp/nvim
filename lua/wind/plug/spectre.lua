require('spectre').setup({
    line_sep_start = '┌--------------------------------------------------------',
    line_sep       = '└--------------------------------------------------------',
})

if vim.g.wind_use_statusline == 1 then
    require('windline').add_status(
        require('spectre.state_utils').status_line()
    )
end
