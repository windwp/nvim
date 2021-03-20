--[[
  Wind
  URL: https://github.com/windwp/nvim
  Author: wind
  License: MIT

  https://github.com/RRethy/nvim-base16
  https://github.com/Rigellute/rigel
--]]
local wind = {
  bg2         = "#001a25",
  fg          = "#e6e6dc",
  fg_light    = "#b8b8b4",
  bg          = "#002635",
  bg_dark     = "#040a31",
  bg_light    = "#194b5e",
  term_bg     = "#002635",
  term_fg     = "#e6e6dc",
  black       = '#00384d',
  black_bold  = "#073d52",
  black_light = "#77929e",
  black_gruv  = "#282828",
  blue        = "#1c8db2",
  blue_dark   = "#7eb2dd",
  blue_gruv   = "#8ec07c",
  blue_light  = "#b3e5fc",
  cyan        = "#00cccc",
  cyan_light  = "#00ffff",
  green       = '#7fc06e',
  green_gruv  = "#b8bb26",
  green_light = "#7eca9c",
  grey        = "#517f8d",
  grey_light  = "#b7cff9",
  orange      = '#f08e48',
  pink        = "#c694ff",
  pink_light  = "#fb94ff",
  red         = "#ff5a67",
  red_gruv    = "#fb4934",
  red_light   = '#c43060',
  yellow      = "#ffcc1b",
  yellow_gruv = "#fabd2f",
}


vim.g.terminal_color_foreground = wind.term_fg
vim.g.terminal_color_background = wind.term_bg
vim.g.terminal_color_0  = wind.black
vim.g.terminal_color_1  = wind.red
vim.g.terminal_color_2  = wind.green
vim.g.terminal_color_3  = wind.orange
vim.g.terminal_color_4  = wind.blue
vim.g.terminal_color_5  = wind.pink
vim.g.terminal_color_6  = wind.cyan
vim.g.terminal_color_7  = wind.black_light
vim.g.terminal_color_8  = wind.grey
vim.g.terminal_color_9  = wind.red_light
vim.g.terminal_color_10 = wind.green_light
vim.g.terminal_color_11 = wind.yellow
vim.g.terminal_color_12 = wind.blue_light

vim.g.terminal_color_13 = wind.pink_light
vim.g.terminal_color_14 = wind.cyan_light
vim.g.terminal_color_15 = wind.grey_light

local NONE      = 'NONE'
local REVERSE   = 'reverse'
local ITALIC    = 'italic'
local BOLD      = 'bold'
local UNDERLINE = 'underline'
local STRIKE    = 'strikethrough'


local function highlight(group, color)
    local gui = color.gui and 'gui=' .. color.gui or 'gui=NONE'
    local fg = color.guifg and 'guifg=' .. color.guifg or 'guifg=NONE'
    local bg = color.guibg and 'guibg=' .. color.guibg or 'guibg=NONE'
    local sp = color.guisp and 'guisp=' .. color.guisp or ''
    vim.api.nvim_command('highlight ' .. group .. ' ' .. gui .. ' ' .. fg ..
                             ' ' .. bg..' '..sp)
end

local function theme(colors)
    local hi = {}
    hi.Bold         = { guifg = nil                , guibg = nil                , gui = BOLD , guisp = nil }
    hi.ColorColumn  = { guifg = nil                , guibg = colors.bg2         , gui = NONE , guisp = nil }
    hi.Conceal      = { guifg = colors.pink_light  , guibg = colors.bg2         , gui = nil  , guisp = nil }
    hi.Cursor       = { guifg = NONE               , guibg = colors.orange      , gui = nil  , guisp = nil }
    hi.CursorColumn = { guifg = nil                , guibg = colors.bg2         , gui = NONE , guisp = nil }
    hi.CursorLine   = { guifg = nil                , guibg = colors.bg2         , gui = NONE , guisp = nil }
    hi.CursorLineNr = { guifg = colors.yellow      , guibg = colors.bg          , gui = nil  , guisp = nil }
    hi.Debug        = { guifg = colors.pink_light  , guibg = nil                , gui = nil  , guisp = nil }
    hi.Directory    = { guifg = colors.cyan        , guibg = nil                , gui = nil  , guisp = nil }
    hi.Error        = { guifg = colors.red         , guibg = NONE               , gui = nil  , guisp = nil }
    hi.ErrorMsg     = { guifg = colors.red_light   , guibg =NONE                , gui = nil  , guisp = nil }
    hi.Exception    = { guifg = colors.red         , guibg = nil                , gui = nil  , guisp = nil }
    hi.FoldColumn   = { guifg = colors.black_light , guibg = colors.black       , gui = nil  , guisp = nil }
    hi.Folded       = { guifg = colors.black_light , guibg = colors.black       , gui = nil  , guisp = nil }
    hi.IncSearch    = { guifg = colors.bg          , guibg = colors.yellow      , gui = NONE , guisp = nil }
    hi.Italic       = { guifg = nil                , guibg = nil                , gui = NONE , guisp = nil }
    hi.LineNr       = { guifg = colors.black_light , guibg = NONE               , gui = nil  , guisp = nil }
    hi.Macro        = { guifg = colors.cyan        , guibg = nil                , gui = nil  , guisp = nil }
    hi.MatchParen   = { guifg = colors.bg          , guibg = colors.cyan_light  , gui = nil  , guisp = nil }
    hi.ModeMsg      = { guifg = colors.green       , guibg = nil                , gui = nil  , guisp = nil }
    hi.MoreMsg      = { guifg = colors.green       , guibg = nil                , gui = nil  , guisp = nil }
    hi.NonText      = { guifg = colors.grey        , guibg = nil                , gui = nil  , guisp = nil }
    hi.Normal       = { guifg = colors.fg          , guibg = colors.bg          , gui = nil  , guisp = nil }
    -- hi.NormalFloat  = { guifg = colors.fg       , guibg = colors.bg_dark         , gui = nil  , guisp = nil }
    -- hi.NormalNC     = { guifg = colors.fg       , guibg = colors.bg_dark         , gui = nil  , guisp = nil }
    hi.PMenu        = { guifg = colors.fg          , guibg = colors.black       , gui = NONE , guisp = nil }
    hi.PmenuSbar    = { guifg = colors.cyan        , guibg = colors.black_gruv  , gui = nil  , guisp = nil }
    hi.PMenuSel     = { guifg = colors.cyan        , guibg = colors.grey        , gui = nil  , guisp = nil }
    hi.PmenuThumb   = { guifg = colors.cyan        , guibg = colors.grey        , gui = nil  , guisp = nil }
    hi.Question     = { guifg = colors.green       , guibg = nil                , gui = nil  , guisp = nil }
    hi.QuickFixLine = { guifg = colors.black       , guibg = colors.yellow      , gui = NONE , guisp = nil }
    hi.Search       = { guifg = colors.bg          , guibg = colors.yellow      , gui = nil  , guisp = nil }
    hi.SignColumn   = { guifg = nil                , guibg = nil                , gui = nil  , guisp = nil }
    hi.IndentLine   = { guifg = colors.black_bold  , guibg = nil                , gui = nil  , guisp = nil }
    hi.SpecialKey   = { guifg = colors.pink        , guibg = nil                , gui = nil  , guisp = nil }
    hi.StatusLine   = { guifg = colors.fg          , guibg = colors.black       , gui = NONE , guisp = nil }
    hi.StatusLineNC = { guifg = colors.fg          , guibg = colors.grey        , gui = NONE , guisp = nil }
    hi.Substitute   = { guifg = colors.red_light   , guibg = colors.green_light , gui = NONE , guisp = nil }
    hi.TabLine      = { guifg = colors.yellow      , guibg = colors.black       , gui = NONE , guisp = nil }
    hi.TabLineFill  = { guifg = nil                , guibg = colors.black       , gui = NONE , guisp = nil }
    hi.TabLineSel   = { guifg = colors.yellow      , guibg = colors.red_light   , gui = NONE , guisp = nil }
    hi.TermCursor   = { guifg = nil                , guibg = colors.orange      , gui = NONE , guisp = nil }
    hi.TermCursorNC = { guifg = nil                , guibg = colors.orange      , gui = nil  , guisp = nil }
    hi.Title        = { guifg = colors.cyan        , guibg = nil                , gui = NONE , guisp = nil }
    hi.TooLong      = { guifg = colors.red_light   , guibg = nil                , gui = nil  , guisp = nil }
    hi.VertSplit    = { guifg = colors.grey        , guibg = colors.bg          , gui = NONE , guisp = nil }
    hi.Visual       = { guifg = nil                , guibg = colors.bg_light    , gui = nil  , guisp = nil }
    hi.VisualNOS    = { guifg = colors.red_light   , guibg = nil                , gui = nil  , guisp = nil }
    hi.WarningMsg   = { guifg = colors.red_light   , guibg = nil                , gui = nil  , guisp = nil }
    hi.WildMenu     = { guifg = colors.fg          , guibg = colors.grey        , gui = nil  , guisp = nil }

    hi.SpellBad   = { guifg = colors.black_light, guibg = nil, gui = 'undercurl', guisp = colors.grey }
    hi.SpellLocal = { guifg = colors.black_light, guibg = nil, gui = 'undercurl', guisp = colors.blue_dark }
    hi.SpellCap   = { guifg = colors.black_light, guibg = nil, gui = 'undercurl', guisp = colors.pink_light }
    hi.SpellRare  = { guifg = colors.black_light, guibg = nil, gui = 'undercurl', guisp = colors.cyan_light }

    hi.Comment        = { guifg = colors.black_light , guibg = nil , gui = 'italic'    , guisp = nil }
    hi.Constant       = { guifg = colors.orange      , guibg = nil , gui = NONE        , guisp = nil }
    hi.String         = { guifg = colors.green_light , guibg = nil , gui = NONE        , guisp = nil }
    hi.Character      = { guifg = colors.fg          , guibg = nil , gui = NONE        , guisp = nil }
    hi.Number         = { guifg = colors.red         , guibg = nil , gui = NONE        , guisp = nil }
    hi.Boolean        = { guifg = colors.red         , guibg = nil , gui = NONE        , guisp = nil }
    hi.Float          = { guifg = colors.red         , guibg = nil , gui = NONE        , guisp = nil }
    hi.Identifier     = { guifg = colors.orange      , guibg = nil , gui = NONE        , guisp = nil }
    hi.Function       = { guifg = colors.blue_dark   , guibg = nil , gui = NONE        , guisp = nil }
    hi.Statement      = { guifg = colors.blue        , guibg = nil , gui = NONE        , guisp = nil }
    hi.Conditional    = { guifg = colors.blue        , guibg = nil , gui = NONE        , guisp = nil }
    hi.Repeat         = { guifg = colors.blue        , guibg = nil , gui = NONE        , guisp = nil }
    hi.Label          = { guifg = colors.blue        , guibg = nil , gui = NONE        , guisp = nil }
    hi.Operator       = { guifg = colors.orange      , guibg = nil , gui = NONE        , guisp = nil }
    hi.Keyword        = { guifg = colors.blue        , guibg = nil , gui = NONE        , guisp = nil }
    hi.Exception      = { guifg = colors.blue        , guibg = nil , gui = NONE        , guisp = nil }
    hi.PreProc        = { guifg = colors.pink_light  , guibg = nil , gui = NONE        , guisp = nil }
    hi.Include        = { guifg = colors.cyan        , guibg = nil , gui = NONE        , guisp = nil }
    hi.Define         = { guifg = colors.cyan        , guibg = nil , gui = NONE        , guisp = nil }
    hi.Macro          = { guifg = colors.cyan        , guibg = nil , gui = NONE        , guisp = nil }
    hi.PreCondit      = { guifg = colors.pink_light  , guibg = nil , gui = NONE        , guisp = nil }
    hi.Type           = { guifg = colors.red         , guibg = nil , gui = NONE        , guisp = nil }
    hi.StorageClass   = { guifg = colors.blue_light  , guibg = nil , gui = NONE        , guisp = nil }
    hi.Structure      = { guifg = colors.blue        , guibg = nil , gui = NONE        , guisp = nil }
    hi.Typedef        = { guifg = colors.blue        , guibg = nil , gui = NONE        , guisp = nil }
    hi.Special        = { guifg = colors.cyan        , guibg = nil , gui = NONE        , guisp = nil }
    hi.SpecialChar    = { guifg = colors.cyan_light  , guibg = nil , gui = NONE        , guisp = nil }
    hi.Tag            = { guifg = colors.blue        , guibg = nil , gui = UNDERLINE , guisp = nil }
    hi.Delimiter      = { guifg = colors.blue        , guibg = nil , gui = NONE        , guisp = nil }
    hi.SpecialComment = { guifg = colors.cyan_light  , guibg = nil , gui = NONE        , guisp = nil }
    hi.Debug          = { guifg = colors.pink_light  , guibg = nil , gui = NONE        , guisp = nil }
    hi.Underlined     = { guifg = colors.grey_light  , guibg = nil , gui = UNDERLINE   , guisp = nil }
    hi.Error          = { guifg = colors.red_light   , guibg = nil , gui = NONE        , guisp = nil }
    hi.Todo           = { guifg = colors.pink_light  , guibg = nil , gui = NONE        , guisp = nil }

    hi.LspReferenceText                     = { guifg = nil           , guibg = nil , gui = UNDERLINE , guisp = colors.blue   }
    hi.LspReferenceRead                     = { guifg = nil           , guibg = nil , gui = UNDERLINE , guisp = colors.blue   }
    hi.LspReferenceWrite                    = { guifg = nil           , guibg = nil , gui = UNDERLINE , guisp = colors.blue   }
    hi.LspDiagnosticsDefaultError           = { guifg = colors.red    , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsDefaultWarning         = { guifg = colors.orange , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsDefaultInformation     = { guifg = colors.pink   , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsDefaultHint            = { guifg = colors.blue   , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsUnderlineError         = { guifg = nil           , guibg = nil , gui = UNDERLINE , guisp = colors.red    }
    hi.LspDiagnosticsUnderlineWarning       = { guifg = nil           , guibg = nil , gui = UNDERLINE , guisp = colors.orange }
    hi.LspDiagnosticsUnderlineInformation   = { guifg = nil           , guibg = nil , gui = UNDERLINE , guisp = colors.pink   }
    hi.LspDiagnosticsUnderlineHint          = { guifg = nil           , guibg = nil , gui = UNDERLINE , guisp = colors.blue   }
    hi.LspDiagnosticsSignError              = { guifg = colors.red    , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsSignWarning            = { guifg = colors.orange , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsSignInformation        = { guifg = colors.pink   , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsSignHint               = { guifg = colors.blue   , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsVirtualTextError       = { guifg = colors.red    , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsVirtualTextWarning     = { guifg = colors.orange , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsVirtualTextInformation = { guifg = colors.pink   , guibg = nil , gui = NONE      , guisp = nil           }
    hi.LspDiagnosticsVirtualTextHint        = { guifg = colors.blue   , guibg = nil , gui = NONE      , guisp = nil           }

    hi.TSAnnotation         = { guifg = colors.blue        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSAttribute          = { guifg = colors.normal      , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSBoolean            = { guifg = colors.red         , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSCharacter          = { guifg = colors.cyan        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSComment            = { guifg = colors.black_light , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSConstructor        = { guifg = colors.orange      , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSConditional        = { guifg = colors.fg_light        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSConstant           = { guifg = colors.orange      , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSConstBuiltin       = { guifg = colors.orange      , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSConstMacro         = { guifg = colors.orange      , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSError              = { guifg = colors.red         , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSException          = { guifg = colors.red_light   , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSField              = { guifg = colors.fg_light    , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSFloat              = { guifg = colors.orange      , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSFunction           = { guifg = colors.blue        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSFuncBuiltin        = { guifg = colors.blue_light  , guibg = nil , gui = ITALIC          , guisp = nil }
    hi.TSFuncMacro          = { guifg = colors.blue_light  , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSInclude            = { guifg = colors.cyan        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSKeyword            = { guifg = colors.blue        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSKeywordFunction    = { guifg = colors.blue_dark   , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSLabel              = { guifg = colors.pink        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSMethod             = { guifg = colors.pink        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSNamespace          = { guifg = colors.cyan        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSNone               = { guifg = colors.fg          , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSNumber             = { guifg = colors.red         , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSOperator           = { guifg = colors.orange      , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSParameter          = { guifg = colors.pink_light  , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSParameterReference = { guifg = colors.pink_light  , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSProperty           = { guifg = colors.fg          , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSPunctDelimiter     = { guifg = colors.grey_light  , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSPunctBracket       = { guifg = colors.blue        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSPunctSpecial       = { guifg = colors.blue_gruv   , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSRepeat             = { guifg = colors.fg_light    , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSString             = { guifg = colors.green_light , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSStringRegex        = { guifg = colors.green       , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSStringEscape       = { guifg = colors.green_gruv  , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSTag                = { guifg = colors.blue        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSTagDelimiter       = { guifg = colors.blue        , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSText               = { guifg = colors.fg          , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSStrong             = { guifg = colors.cyan        , guibg = nil , gui = BOLD            , guisp = nil }
    hi.TSEmphasis           = { guifg = colors.cyan_light  , guibg = nil , gui = ITALIC          , guisp = nil }
    hi.TSUnderline          = { guifg = colors.cyan        , guibg = nil , gui = UNDERLINE       , guisp = nil }
    hi.TSStrike             = { guifg = colors.cyan_light  , guibg = nil , gui = STRIKE          , guisp = nil }
    hi.TSTitle              = { guifg = colors.green       , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSLiteral            = { guifg = colors.green_light , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSURI                = { guifg = colors.fg          , guibg = nil , gui = UNDERLINE       , guisp = nil }
    hi.TSType               = { guifg = colors.orange      , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSTypeBuiltin        = { guifg = colors.orange      , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSVariable           = { guifg = colors.blue_light  , guibg = nil , gui = NONE            , guisp = nil }
    hi.TSVariableBuiltin    = { guifg = colors.fg          , guibg = nil , gui = NONE            , guisp = nil }

    -- hi.User1 = { guifg = colors.pink, guibg = colors.red_light, gui = NONE, guisp = nil }
    -- hi.User2 = { guifg = colors.pink, guibg = colors.orange, gui = NONE, guisp = nil }
    -- hi.User3 = { guifg = colors.pink, guibg = colors.orange, gui = NONE, guisp = nil }
    -- hi.User4 = { guifg = colors.pink, guibg = colors.blue, gui = NONE, guisp = nil }
    -- hi.User5 = { guifg = colors.red_light, guibg = colors.pink, gui = NONE, guisp = nil }
    -- hi.User6 = { guifg = colors.pink, guibg = colors.grey, gui = NONE, guisp = nil }
    -- hi.User7 = { guifg = colors.pink, guibg = colors.red, gui = NONE, guisp = nil }
    -- hi.User8 = { guifg = colors.black, guibg = colors.green_light, gui = NONE, guisp = nil }
    -- hi.User9 = { guifg = colors.black, guibg = colors.yellow, gui = NONE, guisp = nil }

    hi.DiffAdd     = { guifg = colors.green_gruv  , guibg = colors.black_gruv , gui = REVERSE , guisp = nil }
    hi.DiffChange  = { guifg = colors.blue_gruv   , guibg = colors.black_gruv , gui = REVERSE , guisp = nil }
    hi.DiffDelete  = { guifg = colors.red_gruv    , guibg = colors.black_gruv , gui = REVERSE , guisp = nil }
    hi.DiffText    = { guifg = colors.yellow_gruv , guibg = colors.black_gruv , gui = REVERSE , guisp = nil }
    hi.DiffAdded   = { guifg = colors.green_gruv  , guibg = colors.black_gruv , gui = REVERSE , guisp = nil }
    hi.DiffFile    = { guifg = colors.yellow_gruv , guibg = colors.black_gruv , gui = REVERSE , guisp = nil }
    hi.DiffNewFile = { guifg = colors.green_gruv  , guibg = colors.black_gruv , gui = REVERSE , guisp = nil }
    hi.DiffLine    = { guifg = colors.blue_gruv   , guibg = colors.black_gruv , gui = REVERSE , guisp = nil }
    hi.DiffRemoved = { guifg = colors.red_gruv    , guibg = colors.black_gruv , gui = REVERSE , guisp = nil }

    hi.SignAdd     = { guifg = colors.grey_light , guibg = colors.bg , gui = nil , guisp = nil }
    hi.SignChange  = { guifg = colors.cyan       , guibg = colors.bg , gui = nil , guisp = nil }
    hi.SignDelete  = { guifg = colors.red_light  , guibg = colors.bg , gui = nil , guisp = nil }
    hi.SignText    = { guifg = colors.fg         , guibg = colors.bg , gui = nil , guisp = nil }

    hi.GitGutterAdd     = { guifg = colors.grey_light , guibg = colors.bg , gui = nil , guisp = nil }
    hi.GitGutterChange  = { guifg = colors.cyan       , guibg = colors.bg , gui = nil , guisp = nil }
    hi.GitGutterDelete  = { guifg = colors.red_light  , guibg = colors.bg , gui = nil , guisp = nil }
    hi.GitGutterText    = { guifg = colors.fg         , guibg = colors.bg , gui = nil , guisp = nil }


    hi.gitcommitOverflow      = { guifg = colors.red        , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitSummary       = { guifg = colors.fg         , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitComment       = { guifg = colors.grey       , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitUntracked     = { guifg = colors.grey       , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitDiscarded     = { guifg = colors.grey       , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitSelected      = { guifg = colors.grey       , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitHeader        = { guifg = colors.cyan_light , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitSelectedType  = { guifg = colors.pink_light , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitUnmergedType  = { guifg = colors.pink_light , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitDiscardedType = { guifg = colors.pink_light , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitBranch        = { guifg = colors.red        , guibg = nil , gui = BOLD , guisp = nil }
    hi.gitcommitUntrackedFile = { guifg = colors.green_gruv , guibg = nil , gui = nil  , guisp = nil }
    hi.gitcommitUnmergedFile  = { guifg = colors.green_gruv , guibg = nil , gui = BOLD , guisp = nil }
    hi.gitcommitDiscardedFile = { guifg = colors.red_gruv   , guibg = nil , gui = BOLD , guisp = nil }
    hi.gitcommitSelectedFile  = { guifg = colors.yellow     , guibg = nil , gui = BOLD , guisp = nil }

    hi.TelescopeSelection      = { guifg = colors.green_light , guibg = colors.black , gui   = nil , guisp = nil }
    hi.TelescopeSelectionCaret = { guifg = colors.green_light , guibg = colors.black   , gui = nil , guisp = nil }
    hi.TelescopeMultiSelection = { guifg = colors.orange      , guibg = nil            , gui = nil , guisp = nil }
    hi.TelescopeNormal         = { guifg = colors.fg          , guibg = nil            , gui = nil , guisp = nil }
    hi.TelescopeMatching       = { guifg = colors.yellow      , guibg = nil            , gui = nil , guisp = nil }
    hi.TelescopePromptPrefix   = { guifg = colors.green_light , guibg = nil            , gui = nil , guisp = nil }

    hi.FernBranchText   = { guifg = colors.blue   , guibg = nil , gui = nil    , guisp = nil }
    hi.typescriptImport  = { guifg = colors.green , guibg = nil , gui = ITALIC , guisp = nil }

    return hi

end

local function setup()
  vim.api.nvim_command('syntax on')
  vim.api.nvim_command('syntax reset')
  vim.api.nvim_command('hi clear')
  vim.api.nvim_command('set termguicolors')
  local hi = theme(wind)
  vim.o.background = 'dark'
  vim.o.termguicolors = true
  vim.g.colors_name = "wind"
  for group,color in pairs(hi) do
    highlight(group, color)
  end
end

setup()
