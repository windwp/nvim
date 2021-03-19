vim.g.wind_use_note          = 1
vim.g.wind_theme             = 'gruvbox'
vim.g.wind_use_indent        = 0
vim.g.gruvbox_contrast_light = 'medium'

require('wind')

vim.api.nvim_exec([[
set cursorline
set linebreak    " line break will break a character to next line
set cmdheight=1 "reduce cmd height
set norelativenumber nonumber noshowmode noshowcmd! hidden! noruler noshowcmd
set laststatus=0
"turn off signcolumn
set signcolumn=no

" hide status bar on which_key
autocmd! FileType which_key

" use it to re open file when open note
augroup MyAutoWriteNote
    autocmd!
    autocmd BufReadPre *.md  :silent !echo '%:p' > /tmp/$USER/my_note_file.txt
augroup END
" hi Normal guibg=#faf9dc guifg=#7c6f64
]],false)

import('general.autocmd').add_autocmd_color('telescope',function ()
  vim.api.nvim_exec([[
    hi CursorLine ctermbg=255 ctermfg=16
    " change color on selected text
    highlight Visual cterm=NONE ctermbg=252 guifg=#ebdbb2 guibg=#000000
    highlight TelescopeMatching       guifg=#0091EA
    highlight TelescopeSelection      guifg=#CC241D gui=bold  guibg=#ebdbb2
    highlight TelescopeSelectionCaret guifg=#CC241D " selection caret
 ]],false)
end)
