" https://github.com/lambdalisue/fern.vim/blob/master/doc/fern.txt
" Disable netrw.
packadd fern-renderer-nerdfont.vim 
packadd glyph-palette.vim 

let g:fern#renderer = "nerdfont"
augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1
let g:fern#default_hidden=1
let g:fern#autoclose=1
let g:fern#hide_cursor=1

let g:fern#keepalt_on_edit=1
let g:fern#disable_drawer_auto_winfixwidth=0

noremap <silent> F :let g:fern#autoclose=0<bar>:let g:fern#open_buffer=bufnr('%')<bar>:keepalt Fern  %:h -reveal=%:p<CR>
noremap <silent> <c-b> :let g:fern#autoclose=1 <bar>  Fern . -drawer -reveal=% -toggle <CR><C-w>=

function! s:closeFern(target) abort
  if a:target == "split"
    execute "normal \<Plug>(fern-action-open:split)"
  elseif a:target== "vsplit"
    execute "normal \<Plug>(fern-action-open:vsplit)"
  else
    execute "normal \<Plug>(fern-action-open)"
  endif
  if g:fern#autoclose ==0
    execute "FernDo close -drawer -stay"
  endif
endfunction

function! s:DownloadFile() abort
    execute "normal \<Plug>(fern-action-yank:path)"
    let l:text=getreg('+')
    echom " . l:text: ".l:text
    execute "AsyncRunSilent cpdragon " . l:text
endfunction

function! s:quitFern() abort
    execute ":buffer " . g:fern#open_buffer
endfunction

function! FernInit() abort
  nmap <silent> <buffer> <Plug>(fern-my-open-and-close) :<c-u>call <sid>closeFern("") <CR>
  nmap <silent> <buffer> <Plug>(fern-my-open-and-close:split) :<c-u>call <sid>closeFern("split") <CR>
  nmap <silent> <buffer> <Plug>(fern-my-open-and-close:vsplit) :<c-u>call <sid>closeFern("vsplit") <CR>
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-my-open-and-close)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> l <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> h <Plug>(fern-action-collapse)
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> u <Nop>
  nmap <buffer> <leader>n <Plug>(fern-action-new-path)
  " nnoremap <buffer> <leader>n n
  nmap <buffer> dd <Plug>(fern-action-remove)
  nmap <buffer> yn <Plug>(fern-action-yank:label)
  nmap <buffer> yf <Plug>(fern-action-yank:path)

  nmap <silent> <buffer> cm <Plug>(fern-action-clipboard-move)
  nmap <silent> <buffer> cp <Plug>(fern-action-clipboard-paste)
  nmap <silent> <buffer> cc <Plug>(fern-action-clipboard-copy)
  nmap <silent> <buffer> yy <Plug>(fern-action-clipboard-copy)
  nmap <silent> <buffer> cx <Plug>(fern-action-mark:clear)
  nmap <silent> <buffer> dr :<c-u>call <sid>DownloadFile() <CR>
  nmap <silent> <buffer> M <Plug>(fern-action-rename)
  nmap <silent> <buffer> cw <Plug>(fern-action-rename:split)
  " nmap <buffer> h <Plug>(fern-action-hidden:toggle)
  nmap <silent> <buffer> r <Plug>(fern-action-reload)
  nmap <silent> <buffer> t <Plug>(fern-action-mark)j
  nmap <silent> <buffer> b <Plug>(fern-my-open-and-close:split)
  nmap <silent> <buffer> <c-l> <Plug>(fern-my-open-and-close:vsplit)
  nmap <silent> <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <silent> <buffer><nowait> > <Plug>(fern-action-enter)
  nmap <silent> <buffer><nowait> z <Plug>(fern-action-zoom)
  if g:fern#autoclose ==0
      nmap <silent><buffer> F :<c-u>call <sid>quitFern() <CR>
      nmap <silent><buffer> gq :<c-u>call <sid>quitFern() <CR>
  else
      nmap <silent><buffer> F :q <CR>
  endif
  setlocal foldmethod=manual

  if get(g:,'wind_use_icon', 0) == 1
      highlight GlypPallteSelect guifg=#9d0006
      let g:glyph_palette#defaults#palette['GlyphPaletteDirectory']=['', '' ]
      let g:glyph_palette#defaults#palette['GlypPallteSelect']=['']
      call glyph_palette#apply()
  endif
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

"=================================="
"          Icon glyph           "
"=================================="

augroup fern-glyph-palette
  autocmd!
  autocmd FileType fern-replacer  setlocal foldmethod=manual | nnoremap <buffer> <c-s> :w<cr>
  autocmd FileType fern  setlocal norelativenumber | setlocal nonumber | setlocal signcolumn=no
augroup END

