function! wind#open() abort
    " Linux/BSD
    if executable('xdg-open')
        return 'xdg-open'
    endif
    " MacOS
    if executable('open')
        return 'open'
    endif
    " Windows
    return 'explorer'
endfunction

"check current cursor is end of line"
function! wind#IsEndOfLine() abort
    let l:allowWordReg = '[a-zA-Z0-9]'
    let l:line      = getline('.')
    let l:pos       = getcurpos()
    let l:charIndex = l:pos[2]
    let l:char=""
    while l:charIndex <len(l:line)
        let l:charIndex = l:charIndex + 1
        let l:char=l:line[l:charIndex]
        if match(l:char ,l:allowWordReg) == -1
            return 0
        endif
    endwhile
    return 1
endfunction

function! wind#MoveLine(dir)  abort
    let l:count = a:dir
    if v:prevcount >0
      let l:count = l:count * v:prevcount
    endif
    let pos = getcurpos()[1]
    execute "normal! gv"
    let start = getpos("'<")[1]
    let end = getpos("'>")[1]
    if l:count == 1
        let resultline = end + 1
    elseif l:count ==-1
        let resultline = start - 2
    elseif l:count>0
        let resultline = pos + l:count
    else
        let resultline = pos + l:count-1
    endif
    try
        execute "normal! :m ".resultline."\<CR>gv"
    catch
    endtry
endfunction


function! wind#QfClose() abort
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
          cclose
          lclose
          return 1
        endif
    endfor
    return 0
endfunction

" save and quit use it with 'set confim' setting
" auto close quick fix first
" lol neovim need to make it default just kidding :)
function! wind#SuperQuit() abort
    if match(expand("%"), "^fugitive\:\/\/")>-1 || match(expand("%"), "COMMIT_EDITMSG$")>-1
        call wind#QfClose()
        execute ":bd"
        return
    endif
    if wind#QfClose() == 1
        return
    end
    let l:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    " check to vim command mode
    if &buftype == 'nofile' || &buftype =='help'
        if &filetype =='vim'
            execute ":close"
        else
            execute ":bd"
        endif
        return
    end
    if &buftype == 'terminal' || &filetype =~? '^fern'
        execute ":q"
        return
    endif

    let l:bufnr = bufnr('%')
    " neu hien thi o 1 buffer khac thi close
    let l:windows = win_findbuf(l:bufnr)
    try
        if len(l:windows)>1
            close
            return
        end
    catch
        return
    endtry
    " check is the last buffer open then close vim
    let l:bufCount = 0
    for buf in getbufinfo({'buflisted':1})
        if get(g:, 'wind_auto_close', 0) == 1
            if len(buf.name)>2 && buf.changed == 1
                let l:bufCount = l:bufCount + 1
            endif
        else
            if len(buf.name)>2 || buf.changed == 1
                let l:bufCount = l:bufCount + 1
            endif
        endif
    endfor
    if l:bufCount >= 1
        execute ":bd"
    else
        execute ":q"
    endif
endfunction

" Toggle quickfix window.
function! wind#QfToggle()
    if wind#QfClose() == 1| return| end
    copen
endfunction


function! wind#GetVisualSelect() abort
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    let query=join(lines,"\n")
    return query
endfunction

let g:grepper={}
" let g:grepper.tools=["rg"]
let g:qf_replace_query = ''
" press first time and update query to match
" press second time to excute check qf is open
" press dd in quick fix to remove that selection item
function! wind#ReplaceViualSelect() abort
    " check qf is open
    let l:is_qf_open=0
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            let l:is_qf_open=1
            break
        endif
    endfor
    if l:is_qf_open==0
        let query = wind#GetVisualSelect()
        execute "GrepperRg \"".query."\""
        let g:qf_replace_query = substitute(query,'/','\\\/',"g")
        echom g:qf_replace_query
    endif
    if l:is_qf_open==1 && len(g:qf_replace_query)>0
        let replace = input("Replace Text: ")
        if len(replace)>0
            execute "cfdo %s/".g:qf_replace_query."/".replace."/g \| update"
        endif
        let g:qf_replace_query=''
    endif
endfunction


augroup resCur
    autocmd!
    au BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          \ |   exe "normal! g`\""
          \ |   exe "normal! zz"
          \ | endif
augroup END
