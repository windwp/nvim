setlocal path=.,src
setlocal suffixesadd=.js,.jsx,.ts,.tsx
setlocal foldmethod=syntax
" set formatoptions-=ro
" Source:
" https://damien.pobel.fr/post/configure-neovim-vim-gf-javascript-import/
" TODO more robust solution (detect root directory, specific to javascript,
" ...)
function! s:find_node_modules_filename(fname) abort
    let nodeModules = "./node_modules/"
    let packageJsonPath = nodeModules . a:fname . "/package.json"
    if filereadable(packageJsonPath)
        return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
    else
        let checkfname="@".a:fname
        let packageJsonPath = nodeModules . checkfname . "/package.json"
        if filereadable(packageJsonPath)
            return nodeModules . checkfname. "/" . json_decode(join(readfile(packageJsonPath))).main
        elseif filereadable( nodeModules . a:fname )
            return nodeModules . a:fname
        elseif filereadable(nodeModules ."@". a:fname)
            return nodeModules ."@" . a:fname
        endif
    endif
endfunction

" Used in 'includeexpr' to resolve file names
function! Js_includeexpr(filename) abort
    let fname = s:find_node_modules_filename(a:filename)
    if filereadable(fname)
        return fname
    endif
endfunction

setlocal includeexpr=Js_includeexpr(v:fname)

" disable match parent in insert mode for better cursor on pairs bracket
" autocmd InsertEnter <buffer> :NoMatchParen
" autocmd InsertLeave <buffer> :DoMatchParen
