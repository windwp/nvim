
" ===============================================================
" rigel
" 
" URL: https://github.com/Rigellute/rigel
" Author: Alexander Keliris
" License: MIT
" Last Change: 2020/04/21 14:31
" ===============================================================

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="rigel"


let Italic = ""
if exists('g:rigel_italic')
  let Italic = "italic"
endif
let g:rigel_italic = get(g:, 'rigel_italic', 0)

let Bold = ""
if exists('g:rigel_bold')
  let Bold = "bold"
endif

let g:rigel_bold = get(g:, 'rigel_bold', 0)
hi ColorColumn guifg=NONE ctermfg=NONE guibg=#001a25 ctermbg=234 gui=NONE cterm=NONE
hi Cursor guifg=NONE ctermfg=NONE guibg=#orange ctermbg=209 gui=NONE cterm=NONE
hi CursorColumn guifg=NONE ctermfg=NONE guibg=#001a25 ctermbg=234 gui=NONE cterm=NONE
hi CursorLine guifg=NONE ctermfg=NONE guibg=#001a25 ctermbg=234 gui=NONE cterm=NONE
hi CursorLineNr guifg=#yellow ctermfg=153 guibg=#bg ctermbg=234 gui=NONE cterm=NONE
hi LineNr guifg=$black_light ctermfg=246 guibg=#bg ctermbg=235 gui=NONE cterm=NONE
" hi DiffAdd guifg=#green_light ctermfg=156 guibg=#bg ctermbg=235 gui=NONE cterm=NONE
" hi DiffChange guifg=#cyan ctermfg=44 guibg=#bg ctermbg=235 gui=underline cterm=underline
" hi DiffDelete guifg=red_light ctermfg=167 guibg=#bg ctermbg=235 gui=NONE cterm=NONE
" hi DiffText guifg=#fg ctermfg=254 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi ErrorMsg guifg=red_light ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi VertSplit guifg=#grey ctermfg=66 guibg=#bg ctermbg=235 gui=NONE cterm=NONE
hi Folded guifg=$black_light ctermfg=246 guibg=black ctermbg=23 gui=NONE cterm=NONE
hi SignColumn guifg=grey_light ctermfg=153 guibg=#bg ctermbg=235 gui=NONE cterm=NONE
hi IncSearch guifg=#bg ctermfg=235 guibg=#yellow ctermbg=220 gui=NONE cterm=NONE
hi MatchParen guifg=#bg ctermfg=235 guibg=cyan_light ctermbg=14 gui=NONE cterm=NONE
hi NonText guifg=#grey ctermfg=66 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Normal guifg=#fg ctermfg=254 guibg=#bg ctermbg=235 gui=NONE cterm=NONE
hi NormalLight guifg=#b3e5fc ctermfg=254 guibg=#bg ctermbg=235 gui=NONE cterm=NONE
hi PMenu guifg=#fg ctermfg=254 guibg=black ctermbg=23 gui=NONE cterm=NONE
hi PMenuSel guifg=cyan_light ctermfg=14 guibg=#grey ctermbg=66 gui=NONE cterm=NONE
hi Search guifg=#bg ctermfg=235 guibg=#yellow ctermbg=209 gui=NONE cterm=NONE
hi SpellBad guifg=$black_light ctermfg=246 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi link SpellLocal SpellBad
hi link SpellCap SpellBad
hi link SpellRare SpellBad
hi StatusLine guifg=#fg ctermfg=254 guibg=black ctermbg=23 gui=NONE cterm=NONE
hi StatusLineNC guifg=#fg ctermfg=254 guibg=#grey ctermbg=66 gui=NONE cterm=NONE
hi TabLine guifg=$black_light ctermfg=246 guibg=black ctermbg=23 gui=NONE cterm=NONE
hi TabLineFill guifg=NONE ctermfg=NONE guibg=black ctermbg=23 gui=NONE cterm=NONE
hi TabLineSel guifg=#fg ctermfg=254 guibg=#blue ctermbg=31 gui=NONE cterm=NONE
hi Title guifg=cyan_light ctermfg=14 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Visual guifg=NONE ctermfg=NONE guibg=#194b5e ctermbg=23 gui=NONE cterm=NONE
hi WildMenu guifg=#fg ctermfg=254 guibg=#grey ctermbg=66 gui=NONE cterm=NONE
hi Comment guifg=$black_light ctermfg=246 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Constant guifg=#orange ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi String guifg=#green_light ctermfg=156 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Boolean guifg=#red ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link Number Boolean
hi link Float Boolean
hi Identifier guifg=#orange ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Function guifg=#blue_bold ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Statement guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link Conditional Keyword
hi link Repeat Keyword
hi link Label Keyword
hi link Operator Constant
hi Keyword guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Exception guifg=red_light ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Include guifg=#cyan ctermfg=44 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link Define Include
hi link Macro Include
hi Type guifg=#red ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link StorageClass Keyword
hi Structure guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Typedef guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link Special Keyword
hi Tag guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SpecialComment guifg=cyan_light ctermfg=14 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Debug guifg=#pink_light ctermfg=213 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Underlined guifg=grey_light ctermfg=153 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi PreProc guifg=#pink_light ctermfg=213 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


hi link Ignore Comment
hi Error guifg=red_light ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Todo guifg=#pink_light ctermfg=213 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link diffAdded DiffAdd
hi link diffRemoved DiffDelete
hi jsVariableDef guifg=grey_light ctermfg=153 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link jsStatement Keyword
hi link jsStorageClass Keyword
hi link jsExtendsKeyword Keyword
hi jsTemplateString guifg=#green ctermfg=107 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link jsReturn Keyword
hi link jsTryCatchBlock Boolean
hi link jsAsyncKeyword Boolean
hi link jsForAwait Boolean
hi jsGlobalNodeObjects guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi jsImport guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=Italic cterm=Italic
hi link jsFrom Keyword
hi link jsModuleAs Keyword
hi jsModuleKeyword guifg=grey_light ctermfg=153 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link jsModuleAsterisk Keyword
hi jsExport guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=Italic cterm=Italic
hi link jsExportDefault Keyword
hi link jsObjectMethodType Function
hi link jsArrowFunction Function
hi link jsObjectProp jsVariableDef
hi jsObjectKey guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link jsFunctionKey Function
hi link jsRestExpression Keyword
hi link jsGenerator Function
hi link jsFunction Keyword
hi link javaScriptStatement Keyword
hi xmlAttrib guifg=#red ctermfg=203 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link xmlTag Function
hi link xmlTagName xmlTag
hi link xmlEndTag xmlTag
hi htmlH1 guifg=#cyan ctermfg=44 guibg=NONE ctermbg=NONE gui=Bold cterm=Bold
hi link htmlH2 htmlH1
hi htmlH3 guifg=#cyan ctermfg=44 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link htmlH4 htmlH3
hi link htmlH5 htmlH3
hi link htmlH6 htmlH3
hi markdownHeadingDelimiter guifg=#grey ctermfg=66 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownOrderedListMarker guifg=#grey ctermfg=66 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownCodeDelimiter guifg=#grey ctermfg=66 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi markdownCode guifg=#grey ctermfg=66 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptVariable guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptValue guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptObjectLabel guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptPrimaryType guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptMember guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptMemberOptionality guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptVariableDeclaration guifg=grey_light ctermfg=153 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptProp guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link typescriptStatement Keyword
hi link typescriptStorageClass Keyword
hi link typescriptExtendsKeyword Keyword
hi typescriptTemplateString guifg=#green ctermfg=107 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptEnum guifg=#pink_light ctermfg=213 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link typescriptReturn Keyword
hi link typescriptTryCatchBlock Boolean
hi link typescriptTernary Boolean
hi link typescriptAsyncKeyword Boolean
hi link typescriptObjectAsyncKeyword Boolean
hi typescriptObjectColon guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link typescriptAsyncFor Boolean
hi link typescriptForAwait Boolean
hi typescriptGlobalNodeObjects guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptGlobal guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi typescriptImport guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=Italic cterm=Italic
hi typescriptExportType guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=Italic cterm=Italic
hi link typescriptImportType Keyword
hi link typescriptFrom Keyword
hi link typescriptModuleAs Keyword
hi link typescriptModule Keyword
hi typescriptModuleKeyword guifg=grey_light ctermfg=153 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi link typescriptModuleAsterisk Keyword
hi link typescriptExport Keyword
hi link typescriptExportDefault Keyword
hi link typescriptCastKeyword Function
hi link typescriptGenerator Function
hi link typescriptFunction Keyword
hi link typescriptError Error
hi link typescriptBoolean Boolean

" lsp an nvim-treesitter

                                           " LspDiagnosticsVirtualTextError
hi link htmlEndTag Function
hi LspDiagnosticsSignError  guifg=red_light ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsSignWarning guifg=#orange ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsSignInformation guifg=#pink ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi LspDiagnosticsSignHint guifg=#blue ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

hi link LspDiagnosticsVirtualTextError LspDiagnosticsSignError
hi link LspDiagnosticsVirtualTextWarning LspDiagnosticsSignWarning
hi link LspDiagnosticsVirtualTextInformation LspDiagnosticsSignInformation

hi SignAdd guifg=#green_light ctermfg=156 guibg=#bg ctermbg=235 gui=NONE cterm=NONE
hi SignChange guifg=#cyan ctermfg=44 guibg=#bg ctermbg=235 gui=NONE cterm=underline
hi SignDelete guifg=red_light ctermfg=167 guibg=#bg ctermbg=235 gui=NONE cterm=NONE
hi SignText guifg=#fg ctermfg=254 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE


hi DiffChange   cterm=reverse ctermfg=108 ctermbg=235 gui=reverse guifg=#8ec07c guibg=#282828
hi DiffAdd  cterm=reverse ctermfg=142 ctermbg=235 gui=reverse guifg=#b8bb26 guibg=#282828
hi DiffDelete cterm=reverse ctermfg=167 ctermbg=235 gui=reverse guifg=#fb4934 guibg=#282828
hi DiffText     cterm=reverse ctermfg=214 ctermbg=235 gui=reverse guifg=#fabd2f guibg=#282828



" highlight ConflictMarkerBegin guifg=#blue guibg=#282828 gui=reverse
" highlight ConflictMarkerOurs guifg=#b8bb26 guibg=#282828 gui=reverse
" highlight ConflictMarkerTheirs guifg=#fb4934 guibg=#282828 gui=reverse
" highlight ConflictMarkerEnd guifg=#blue guibg=#282828 gui=reverse
" highlight ConflictMarkerCommonAncestorsHunk guifg=#754a81 guibg=#282828 gui=reverse


hi IndentLine guifg=#073d52 ctermfg=246 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SignColumn ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE

hi link GitGutterAdd     SignAdd
hi link GitGutterChange  SignChange
hi link GitGutterDelete  SignDelete

hi link TSProperty Normal
hi link TSMethod jsGlobalNodeObjects
hi link TSType Constant
hi link TSParameter PreProc

hi link TSVariable NormalLight
hi link TSFunction Function
hi link TSVariableBuiltin Structure
hi link TSPunctBracket Structure
hi link TSPunctDelimiter Structure
hi link TSPunctSpecial SpecialComment
hi link TSTagDelimiter Structure

hi link htmlEndTag Function
hi LineNr  ctermbg=NONE  guibg=NONE

let g:terminal_color_foreground = "#fg"
let g:terminal_color_background = "#bg"
let g:terminal_color_0 = "black"
let g:terminal_color_1 = "red_light"
let g:terminal_color_2 = "#green"
let g:terminal_color_3 = "#orange"
let g:terminal_color_4 = "#blue"
let g:terminal_color_5 = "#pink"
let g:terminal_color_6 = "#cyan"
let g:terminal_color_7 = "$black_light"
let g:terminal_color_8 = "#grey"
let g:terminal_color_9 = "#red"
let g:terminal_color_10 = "#green_light"
let g:terminal_color_11 = "#yellow"
let g:terminal_color_12 = "#blue_bold"
let g:terminal_color_13 = "#pink_light"
let g:terminal_color_14 = "cyan_light"
let g:terminal_color_15 = "grey_light"

" ===================================
" Generated by Estilo 1.4.1
" https://github.com/jacoborus/estilo
" ===================================
"
