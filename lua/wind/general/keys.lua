local map = import('core.keymap')
local n, i, v, x =
map.nnoremap, map.inoremap, map.vnoremap, map.xnoremap


n({'<leader>ev',':tabnew ~/.config/nvim/init.lua | tcd ~/.config/nvim/<cr>'           , 'edit vim'       } )
n({'<leader>ep','<cmd>lua require("nvim-projectconfig").edit_project_config()<cr>'    , 'edit project current folder'      } )
n({'<leader>ec',':TabCustomOpen ~/.config/alacritty/alacritty.yml<cr>' , 'edit alacritty' } )
n({'<leader>en',':TabCustomOpen ~/work/md-note/index.md<cr>'           , 'edit note'      } )
n({'<leader>ei',':TabCustomOpen ~/.config/regolith/i3/config<cr>'      , 'edit i3'        } )
n({'<leader>ed',':TabCustomOpen ~/dotfiles/install/env.sh<cr>'         , 'edit dotfiles'  } )
n({'<leader>ew',':TabCustomOpen ~/.local/share/nvim/site/pack/paqs/start/wind-colors/lua/wind-colors.lua<cr>' , 'edit dotfiles'  } )

n({'<leader>h', '<C-w>s', 'split horizontal'})
n({'<leader>q', ':call wind#QfToggle()<cr>', 'toggle quick fix'})
n({'<leader>v', '<C-w>v', 'split vertical'})
n({'<leader>z', ':setlocal spell! spell?<cr>', 'toggle spell'})

n({'<leader>s', ':HopChar2<cr>', 'jump to word'})

n({'<leader>u9', '<cmd>lua import("plug.windline.animation").play()<cr>', 'run animation'})
n({'<leader>um', ':MyRedir messages<cr>', 'log output message'})
n({'<leader>ur', ':call ToggleResizeMode()<cr>', 'toggle resize mode'})
n({'<leader>ud', ":windo diffthis<cr>",  "set test command"})

n({'gx', "<cmd>lua import('core.nav').open_or_search(0)<cr>", 'open or search '})
v({'gx', "<esc>:call v:lua.import('core.nav').open_or_search(1)<cr>",'open_or_search'})
n({'gb', "<cmd>lua import('core.nav').go_back()<cr>", 'go back'})
n({'gk', "<cmd>lua import('core.nav').goto_buff_or_qf('previous')<cr>","goto previous"})
n({'gj', "<cmd>lua import('core.nav').goto_buff_or_qf('next')<cr>", "goto next"})


n({'<a-v>', "<cmd>lua Wind.load_plug('copyq').show()<cr>"})
i({'<a-v>', "<esc>:lua Wind.load_plug('copyq').show()<cr>"})
n({'<leader>ul', "<cmd>lua require('nvim-autospace').format()<cr>", desc = "format current line"})

n({'<c-t>f', '<cmd>lua require("spectre").open({is_insert_mode=true})<cr>'})
n({'<leader>rp', "viw:lua require('spectre').open_file_search()<cr>","search current file"})
v({'<leader>R', ":lua require('spectre').open_visual()<CR>", "open spectre"})
n({'<leader>R', "viw:lua require('spectre').open_visual()<CR>", "open spectre"})
n({'<leader>lt', ":LspTroubleOpen<cr>", "lsp open trouble"})
n({'<leader>;v', '<cmd>lua require("spectre").open({cwd="~/.config/nvim"})<cr>', "find nvim config"})

n({'<a-h>', '<cmd>lua require("Navigator").left()<cr>'})
n({'<a-l>', '<cmd>lua require("Navigator").right()<cr>'})
n({'<a-j>', '<cmd>lua require("Navigator").down()<cr>'})
n({'<a-k>', '<cmd>lua require("Navigator").up()<cr>'})
