
"=================================="
"          Fzf.vim           
"=================================="

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
let g:fzf_action = {
\ 'enter': 'TabCustomOpen',
\ 'ctrl-t': 'tab split',
\ 'ctrl-l': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" fzf
noremap <C-p> :Files<CR>
inoremap <C-p> <C-O>:Files<CR>
nnoremap <silent> <c-t>f :AG<CR>
inoremap <silent> <c-t>f <ESC>:AG<CR>
" goto buffers list
noremap g; :Buffers<CR>
noremap g, :History<CR>
"ctrl shift p map to alacritty it is similar to vscode
nnoremap <silent> <c-t>p :Commands<CR>

function! RipgrepFzf(query, fullscreen)
    if getcwd()== $HOME
        echo "Better not search in HOME directory"
        return
    endif
    let arrQuery = split(a:query)
    let searchQuery = a:query
    let optionQuery = ''
    if(len(arrQuery)>2)
        let searchQuery=join(arrQuery[len(arrQuery)-1:len(arrQuery)])
        let optionQuery=join(arrQuery[0:len(arrQuery)-2])
    endif
    let command_fmt = 'rg --column --line-number --no-heading --color=never --sortr=modified --smart-case '.optionQuery.' %s | awk NF || true'
    let initial_command = printf(command_fmt,shellescape(searchQuery) )
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', '', '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" -g search wiht filename GLOB pattern example: RG -g "*.tsx" {query}
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" ag advanced
function! AgCustomFzf(query, fullscreen)
    if getcwd()== $HOME
        echo "Better not search in HOME directory"
        return
    endif
    let arrQuery = split(a:query)
    let searchQuery = a:query
    let optionQuery = ''
    if(len(arrQuery)>2)
        let searchQuery=join(arrQuery[len(arrQuery)-1:len(arrQuery)])
        let optionQuery=join(arrQuery[0:len(arrQuery)-2])
    endif
    let command_fmt = 'ag --column --numbers --noheading --nocolor --smart-case '. optionQuery . ' %s | awk NF || true' 
    let initial_command = printf(command_fmt,shellescape(searchQuery) )
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', '' , '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" -G for search by filname REGEX pattern example: AG -G ".*tsx" {query} 
command! -nargs=* -bang AG call AgCustomFzf(<q-args>, <bang>0)

let $FZF_DEFAULT_OPTS = '--layout=reverse --border'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" disregard .gitignore and .git files
" let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

" https://github.com/narajaon/nvim_setup/blob/985f10cc1b7f9332f220a7e90365777b40f335a8/plugin/fzf_jump.vim
" if exists("g:loaded_fzf_jump")
"   finish
" endif
" let g:loaded_fzf_jump= 1

" change default layout
let g:fzf_jump_options = ["--prompt",  "Jumps>","--tac","--reverse", "--preview", "$HOME/.config/my_scripts/vim_preview.sh {2}"  ]

function <SID>FloatingFZF()

  let height = 20
  let width = 120
  let horizontal = 1
  let vertical = 1

  let opts = {
        \ 'relative': 'cursor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  call nvim_open_win(buf, v:true, opts)
    " terminal
  " startinsert
endfunction

function s:UpNTimes(n)
  let l:i = 0

  " gives the popup time to load, autocmd isn't as reliable
  exe "sleep " . "15ms"

  while i < a:n
    call feedkeys("\<c-j>", 'n')
    let l:i = l:i + 1
  endwhile
endfun

function s:CompareJumpLists(fzfList)
  let juList = filter(split(execute(':ju'), '\n')[1:], {_,v -> v != '>'})
  let jumpList = reverse(juList)
  let s:curPosition = match(jumpList, '^>') 
  let fzfList = reverse(a:fzfList)
  let formated = map(jumpList, {i,v -> printf('%2s %s', split(v)[0], split(fzfList[i])[0])})
  return reverse(formated)
endfun

function s:GenerateJump()
  let Bufpath = {v -> expand("#".v.":~")}
  let sanitized = copy(getjumplist()[0])
  let stringified = map(sanitized, 'printf("%s:%s:%s", Bufpath(v:val.bufnr), v:val.lnum, v:val.col)')
  return s:CompareJumpLists(stringified)
endfun

function <SID>GoToJump(line)
  try
    let splited = split(split(a:line)[1], ':')
    let [bno, lno, col] = splited
    let fullPath = expand(bno)
    let bufno = bufnr(fullPath)
    exe "b " . bufno
    call setpos('.', [bufnr('%'), lno, col, 0])
  catch /.*/
    echoer 'oops'
    return
  endtry
endfun

function <SID>Fzf_History_Jump(options, isFullscreen)
  let s:curPosition = 0

  let s:saved_layout = g:fzf_layout
  let g:fzf_layout = { 'window': 'FloatingFZF' }

  let s:save_cpo = &cpo
  set cpo&vim

  call fzf#run(fzf#wrap({ 'source': s:GenerateJump(), 'sink': function('<SID>GoToJump'), 'options': a:options }, a:isFullscreen))
  call s:UpNTimes(s:curPosition)

  let g:fzf_layout = s:saved_layout

  let &cpo = s:save_cpo
  unlet s:save_cpo
endfun

" jumps
if !exists(":Jump") && !exists(":FloatingFZF") && !hasmapto('<nowait><leader>j')
  command! -bang -nargs=0 Jump call <SID>Fzf_History_Jump(fzf_jump_options, <bang>0)
  command! -nargs=0 FloatingFZF call <SID>FloatingFZF()

  " jump list
  " noremap <unique> <nowait><leader>x :Jump<cr>
endif
