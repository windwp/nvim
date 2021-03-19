"Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

hi WhichTypeNormal  ctermfg=NONE ctermbg=blue guifg=NONE guibg=#424242 

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          String 
highlight default link WhichKeySeperator Statement
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

autocmd! FileType which_key
if has('nvim')
    autocmd  FileType which_key set winhighlight=Normal:WhichTypeNormal 
endif
" Hide status line
"
if get(g:,'wind_tmux_line',0) ==1
    autocmd  FileType which_key set noshowmode noruler
                \| autocmd BufLeave <buffer> set noshowmode ruler
else
    autocmd  FileType which_key set laststatus=0 noshowmode noruler
                \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
endif



" Single mappings
let g:which_key_map['.'] =  'get vim group syntax'
let g:which_key_map['a'] =  'code action'
let g:which_key_map['s'] =  'easymotion jump'
let g:which_key_map['F'] =  'format document'
let g:which_key_map['R'] =  'replace text project'
let g:which_key_map['x'] = 'Excute script'
let g:which_key_map['-'] = [ ':execute ":wincmd = | wincmd \|"' , 'maximum window'  ]
let g:which_key_map['='] = [ '<C-W>='                           , 'balance windows'       ]
let g:which_key_map['W'] = [ ':lcd %:p:h'                       , 'set working directory' ]
let g:which_key_map['f'] = [ ':call MyCodeFormat()'             , 'format selected'       ]
let g:which_key_map['h'] = [ '<C-W>s'                           , 'split below'           ]
let g:which_key_map['q'] = [ ':call wind#QfToggle()'            , 'quickfix toggle'       ]
let g:which_key_map['v'] = [ '<C-W>v'                           , 'split right'           ]
let g:which_key_map['z'] = [ ':setlocal spell! spell?'          , 'toggle spell'          ]

" Group mappings
" u is for utility
let g:which_key_map.u = {
        \ 'name' : '+utility'                  ,
        \ 'i' : 'toggle system keyboard'       ,
        \ 'k' : 'toggle vim keyboard'          ,
        \ 'd' : 'diff 2 panel '                ,
        \ 'l' : 'format line'                  ,
        \ 'f' : [':Vifm'                       , 'vifm '              ] ,
        \ 'u' : [':UndotreeShow'               , 'undotreeShow'       ] ,
        \ 'j' : [':CocCommand jest.singleTest' , 'run Jest'           ] ,
        \ 'w' : [':%s/\s\+$//e'                , 'trim whitespace'    ] ,
        \ 'm' : [':MyRedir messages'           , 'log meesage'        ] ,
        \ 'r' : [':call ToggleResizeMode()'    , 'toggle Resizemode'  ] ,
\ }


let g:which_key_map.r = {
        \ 'name' : '+replace'                  ,
        \ 'r' : 'simple replace'       ,
        \ 'w' : 'replace current word'          ,
\ }

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add %'                        , 'add current'              ] ,
      \ 'A' : [':Git add .'                        , 'add all'                  ] ,
      \ 'b' : [':Git blame'                        , 'blame'                    ] ,
      \ 'B' : [':GBrowse'                          , 'browse'                   ] ,
      \ 'c' : [':Conflicted'                       , 'Conflicted'               ] ,
      \ 'C' : [':GitNextConflict'                  , 'Next Conflicted'          ] ,
      \ 'd' : [':Gvdiffsplit'                      , 'diff'                     ] ,
      \ 'D' : [':Gdiffsplit'                       , 'diff split'               ] ,
      \ 'g' : [':GGrep'                            , 'git grep'                 ] ,
      \ 's' : [':Gstatus'                          , 'status'                   ] ,
      \ 'm' : [':GitMessenger'                     , 'show current line commit' ] ,
      \ 'h' : [':GitGutterLineHighlightsToggle'    , 'highlight hunks'          ] ,
      \ 'H' : ['<Plug>(GitGutterPreviewHunk)'      , 'preview hunk'             ] ,
      \ 'j' : ['<Plug>(GitGutterNextHunk)'         , 'next hunk'                ] ,
      \ 'k' : ['<Plug>(GitGutterPrevHunk)'         , 'prev hunk'                ] ,
      \ 'l' : [':0Glog'                            , 'git log current file'     ] ,
      \ 'e' : [':Gedit'                            , 'edit file from git log'   ] ,
      \ 'L' : [':Glog'                             , 'git log project'          ] ,
      \ 'p' : [':AsyncRun git push'                , 'push'                     ] ,
      \ 'P' : [':Git pull'                         , 'pull'                     ] ,
      \ 'r' : [':GRemove'                          , 'remove'                   ] ,
      \ 'S' : ['<Plug>(GitGutterStageHunk)'        , 'stage hunk'               ] ,
      \ 't' : [':GitGutterSignsToggle'             , 'toggle signs'             ] ,
      \ 'u' : ['<Plug>(GitGutterUndoHunk)'         , 'undo hunk'                ] ,
      \ 'v' : [':GV'                               , 'view commits'             ] ,
      \ 'V' : [':GV!'                              , 'view buffer commits'      ] ,
      \ }


let g:which_key_map.d = {
      \ 'name' : '+diff' ,
      \ 'h' : 'Diff with head version' ,
      \ 'p' : 'Diff with previous version' ,
      \ '1' : 'Diff 2 version from register [1]' ,
      \ 'o' : 'Conflict get our version' ,
      \ 't' : 'Conflict get their verion' ,
      \ 'b' : 'Conflict diff bold version' ,
      \}

" t is for terminal
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=popup --height=6'        , 'terminal' ] ,
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'      ] ,
      \ 'g' : [':FloatermNew lazygit'                           , 'git'      ] ,
      \ 'd' : [':FloatermNew lazydocker'                        , 'docker'   ] ,
      \ 'n' : [':FloatermNew node'                              , 'node'     ] ,
      \ 'N' : [':FloatermNew fm'                                , 'fm'       ] ,
      \ 't' : [':FloatermToggle'                                , 'toggle'   ] ,
      \ }


let g:which_key_map.j = {
      \ 'name' : '+jump' ,
      \ 'c' : [':call v:lua.Wind.load_plug("telescope").picker_current_folder()'            , 'picker file current folder'      ] ,
      \ 'v' : [':call v:lua.Wind.load_plug("telescope").file_picker({"cwd":"~/.config/nvim"})' , 'picker file in nvim config'      ] ,
      \ 'd' : [':call v:lua.Wind.load_plug("telescope").git_picker({"cwd":"~/dotfiles"})'      , 'picker file in dotfiles'      ]    ,
      \ 'm' : [':call v:lua.require("telescope").extensions.media_files.media_files()'              , 'picker  media file '      ]        ,
      \ 'g' : [':call v:lua.require("telescope/builtin").git_files()'                             , 'picker git'      ]                 ,
      \ 'n' : [':bn'                             , 'picker git'      ]                 ,
      \ 'p' : [':bp'                             , 'picker git'      ]                 ,
      \ }

let g:which_key_map[';'] = {
      \ 'name' : '+jump' ,
      \ 'd' : [':call v:lua.Wind.load_plug("telescope").ag_find_folder({"cwd":"~/dotfiles"})'      , 'picker file in dotfiles'      ]    ,
      \ }
" e is for fast edit
let g:which_key_map.e = {
      \ 'name' : '+edit_file' ,
      \ 'v' : [':tabnew ~/.config/nvim/lua/wind/plugins.lua | tcd ~/.config/nvim/'           , 'edit vim'       ] ,
      \ 'p' : [':call v:lua.require("nvim-projectconfig").edit_project_config()'    , 'edit project current folder'      ] ,
      \ 'c' : [':TabCustomOpen ~/.config/alacritty/alacritty.yml' , 'edit alacritty' ] ,
      \ 'n' : [':TabCustomOpen ~/work/md-note/index.md'           , 'edit note'      ] ,
      \ 'i' : [':TabCustomOpen ~/.config/regolith/i3/config'      , 'edit i3'        ] ,
      \ 'd' : [':TabCustomOpen ~/dotfiles/install/env.sh'         , 'edit dotfiles'  ] ,
      \ 'a' : 'Algin' ,
      \ 't' : 'table format' ,
      \ }

call which_key#register('<Space>', "g:which_key_map")



