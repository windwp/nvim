local map = import('core.keymap')

map.nnoremap({'gx', "<cmd>lua import('core.nav').open_or_search(0)<cr>"})
map.vnoremap({'gx', "<esc>:call v:lua.import('core.nav').open_or_search(1)<cr>"})
map.nnoremap({'gb', "<cmd>lua import('core.nav').go_back()<cr>"})
map.nnoremap({'gk', "<cmd>lua import('core.nav').goto_buff_or_qf('previous')<cr>"})
map.nnoremap({'gj', "<cmd>lua import('core.nav').goto_buff_or_qf('next')<cr>"})
map.xnoremap({'P', "v:lua.Wind.trim_new_line_clipboard()", expr = true})

map.nnoremap({'<a-v>', "<cmd>lua Wind.load_plug('copyq').show()<cr>"})
map.inoremap({'<a-v>', "<esc>:lua Wind.load_plug('copyq').show()<cr>"})
map.nnoremap({'<leader>ul', "<cmd>lua require('nvim-autospace').format()<cr>"})

map.nnoremap({'<c-t>f', '<cmd>lua require("spectre").open({is_insert_mode=true})<cr>'})
map.vnoremap({'<leader>R', ":lua require('spectre').open_visual()<CR>"})
map.nnoremap({'<leader>R', "viw:lua require('spectre').open_visual()<CR>"})
map.nnoremap({'<leader>rp', "viw:lua require('spectre').open_file_search()<cr>"})
map.nnoremap({'<leader>;v', '<cmd>lua require("spectre").open({cwd="~/.config/nvim"})<cr>'})

map.nnoremap({'<a-h>', '<cmd>lua require("Navigator").left()<cr>'})
map.nnoremap({'<a-l>', '<cmd>lua require("Navigator").right()<cr>'})
map.nnoremap({'<a-j>', '<cmd>lua require("Navigator").down()<cr>'})
map.nnoremap({'<a-k>', '<cmd>lua require("Navigator").up()<cr>'})
