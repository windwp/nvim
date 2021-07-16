vim.g.oscyank_term = 'tmux'
vim.cmd[[
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif
]]
