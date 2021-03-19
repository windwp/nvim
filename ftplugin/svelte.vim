if exists("b:did_ftplugin")
    finish
endif

" svelte {{{

let g:tagalong_additional_filetypes = ['svelte']
let g:closetag_filetypes = 'html,xhtml,phtml,svelte'
let g:vim_svelte_plugin_use_typescript=1

" }}}
set foldmethod=manual
nnoremap <buffer> za zfat
" delete tag in html
nnoremap <nowait> <buffer> cx T<space>d2f"
nnoremap <buffer> <leader>ul :call MyCodeFormat()<CR>

" autocmd FileType svelte autocmd BufWritePre <buffer> :Format

" Example: set local options based on subtype
function! OnChangeSvelteSubtype(subtype)
  " echom 'Subtype is '.a:subtype
  if empty(a:subtype) || a:subtype == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:subtype =~ 'css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction
" vim: set ts=8 sts=4 sw=4 expandtab :
