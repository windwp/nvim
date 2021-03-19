vim.api.nvim_exec([[
" disable match parent on insert mode
function! ToggleMatchParent(status)
  if &buftype != 'nofile'
    if a:status == 1
      DoMatchParen
    else
      NoMatchParen
    endif
  endif
endfunction

augroup matchparent_wind
    autocmd!
    au InsertLeave * call ToggleMatchParent(1)
    au InsertEnter * call ToggleMatchParent(0)
augroup END
]],false)
