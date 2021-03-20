" vim: foldmethod=marker  sw=2 formatoptions-=o foldlevel=0
" My vim my way :)
" Keyboard config
" =====================================

noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR><Esc>
inoremap <silent> <C-S>         <C-O>:update<CR><Esc>

nnoremap <C-z> u
inoremap <C-z> <c-o>u


" Shortcutting split navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
tnoremap <esc><esc> <C-\><C-N>

nnoremap <silent><expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <silent><expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <silent><expr> j v:count == 0 ? 'gj' : 'j'
" nnoremap 0 gg
onoremap H ^
nnoremap H ^
vnoremap H ^
" nnoremap gg ^
nnoremap L $
onoremap L $
vnoremap L $

"navigation and edit  in insert mode and command mode
"it is similar to any terminal emulator or it from zsh??
"someone say it from emac but who care?
inoremap <expr> <c-e> pumvisible()? "<c-e>":"<C-o>$"
inoremap <c-a> <Home>
inoremap <c-u> <esc>0d$a
inoremap <c-f> <Right>
inoremap <c-b> <Left>
"seem like c-h is default of vim
" make it trigger bs
imap <c-h> <bs>

nnoremap ; :

" fast select by press vvv dont need to press Shift V
vmap v <Plug>(expand_region_expand)
vmap u <Plug>(expand_region_shrink)


" Disable Ex mode
" use for run macro
nnoremap Q @q
vnoremap Q :norm @q<CR>
nnoremap x "_x

" switch between current and last buffer
nnoremap g. <c-^>
" copy line to paste in visual mode with out new line
nmap yl ^vg_y

" paste in visual mode automatic put to register 1
" if you want to use g0 it will retrieve cut text
" register 0 it don't work over ssh
xnoremap <expr> p  wind#IsEndOfLine() ? '"1dp' :'"1dP'
" xnoremap P "1dPgv

" copy from register 1
nmap g0 "1p

" replace text object from register vscode have a function for this but it
" https://github.com/vim-scripts/ReplaceWithRegister
" need griw not grw

" nmap grw viwp
" stupid but it work  because i want it  can repeat
nnoremap grw viw"1y:let @/=@1<CR>:let @2=@+<CR>cgn<c-r>2<esc>:let @+=@2<CR>
nmap grt vitp
nmap grat viatp

" goto bracket i don't want to use shift key %
nmap g5 %

nnoremap <C-A> ggVG
" use alt-a for increase number"
nnoremap <a-a> <c-a>
vnoremap <a-a> <c-a>

" nnoremap gb :call GotoJump()<CR>


nnoremap <silent> <C-_> :Commentary<cr>

nnoremap <silent> <C-_> :Commentary<cr>
" commentary code  c-/
nnoremap <silent> <C-_> :Commentary<cr>
inoremap <silent> <C-_> <c-o>:Commentary<cr>
vnoremap <silent> <C-_> :Commentary<cr>gv

" Move line when select,it can combine with count
" Map to ctrl + shift + J,K on alacritty
nnoremap  <c-t>j V<esc>:call wind#MoveLine(1)<CR>
nnoremap  <c-t>k V<esc>:call wind#MoveLine(-1)<CR>

vmap  <c-t>j <esc>:call wind#MoveLine(1)<CR>
vmap  <c-t>k <esc>:call wind#MoveLine(-1)<CR>

" duplicate line my old style from visual studio for duplicate line with
" ctrl+shift+d
nmap <silent> <c-t>d :t.<cr>
vmap <silent> <c-t>d yP'><cr>

" map to ctrl tab it make me feel like i move tab on chrome"

" it map to special characters on terminal use <a-{1-6}>
if get(g:, 'wind_use_buffline', 0) == 0
  nnoremap <c-t>1 1gt
  nnoremap <c-t>2 2gt
  nnoremap <c-t>3 3gt
  nnoremap <c-t>4 4gt
  nnoremap <c-t>5 5gt
  nnoremap <c-t>6 6gt
  " tab move
  nnoremap <A-1> 1gt
  nnoremap <A-2> 2gt
  nnoremap <A-3> 3gt
  nnoremap <A-4> 4gt
  nnoremap <A-5> 5gt
  nnoremap <A-6> 6gt
  nnoremap <A-7> 7gt
endif

nnoremap <silent> <c-t>t :tabnext<CR>
inoremap <silent> <c-t>t <ESC>:tabnext<CR>

" scroll the viewport faster
" sorry c-d
nnoremap <C-e> 7jzz
nnoremap <C-u> 7kzz

" Correct typos in insert mode.
inoremap <C-L> <C-G>u<Esc>[s1z=`]a<C-G>u

" keep visual selection when indenting/outdenting
vmap > >gv
vmap < <gv

" Remove highlight
nnoremap <nowait> <silent>gc :nohl<CR>
nmap <nowait> <silent>  gl <Plug>(MyLogger)
nnoremap <nowait> <silent>gq :call wind#SuperQuit()<CR>
" ~~~~~ mytab openfile command
nnoremap <nowait> <silent>gf :TabCustomOpen <c-r>=expand("<cfile>")<CR><CR>

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_disable_when_zoomed = 1

  nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
nmap <leader>s :HopChar2<cr>

" Execute Vimscript {{{
" copy from @tj
  " Map execute this line
  function! s:executor() abort
    if &ft == 'lua'
      call execute(printf(":lua %s", getline(".")))
    elseif &ft == 'vim'
      exe getline(">")
    endif
  endfunction
  nnoremap <leader>x :call <SID>executor()<CR>

  vnoremap <leader>x :<C-w>exe join(getline("'<","'>"),'<Bar>')<CR>
  " Execute this file
  if get(g:,'save_and_exec',0)==0
    let g:save_and_exec=1
    function! s:save_and_exec() abort
      if &filetype == 'vim'
        :silent! write
        :source %
      elseif &filetype == 'lua'
        :silent! write
        :luafile %
      endif
    endfunction
  endif
  nnoremap <leader><leader>x :call <SID>save_and_exec()<CR>
" }}}


