local windline = require('windline')
local helper = require('windline.helpers')
local comps = import('plug.windline.comps')

local default = {
    filetypes = { 'default' },
    active = {
        comps.vi_mode,
        comps.vi_mode_sep,
        comps.git_status,
        comps.lsp_diagnos,
        comps.search_count,
        comps.space,
        comps.file_name,
        comps.wave_left,
        comps.divider,
        comps.divider,
        comps.wave_right,
        comps.alert_mode,
        comps.lsp_status,
        comps.line_col,
        comps.sep_second_left_black,
        comps.progress,
    },
    in_active = {
        comps.file_name_inactive,
        comps.divider,
        comps.divider,
        comps.line_col_inactive,
        comps.sep_second_left,
        comps.progress_inactive,
    },
}

local explorer = {
    filetypes = { 'fern', 'NvimTree' , 'lir'},
    active = {
        { '  ', { 'white', 'black' } },
        { helper.separators.slant_right, { 'black', 'MiddleBg' } },
        comps.divider,
        comps.explorer_name,
        comps.space,
    },
    show_in_active = true,
}

local quickfix = {
    filetypes = { 'qf', 'Trouble' },
    active = {
        { '🚦 Quickfix ', { 'white', 'black' } },
        { helper.separators.slant_right, { 'black', 'black_light' } },
        {
            function() return vim.fn.getqflist({title = 0}).title end,
            {'cyan', 'black_light'}
        },
        { ' Total : %L ', { 'cyan', 'black_light' } },
        { helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
        { ' ', { 'InactiveFg', 'InactiveBg' } },
        comps.divider,
        { helper.separators.slant_right, { 'InactiveBg', 'black' } },
        {'🧛 ',{'white', 'black'}}
    },
    show_in_active = true,
}

local terminal = {
    filetypes = { 'toggleterm' },
    active = {
        comps.terminal_mode,
        comps.terminal_name,
        comps.divider,
        comps.divider,
        comps.line_col_inactive,
        comps.sep_second_left,
        comps.progress_inactive,
    },
    show_in_active = true,
}

windline.setup({
    theme = require('windline.themes.wind'),
    colors_name = function(colors)

        colors.LeftFg = colors.black
        colors.LeftBg = colors.white

        colors.MiddleFg = colors.black
        colors.MiddleBg = colors.white_light

        colors.RightFg = colors.black
        colors.RightBg = colors.white

        colors.wavewhite = colors.white

        colors.waveleft1 = colors.MiddleBg
        colors.waveleft2 = colors.MiddleBg
        colors.waveleft3 = colors.MiddleBg
        colors.waveleft4 = colors.MiddleBg
        colors.waveleft5 = colors.MiddleBg

        colors.waveright1 = colors.MiddleBg
        colors.waveright2 = colors.MiddleBg
        colors.waveright3 = colors.MiddleBg
        colors.waveright4 = colors.MiddleBg
        colors.waveright5 = colors.MiddleBg
        return colors
    end,

    statuslines = {
        default,
        explorer,
        quickfix,
        terminal
    },
})
