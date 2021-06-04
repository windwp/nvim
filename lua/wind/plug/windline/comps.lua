local helper = require('windline.helpers')
local api = vim.api
local sep = helper.separators

local is_lsp = function ()
    if vim.b.wind_lsp_server_name ~= nil
        and #vim.b.wind_lsp_server_name > 1 then
        return true
    end
    return false
end

local state = _G.WindLine.state

local get_git_dir = function ()
    if(vim.g.wind_use_plugin == 1) then
        return vim.call('fugitive#head')
    end
    return ''
end

local check_lsp_status = function()
    if state.comp.lsp == nil and is_lsp() then
        local error, warning  = helper.get_diagnostics_count(0)
        state.comp.error = error
        state.comp.warning = warning
        if error > 0 or warning > 0  then
            state.comp.lsp = 1
        else
            state.comp.lsp = 2
        end
    else
        state.comp.error = 0
        state.comp.warning=0
    end
    return state.comp.lsp ~= nil
end

local hl_list = {
    Black    = {'white'      , 'black'      } ,
    Inactive = {'InactiveFg' , 'InactiveBg' } ,
    Left     = {'LeftFg'     , 'LeftBg'     } ,
    Right    = {'RightFg'    , 'RightBg'    } ,
}

local comps = {}

comps.vim_equal             = {"%=", ''}
comps.space                 = {' ', ''}
comps.line_col              = {[[ %3l:%-2c ]],hl_list.Black }
comps.progress              = {[[%3p%% ]], hl_list.Black}
comps.bg                    = {" ", 'StatusLine'}
comps.file_name_inactive    = {"%f", hl_list.Inactive}
comps.line_col_inactive     = {[[ %3l:%-2c ]], hl_list.Inactive}
comps.progress_inactive     = {[[%3p%% ]], hl_list.Inactive}

comps.sep_second_left       = {sep.slant_right_thin, ''}
comps.sep_second_left_black = {sep.slant_right_thin, hl_list.Black}

comps.file_modified_inactive = {"%m", hl_list.Black}

comps.vi_mode= {
    name='vi_mode',
    hl_colors = {
            Normal   = {'NormalFg', 'NormalBg'   } ,
            Insert   = {'InsertFg', 'InsertBg'   } ,
            Visual   = {'VisualFg', 'VisualBg'   } ,
            Replace  = {'ReplaceFg', 'ReplaceBg' } ,
            Command  = {'CommandFg', 'CommandBg' } ,
        } ,
    text = function() return ' ' .. state.mode[1] .. ' ' end,
    hl = function (hl_data) return hl_data[state.mode[2]]
    end,
}

comps.vi_mode_sep =  {
    name='vi_mode_sep',
    hl_colors = {
            Normal  = {'NormalBg', 'LeftBg'},
            Insert  = {'InsertBg', 'LeftBg'},
            Visual  = {'VisualBg', 'LeftBg'},
            Replace = {'ReplaceBg', 'LeftBg'},
            Command = {'CommandBg', 'LeftBg'},
        }
    ,
    text = function() return sep.slant_right end,
    hl = function (data) return data[state.mode[2]] end,
}

comps.alert_mode = {
    name = 'alert_mode',
    hl_colors = {
            default     = {'white'    , 'red'     } ,
            beforeEmpty = {'MiddleBg' , 'black'   } ,
            afterEmpty  = {'black'    , 'RightBg' } ,
            after       = {'red'      , 'RightBg' } ,
            before      = {'MiddleBg' , 'red'     } ,
            bg          = {'black'    , 'green'   } ,
            red         = {'red'      , 'black'   } ,
            green       = {'green'    , 'black'   }
        },
    text = function ()
        local text = ''
        if(vim.g.resize_active == 1) then text = ' Resize Mode ' end
        if(vim.g.ibus_engine_enable ==1  or vim.g.keymap_engine_enable == 1) then
            if state.mode[1] == 'INSERT'  then
                text= ' [VN] '
            else
                text = ' [EN] '
            end
        end
        if text == '' then
            return {
                -- {sep.slant_right, 'beforeEmpty'},
                {function()
                    if vim.bo.modified or vim.bo.modifiable == false then
                        return ' ⬤ '
                    end
                    return''
                end,
                function (hl_data)
                        if not hl_data then return ' ' end
                        if vim.bo.modified then
                            return hl_data.green
                        elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                            return hl_data.red
                        end
                        return hl_data.bg
                end},
                {sep.slant_right, 'afterEmpty'},
            }
        end
        return {
            {sep.slant_right, 'before'},
            {text, 'default'},
            {sep.slant_right, 'after'},
        }
    end
}

comps.git_status = {
    text = function ()
        local txt =  get_git_dir()
        if #txt > 1 then
            return '  ' .. txt .. ' '
        end
        return ''
    end,
    hl_colors = hl_list.Left
}

comps.file_name = {
    text = function ()
        local fullpath = vim.fn.expand('%:p')
        local name     = vim.fn.expand('%:p:t')

        if string.match(fullpath, "^fugitive") ~= nil then
            name = name .. "[git]"
        end
        if name == '' then
            name = '[No Name]'
        end
        return name..  ' '
    end,
    hl_colors = hl_list.Left
}

comps.file_type = {
    text = function()
        local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
        local icon = helper.get_icon(file_name, file_ext)
        local filetype = vim.bo.filetype
        if filetype == "" then
            return "  "
        end
        return string.format(" %s %s ", icon, filetype):lower()
    end,
    hl_colors = {
        dev = {'red', 'RightBg'},
        default = {'RightFg', 'RightBg'}
    },
    hl = function(hl_data)
        if Wind.is_dev then return hl_data.dev end
        return hl_data.default
    end
}

comps.lsp_status = {
    name = "lsp_status",
    hl_colors = {
        default = {'RightFg', 'RightBg'},
        red     = {'red', 'RightBg'},
        sep     = {'RightBg', 'black'}
    } ,
    text = function()
        return {
            {
                function ()
                    local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
                    local icon = helper.get_icon(file_name, file_ext)
                    if is_lsp() then
                        return icon .. ' ' .. vim.b.wind_lsp_server_name
                    end
                    local filetype = vim.bo.filetype
                    if filetype == "" then return "  " end
                    return string.format(" %s %s ", icon, filetype):lower()
                end,
                function(hl_data)
                    if Wind.is_dev then  return hl_data.red end
                    return hl_data.default
                end
            },
            {sep.slant_right, 'sep'}
        }
    end,
}

comps.lsp_diagnos = {
    name = 'diagnostic',
    hl_colors = {
        default    = {'black'  , 'LeftBg' } ,
        red        = {'red'    , 'black'  } ,
        yellow     = {'yellow' , 'black'  } ,
        sep_after  = {'black'  , 'LeftBg' } ,
        sep_before = {'black'  , 'LeftBg' }
    },
    text = function ()
        if check_lsp_status() then
            return{
                {sep.slant_left, 'sep_before'} ,
                {string.format("  %s", state.comp.error or 0),'red'},
                {string.format("  %s ", state.comp.warning or 0),'yellow'},
                {sep.slant_right,'sep_after' },
            }
        end
        return {
            {
                function ()
                    local txt = get_git_dir()
                    if #txt > 1 then
                        if check_lsp_status() then
                            return sep.slant_left
                        else
                            return sep.slant_right_thin
                        end
                    end
                    if check_lsp_status() then
                        return 'ツ' .. sep.slant_left
                    end
                    return ''
                end,
                function(hl_data)
                    if check_lsp_status() then return hl_data.lsp end
                    return hl_data.default
                end
            }
        }
    end,
}

comps.explorer_name = {
    name = 'explorer_name',
    text = function(bufnr)
        if bufnr == nil then return '' end
        local bufname = vim.fn.expand(vim.fn.bufname(bufnr))
        local _,_, bufnamemin = string.find(bufname,[[%/([^%/]*%/[^%/]*);%$$]])
        if bufnamemin ~= nil and #bufnamemin > 1 then return bufnamemin end
        return bufname
    end,
    hl_colors = {'MiddleFg', 'MiddleBg'}
}

comps.terminal_name = {
    text = function(bufnr)
        if bufnr == nil then return '' end
        bufnr = tonumber(bufnr)
        local bufname = vim.fn.expand(vim.fn.bufname(bufnr))
        return bufname:sub(#bufname -11,#bufname)
    end,
    hl_colors = hl_list.Inactive
}

comps.terminal_mode =  {
    name='terminal',
    text = function ()
        if
            vim.g.statusline_winid == api.nvim_get_current_win()
            and state.mode[1] == 'TERMINAL'
        then
            return {
                {' ⚡ ', function(hl_data) return hl_data[state.mode[2]] end},
                {sep.slant_right, 'sep'}
            }
        end
        return {
            {' ⚡ ','empty'}
        }
    end,
    hl_colors = {
        sep     = {'CommandBg', 'InactiveBg'},
        Normal  = {'MiddleFg', 'MiddleBg'   } ,
        Command = {'CommandFg', 'CommandBg' } ,
        empty   = {'white', 'black'},
    },
}

-- comps.middle_comp = {
--     hl_colors = {
--             default = {'MiddleFg', 'MiddleBg'},
--             before = {'LeftBg', 'MiddleBg'}
--         } ,
--     text = function ()
--         return {
--             {sep.slant_right, 'before'},
--             {state.animation_text or ' '}
--         }
--     end,
-- }



comps.wave_left={
    hl_colors = {
        wave_blue1 = {'LeftBg', 'waveleft1'},
        wave_blue2 = {'waveleft1', 'waveleft2'},
        wave_blue3 = {'waveleft2', 'waveleft3'},
        wave_blue4 = {'waveleft3', 'waveleft4'},
        wave_blue5 = {'waveleft4', 'waveleft5'},
        wave_blue6 = {'waveleft5', 'MiddleBg'},
    },
    text = function()
        return {
            {sep.slant_right .. ' ', 'wave_blue1'},
            {sep.slant_right .. ' ', 'wave_blue2'},
            {sep.slant_right .. ' ', 'wave_blue3'},
            {sep.slant_right .. ' ', 'wave_blue4'},
            {sep.slant_right .. ' ', 'wave_blue5'},
            {sep.slant_right .. ' ', 'wave_blue6'},
        }
    end
}

comps.wave_right={
    hl_colors = {
        wave_blue1 = { 'MiddleBg'  ,'waveright1',} ,
        wave_blue2 = { 'waveright1','waveright2',} ,
        wave_blue3 = { 'waveright2','waveright3',} ,
        wave_blue4 = { 'waveright3','waveright4',} ,
        wave_blue5 = { 'waveright4','waveright5',} ,
        wave_blue6 = { 'waveright5','black'  ,} ,
    },
    text = function()
        return {
            {sep.slant_right.. ' ' , 'wave_blue1'},
            {sep.slant_right.. ' ' , 'wave_blue2'},
            {sep.slant_right.. ' ' , 'wave_blue3'},
            {sep.slant_right.. ' ' , 'wave_blue4'},
            {sep.slant_right.. ' ' , 'wave_blue5'},
            {sep.slant_right.. ' ' , 'wave_blue6'},
        }
    end
}
return comps
