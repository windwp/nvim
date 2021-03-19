" Lightline: {{{

" Note Setting: {{{

if !exists("g:wind_use_note")
  " change bg color
  " this color scheme will force background change to dark????
  " set background=dark
    if get(g:, 'wind_use_bg' , 0) == 0
      hi Normal  ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
    endif
  " hi CursorLine ctermbg=232 guibg=#0f0f0f
  " hi Search  ctermfg=172 ctermbg=232 guifg=#d79921 guibg=#0f0f0f
  " highlight ColorColumn ctermbg=0 guibg=lightgrey
  " change colorin auto complete menu
  source $HOME/.config/nvim/colors/lightline/pywal_lightline_dark.vim
else
  set background=light
  source $HOME/.config/nvim/colors/lightline/pywal_lightline_light.vim
endif

" }}}
" set showtabline=2
function! LightlineFilename()
    let n = tabpagenr()
    let buflist = tabpagebuflist(n)
    let winnr = tabpagewinnr(n)
    let bufnum = buflist[winnr - 1]
    let bufname = expand('#'.bufnum.':t')
    let buffullname = expand('#'.bufnum.':p')
    if buffullname =~ '^fugitive'
        let bufname = bufname . '[git]'
    endif
    let buffullnames = []
    let bufnames = []
    for i in range(1, tabpagenr('$'))
        if i != n
            let num = tabpagebuflist(i)[tabpagewinnr(i) - 1]
            call add(buffullnames, expand('#' . num . ':p'))
            call add(bufnames, expand('#' . num . ':t'))
        endif
    endfor
    let i = index(bufnames, bufname)
    if strlen(bufname) && i >= 0 && buffullnames[i] != buffullname
        return substitute(buffullname, '.*/\([^/]\+/\)', '\1', '')
    else
        return strlen(bufname) ? bufname : '[No Name]'
    endif
endfunction

function! LightLineLspStatus() abort
    if len(get(b:, "wind_lsp_server_name" , "")) > 1
        return b:wind_lsp_server_name
    endif
    return ""
endfunction

if get(g:,'wind_use_icon', 0) == 1
    function! LightlineFiletype()
        let l:bufname=bufname("%")
        let l:ext = fnamemodify(l:bufname, ":e")
        let l:filename = fnamemodify(l:bufname, ":t")
        let l:icon =luaeval("require('nvim-web-devicons').get_icon('".l:filename."', '" . l:ext."')")
        return l:icon.' '. &filetype
    endfunction
else
    function! LightlineFiletype()
        return &filetype
    endfunction
endif

function! LightlineResizeMode()
    return get(g:, "resize_active" , "0") != 1 ? "" : "Resize Mode"
endfunction
let g:lightline#bufferline#show_number=2
let g:lightline = {
            \'colorscheme': get(g:,'wind_statusline_theme' , 'rigel') ,
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'lspstatus', 'filename' ] ,
            \           ],
            \   'right': [ [ 'lineinfo', 'percent' ],
            \              [ 'filetype'],[ 'resizemode', 'ibusmode', 'modified','readonly' ] ]
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers'
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel'
            \ },
            \ 'component':{
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFilename',
            \   'filetype': 'LightlineFiletype',
            \   'ibusmode':'IbusMode',
            \   'resizemode':'LightlineResizeMode',
            \   'gitbranch': 'fugitive#head',
            \   'lspstatus': 'LightLineLspStatus'
            \ },
            \ }

let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
" let g:lightline.separator = { 'left': "", 'right': "" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.tabline_subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
" let g:lightline.tabline_separator = { 'left': "", 'right': "" }

if get(g:, 'wind_use_buffline', 0) == 1
    let g:lightline.tabline = {
                \ 'left': [ [  'buffers' ] ],
                \ 'right': []
                \ }
else
    let g:lightline.tabline = {
                \ 'left': [ [  'tabs' ] ],
                \ 'right': []
                \ }
endif
let g:lightline.tab = {
            \ 'active': [ 'tabnum', 'filename', 'modified' ],
            \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

if exists('g:wind_use_note')
    let g:lightline.active={'left':[],'right':[]}
endif

" }}}

if get(g:, 'wind_tmux_line', 0) == 1
    let g:tpipeline_tabline = 1
    let g:tpipeline_statusline = &tabline
end
