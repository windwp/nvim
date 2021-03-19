" https://github.com/tpope/vim-rhubarb/blob/master/autoload/rhubarb.vim#L28-L33
" replace it because netrw
function! s:gh_home_url(url) abort
  let domain_pattern = 'github\.com'
  let domains = get(g:, 'github_enterprise_urls', get(g:, 'fugitive_github_domains', []))
  for domain in domains
    let domain_pattern .= '\|' . escape(split(substitute(domain, '/$', '', ''), '://')[-2], '.')
  endfor
  let base = matchstr(a:url, '^\%(https\=://\%([^@/:]*@\)\=\|git://\|git@\|ssh://git@\|org-\d\+@\|ssh://org-\d\+@\)\=\zs\('.domain_pattern.'\)[/:].\{-\}\ze\%(\.git\)\=/\=$')
  if index(domains, 'http://' . matchstr(base, '^[^:/]*')) >= -1
    return 'http://' . tr(base, ':', '/')
  elseif !empty(base)
    return 'https://' . tr(base, ':', '/')
  else
    return ''
  endif
endfunction

function! WindGitOpen(...)
  let l:remote = fugitive#repo().config('remote.origin.url')
  let l:branch = fugitive#head()
  let l:url = s:gh_home_url(l:remote)
  let l:url = printf("%s/blob/%s/%s", l:url, l:branch, a:1['path'])
  if a:1['line1'] >1 && a:1['line2']>1 
    let l:url = printf("%s#L%s-L%s",l:url ,a:1['line1'],a:1['line2'])
  endif
  return shellescape(l:url)
endfunction

let g:fugitive_browse_handlers = [ function ('WindGitOpen') ]
function! WindOpen(...)
  call system(wind#open() . ' ' . a:1) 
endfunction
command! -nargs=* Browse call WindOpen(<f-args>)

