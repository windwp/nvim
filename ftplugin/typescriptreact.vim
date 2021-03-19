source $HOME/.config/nvim/ftplugin/javascript.vim

nnoremap <buffer> cx T<space>d2f"

if get(g:, 'wind_use_treesitter', 0) == 1
    function! s:update_commentstring()
        if luaeval("import('core.utils').check_ts_node('^jsx')") 
            let &l:commentstring = '{/* %s */}'
        else
            let &l:commentstring = '// %s'
        endif
    endfunction
    autocmd CursorMoved <buffer> call s:update_commentstring()
endif
