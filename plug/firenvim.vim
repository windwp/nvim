    " firenvim can't automatic load mardown syntax  ??
    source $HOME/.config/nvim/ftplugin/markdown.vim
    let g:firenvim_config = { 
        \ 'globalSettings': {
            \ 'alt': 'all',
        \  },
        \ 'localSettings': {
            \ '.*': {
                \ 'cmdline': 'neovim',
                \ 'content': 'text',
                \ 'priority': 0,
                \ 'selector': 'textarea',
                \ 'takeover': 'always',
            \ },
        \ }
    \ }
    let fc = g:firenvim_config['localSettings']
    let fc['https?://facebook.com'] = { 'takeover': 'never', 'priority': '1' }
    set laststatus=0
    au BufEnter *.txt set filetype=markdown | set syntax=markdown
    set showtabline=0
    set wrap
    set lines=20
    " let g:wind_use_bg = 1
    " let g:wind_theme = "gruvbox"
    autocmd BufReadPost *.txt call FixVimMarkdown()
    autocmd InsertLeave *.txt call FixMdTable()

    function! s:IsFirenvimActive(event) abort
    if !exists('*nvim_get_chan_info')
        return 0
    endif
    let l:ui = nvim_get_chan_info(a:event.chan)
    return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
        \ l:ui.client.name =~? 'Firenvim'
    endfunction
    function! OnUIEnter(event) abort
        if s:IsFirenvimActive(a:event)
            set lines=20
        endif
    endfunction
    autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
