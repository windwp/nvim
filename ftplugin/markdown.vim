
if exists("b:md_current_syntax") | finish | endif
let b:md_current_syntax=1
let g:my_list_task_progress= ['TODO', 'FIXME', 'PROGRESS',  'CANCELED', 'DONE' ]
setlocal cole=1

" toggle to do in markdown
function! MyTodoToggle()
    let l:line=getline('.')
    if match(l:line ,'\[ \]')!=-1
        execute 's/\[ \]/\[x\]/'
        execute "\'\'"
    elseif match(l:line,'\[x\]')!=-1
        execute 's/\[x\]/\[ \]/'
        execute "\'\'"
    elseif match(l:line,'^ *\* [^\[]')!=-1
        execute 's/^\( *\)\* \([^\[]\)/\1* [ ] \2/'
        execute "\'\'"
    endif
endfunction

function! MyTableNewRow()
    let l:line=getline('.')
    if match(l:line,'^\s\=|')!=-1
      let l:text=substitute(l:line,'[^|]',' ','g')
      let l:text=substitute(l:text,' ','','g')
      let l:text=substitute(l:text,'|','|  ','g')
      normal o
      execute "normal! i".l:text
      call feedkeys("0lli") 
    endif
endfunction




function! FixVimMarkdown() abort

  nnoremap <buffer> <silent> go :Toc<CR>
  " nnoremap <buffer> <silent> gtt :call MyListTaskProgress()<CR>
  nnoremap <buffer> <silent> gtc :call MyTodoToggle()<CR>
  nnoremap <buffer> <silent> <leader>t :call MyTodoToggle()<CR>
  nnoremap <buffer> <silent> gtn :call MyTableNewRow()<CR>
  nnoremap <buffer> <silent> gtr :Toc<CR>
  nnoremap <buffer> gtp :call MyPandocPdf() <CR>


  if exists("g:wind_use_note")
      hi htmlH1 ctermfg=88   guifg=#9d0006 ctermbg=None gui=bold  term=bold cterm=bold
      hi htmlH2 ctermfg=106  guifg=#fb4934 ctermbg=None gui=bold
      hi htmlH3 ctermfg=166  guifg=#98971a ctermbg=None gui=bold
      hi htmlH4 ctermfg=109  guifg=#458588 ctermbg=None gui=bold
      hi htmlH5 ctermfg=124  guifg=#b16286 ctermbg=None gui=bold
      hi mkdCodeStart ctermfg=239 guifg=#9E9E9E ctermbg=None gui=bold
      hi mkdCodeEnd ctermfg=239 guifg=#9E9E9E ctermbg=None gui=bold
      hi mkdCode ctermfg=88  guifg=#427b58 ctermbg=None cterm=bold
  endif

  syn match mkdTodo /\vTODO/ containedin=mkdListItemLine,mkdItalic 
  syn match mkdFixMe /\vFIXME/ containedin=mkdListItemLine,mkdItalic 
  syn match mkdProgress /\vPROGRESS/ containedin=mkdListItemLine,mkdItalic 
  syn match mkdCanceled /\vCANCELED/ containedin=mkdListItemLine,mkdItalic 
  syn match mkdDone /\vDONE/ containedin=mkdListItemLine,mkdItalic 

  hi mkdTodo     ctermfg=106  guifg=#fe8019  gui=bold
  hi mkdFixMe    ctermfg=106  guifg=#cc241d  gui=bold
  hi mkdProgress ctermfg=106  guifg=#83a598  gui=bold
  hi mkdCancled  ctermfg=106  guifg=#fabd2f  gui=bold
  hi mkdDone     ctermfg=106  guifg=#00C853  gui=bold

  syntax match mkdCheckBox /\[\ \]/ conceal cchar= containedin=mkdListItemLine,mkdItalic
  syntax match mkdCheckBox /\[x\]/ conceal cchar= containedin=mkdListItemLine,mkdItalic
  " Plugin indentline will override it
  hi Conceal guifg=#427b58 ctermfg=88 
  hi htmlItalic gui=italic

  setlocal shiftwidth=2
  setlocal formatoptions=tron
  " it will allow auto insert *+- in comment after newline
  setlocal comments=b:*,b:+,b:-

endfunction

function! MyPandocPdf()
  execute "!pandoc ".  expand("%:p") ." -o " .expand("%:p:s?\.md$?\.pdf?")." --from markdown --template eisvogel --listings"
endfunction

" fix markdown table algin
function! FixMdTable()abort
    let l:line=getline('.')
    if match(l:line ,'^|')!=-1
      execute ":TableFormat"
    endif
endfunction

