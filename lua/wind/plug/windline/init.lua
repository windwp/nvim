local windline = require('windline')
local comps = import('plug.windline.comps')
local helper = require('windline.helpers')

local default = {
    filetypes = { 'default' },
    active = {
        comps.vi_mode,
        comps.vi_mode_sep,
        comps.git_status,
        comps.lsp_diagnos,
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
    filetypes = { 'fern', 'NvimTree' },
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
        { ' Total : %L ', { 'cyan', 'black_light' } },
        { helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
        { ' ', { 'InactiveFg', 'InactiveBg' } },
        comps.divider,
        { helper.separators.slant_right, { 'InactiveBg', 'black' } },
        {'🧛 ',{'white', 'black'}}
    },
    show_in_active = true,
}
-- local trouble = {
--     filetypes = { 'Trouble' },
--     active = {
--         { '🚦 Trouble ', { 'white', 'black' } },
--         { helper.separators.slant_right, { 'black', 'black_light' } },
--         { '  10 ', { 'cyan', 'black_light' } },
--         { ' 0 ', { 'red', 'black_light' } },
--         { ' 0 ', { 'yellow', 'black_light' } },
--         { helper.separators.slant_right, { 'black_light', 'InactiveBg' } },
--         { ' ', { 'InactiveFg', 'InactiveBg' } },
--         comps.divider,
--         { helper.separators.slant_right, { 'InactiveBg', 'black' } },
--         {' 🚦 ',{'white', 'black'}}
--     },
--     show_in_active = true,
-- }

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
    themes = require('windline.themes.wind'),
    colors_name = function(colors)
        colors.NormalFg = colors.white
        colors.NormalBg = colors.black

        colors.InsertFg = colors.white
        colors.InsertBg = colors.blue_light

        colors.VisualFg = colors.white
        colors.VisualBg = colors.blue

        colors.ReplaceFg = colors.black
        colors.ReplaceBg = colors.green

        colors.CommandFg = colors.white
        colors.CommandBg = colors.red

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
