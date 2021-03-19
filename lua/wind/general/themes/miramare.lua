
vim.g.miramare_palette = {
  light_grey= { '#928374', '245', 'LightGrey' },
  grey     = { '#928374', '245', 'LightGrey' }
}
vim.g.miramare_enable_italic = 0
vim.g.miramare_disable_italic_comment = 1
vim.g.miramare_transparent_background =  vim.g.wind_use_bg == 1

vim.api.nvim_exec([[
colorscheme miramare
hi MatchParen  ctermfg=172 ctermbg=none guibg=#d79921 guifg=#43A047
hi IndentLine guifg=#37474F ctermfg=246 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  ]],true)


