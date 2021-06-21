vim.opt.sw=4
-- it help use gf to move to config on plugins
vim.bo.includeexpr="printf('plug/%s.lua',v:fname)"
vim.bo.suffixesadd=".lua"

-- it help to press K to go help
vim.bo.keywordprg=":help"

-- mapping in vim is so ez :
vim.cmd[[
inoremap <buffer> ! ~
]]
