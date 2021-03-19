vim.g.gitgutter_override_sign_column_highlight = 1
vim.g.gruvbox_sign_column = 1

import('general.autocmd').add_autocmd_color('gruvbox',function ()
  vim.api.nvim_exec([[
  hi! link xmlTag GruvboxOrange
  hi! link htmlTag GruvboxOrange
  hi! link htmlTagN GruvboxOrange
  hi! link htmlTagName GruvboxOrange
  hi! link xmlEndTag GruvboxOrange
  hi! link xmlTagName GruvboxOrange
  hi! link xmlEqual GruvboxOrange
  hi LspDiagnosticsSignError  guifg=#c43060 ctermfg=167 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsSignWarning guifg=#f08e48 ctermfg=209 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsSignInformation guifg=#c694ff ctermfg=177 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi LspDiagnosticsSignHint guifg=#1c8db2 ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

  hi link LspDiagnosticsVirtualTextError LspDiagnosticsSignError
  hi link LspDiagnosticsVirtualTextWarning LspDiagnosticsSignWarning
  hi link LspDiagnosticsVirtualTextInformation LspDiagnosticsSignInformation
  hi IndentLine guifg=#073d52 ctermfg=246 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi MatchParen ctermfg=172 ctermbg=232 guifg=#d79921 guibg=#43A047
  ]],true)
end)
vim.cmd[[colorscheme gruvbox]]
