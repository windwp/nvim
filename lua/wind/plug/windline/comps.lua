local helper = require('windline.helpers')
local git_comps = require('windline.components.git')
local basic_comps = require('windline.components.basic')
local vim_comps = require('windline.components.vim')
local lsp_comps = require('windline.components.lsp')
local cache_utils = require('windline.cache_utils')
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

local check_lsp_status = lsp_comps.check_custom_lsp({func_check = is_lsp})

local hl_list = {
    Black    = {'white'      , 'black'      } ,
    Inactive = {'InactiveFg' , 'InactiveBg' } ,
    Left     = {'LeftFg'     , 'LeftBg'     } ,
    Right    = {'RightFg'    , 'RightBg'    } ,
}

local comps = {}

comps.divider             = {basic_comps.divider, ''}
comps.space                 = {' ', ''}
comps.line_col              = {basic_comps.line_col,hl_list.Black }
comps.progress              = {basic_comps.progress, hl_list.Black}
comps.bg                    = {" ", 'StatusLine'}
comps.file_name_inactive    = {basic_comps.full_file_name, hl_list.Inactive}
comps.line_col_inactive     = {basic_comps.line_col, hl_list.Inactive}
comps.progress_inactive     = {basic_comps.progress, hl_list.Inactive}

comps.sep_second_left       = {sep.slant_right_thin, ''}
comps.sep_second_left_black = {sep.slant_right_thin, hl_list.Black}

comps.file_modified_inactive = {basic_comps.file_modified, hl_list.Black}

comps.vi_mode= {
    name='vi_mode',
    hl_colors = {
            Normal   = {'white', 'black'   } ,
            Insert   = {'white', 'blue_light'   } ,
            Visual   = {'white', 'blue'   } ,
            Replace  = {'black', 'green' } ,
            Command  = {'white', 'red' } ,
        } ,
    text = function() return ' ' .. state.mode[1] .. ' ' end,
    hl = function (hl_data) return hl_data[state.mode[2]]
    end,
}

comps.vi_mode_sep =  {
    name='vi_mode_sep',
    hl_colors = {
            Normal  = {'black', 'LeftBg'},
            Insert  = {'blue_light', 'LeftBg'},
            Visual  = {'blue', 'LeftBg'},
            Replace = {'green', 'LeftBg'},
            Command = {'red', 'LeftBg'},
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
            local sep_ani = Wind.state.animation and '' or sep.slant_right
            return {
                {sep_ani, 'beforeEmpty'},
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
    text = git_comps.git_branch(),
    hl_colors = hl_list.Left
}


comps.file_name = {
    text = basic_comps.cache_file_name('','unique'),
    hl_colors = {'LeftFg','LeftBg' }
}


comps.lsp_status = {
    name = "lsp_status",
    hl_colors = {
        default = {'RightFg', 'RightBg'},
        red     = {'red', 'RightBg'},
        sep     = {'RightBg', 'black'}
    } ,
    text = cache_utils.cache_on_buffer('BufEnter','wl_lsp_status',function()
      local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
      local icon = helper.get_icon(file_name, file_ext)
      if is_lsp() then
        return {
          {icon .. ' ' .. vim.b.wind_lsp_server_name,'default'},
          {sep.slant_right, 'sep'}
        }
      end
      local filetype = vim.bo.filetype
      if filetype == "" then
        return {
          {"  ", 'default'},
          {sep.slant_right, 'sep'}
        }
      end
      local text = string.format(" %s %s ", icon, filetype):lower()
      local hl = Wind.is_dev and 'red' or 'default'
      return {
        { text, hl},
        {sep.slant_right, 'sep'}
      }
    end),
}

local search_count = vim_comps.search_count()
comps.search_count={
    hl_colors={
        search = {'black', 'yellow'},
        default = {'black', 'white'},
        sep_before = {'black', 'yellow'},
        sep_after = {'yellow', 'LeftBg'}
    },
    text = function()
        local count = search_count()
        if count and #count > 1 then
            if  not check_lsp_status() then
                return {
                    { count, 'default'},
                    { sep.slant_right_thin,''}
                }
            end
            return {
                {sep.slant_right, 'sep_before'},
                { count, 'search'},
                {sep.slant_right,'sep_after'}
            }
        end
        return nil
    end
}
comps.lsp_diagnos = {
    name = 'diagnostic',
    hl_colors = {
        default    = {'black'  , 'LeftBg' },
        red        = {'red'    , 'black'  },
        yellow     = {'yellow' , 'black'  },
        sep_after  = {'black'  , 'LeftBg' },
        sep_before = {'black'  , 'LeftBg' },
    },
    text = function ()
        local c_lsp_status = check_lsp_status()
        local count = search_count()
        local sep_after = sep.slant_right
        if count and #count >1 then
            sep_after = ''
        end
        if c_lsp_status then
            return{
                {sep.slant_left, 'sep_before'} ,
                {string.format("  %s", state.comp.lsp_error or 0), 'red'},
                {string.format("  %s ", state.comp.lsp_warning or 0), 'yellow'},
                {sep_after, 'sep_after' },
            }
        end
        if git_comps.is_git() then
            return {{ sep.slant_right_thin, 'default'}}
        end
        return ''
    end,
}

comps.explorer_name = {
    name = 'explorer_name',
    text = function(bufnr)
        if bufnr == nil then return '' end
        local bufname = vim.fn.expand(vim.fn.bufname(bufnr))
        local _,_, bufnamemin = string.find(bufname,[[%/([^%/]*%/[^%/]*);?%$$]])
        if bufnamemin ~= nil and #bufnamemin > 1 then return bufnamemin end
        return bufname
    end,
    hl_colors = {'black', 'MiddleBg'}
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
        sep     = {'blue_light', 'InactiveBg'},
        Normal  = {'MiddleFg', 'MiddleBg'   } ,
        Command = {'black', 'blue_light' } ,
        empty   = {'white', 'black'},
    },
}


comps.wave_left={
    hl_colors = {
        wave_blue1 = {'LeftBg', 'waveleft1'},
        wave_blue2 = {'waveleft1', 'waveleft2'},
        wave_blue3 = {'waveleft2', 'waveleft3'},
        wave_blue4 = {'waveleft3', 'waveleft4'},
        wave_blue5 = {'waveleft4', 'waveleft5'},
        wave_blue6 = {'waveleft5', 'MiddleBg'},
        default = {'LeftBg', 'MiddleBg'}
    },
    text = function()
        if Wind.state.animation == true then
            return {
                {sep.slant_right .. '   ', 'wave_blue1'},
                {sep.slant_right .. '   ', 'wave_blue2'},
                {sep.slant_right .. '   ', 'wave_blue3'},
                {sep.slant_right .. '   ', 'wave_blue4'},
                {sep.slant_right .. '   ', 'wave_blue5'},
                {sep.slant_right .. '   ', 'wave_blue6'},
            }
        end
        return {
            {sep.slant_right , 'default'},
        }
    end,
}

comps.wave_right={
    hl_colors = {
        wave_blue1 = { 'MiddleBg'  ,'waveright1',} ,
        wave_blue2 = { 'waveright1','waveright2',} ,
        wave_blue3 = { 'waveright2','waveright3',} ,
        wave_blue4 = { 'waveright3','waveright4',} ,
        wave_blue5 = { 'waveright4','waveright5',} ,
        wave_blue6 = { 'waveright5','black'  ,} ,
        default = {'MiddleBg' , 'MiddleBg'   } ,
    },
    text = function()
        if Wind.state.animation == true then
            return {
                {sep.slant_right.. '   ' , 'wave_blue1'},
                {sep.slant_right.. '   ' , 'wave_blue2'},
                {sep.slant_right.. '   ' , 'wave_blue3'},
                {sep.slant_right.. '   ' , 'wave_blue4'},
                {sep.slant_right.. '   ' , 'wave_blue5'},
                {sep.slant_right.. '' , 'wave_blue6'},
            }
        end
        return ''
    end
}
return comps

