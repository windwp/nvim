-- vim: foldmethod=marker  sw=2 formatoptions-=o foldlevel=0

if vim.g.wind_use_plugin == 0 then return end

local plug = import('core.plug')
local Plug = plug.Plug


-- some config for plugin if it use with packadd
Wind.load_plug('_start')

-- Basic: {{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'numToStr/Navigator.nvim'
Plug {'windwp/windline.nvim', config = 'windline'}
Plug {'windwp/nvim-projectconfig' , config = 'project-config'}
---}}}


-- Git: {{{
Plug {'tpope/vim-fugitive'      , config = 'gitopen.vim'}
Plug {'rhysd/git-messenger.vim' , on = 'GitMessenger'}
Plug {'junegunn/gv.vim'         , on = 'GV' ,}
Plug 'rhysd/conflict-marker.vim'
Plug {'lewis6991/gitsigns.nvim', config = 'gitsigns'}
-- }}}

-- Lsp: {{{

Plug {'neovim/nvim-lspconfig', config = 'lsp.setup'}

Plug {'hrsh7th/nvim-compe', config = 'compe'}
Plug {'hrsh7th/vim-vsnip', event = "InsertEnter"}
Plug {'hrsh7th/vim-vsnip-integ', event = "InsertEnter"}
Plug {'mhartington/formatter.nvim', config = 'formatter' , key = "<leader>f"}

-- }}}
--
-- Telescope:{{{
Plug {'nvim-telescope/telescope.nvim', config = 'telescope'}
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-github.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
-- }}}

-- Treesitter: {{{
local use_ts = vim.g.wind_use_treesitter == 1

Plug {'nvim-treesitter/nvim-treesitter', config = 'treesitter', cond = use_ts}
Plug {'nvim-treesitter/playground', on = 'TSPlaygroundToggle', cond = use_ts}
Plug {'windwp/nvim-ts-autotag', cond = use_ts}

-- }}}

-- Theme: {{{

Plug 'windwp/wind-colors'
Plug {'morhetz/gruvbox', opt = false}
-- }}}

-- File: {{{
local use_icon = vim.g.wind_use_icon == 1
Plug {'vifm/vifm.vim', on = 'Vifm', }
Plug {'lambdalisue/fern.vim', config = 'fern.vim', key = {"<c-b>", "F"}}
Plug {'windwp/fern-renderer-nerdfont.vim', branch = 'devicon', cond = use_icon, manual = true }
Plug {'lambdalisue/glyph-palette.vim', cond = use_icon, manual = true}

-- Plug {'tamago324/lir.nvim', config = 'lir'}
Plug {'kyazdani42/nvim-web-devicons', config = 'web-devicons', cond = use_icon}
-- }}}


-- statusline {{{

Plug {'vimpostor/vim-tpipeline', cond = vim.g.wind_tmux_line == 1}
--}}}


-- Filetype {{{
Plug {'neoclide/jsonc.vim'           , ft = 'json'}
Plug {'plasticboy/vim-markdown'      , ft = 'markdown'}
Plug {'leafOfTree/vim-svelte-plugin' , ft = 'svelte'}
Plug {'fatih/vim-go'                 , ft = 'go'}
-- }}}

-- Others: {{{

Plug {'windwp/nvim-autopairs', config = 'autopairs', event = "InsertEnter"}
Plug {'windwp/nvim-autospace', event = "BufRead"}
Plug {'windwp/nvim-spectre', config = 'spectre'}
Plug {'ojroques/vim-oscyank', config = 'oscyank', on = "OSCYank"}
Plug {'mizlan/iswap.nvim', config = 'iswap', on = 'ISwapWith'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

Plug 'norcalli/nvim-colorizer.lua'
Plug {'AndrewRadev/switch.vim', on = 'Switch'} -- toggle between true or false
Plug {'voldikss/vim-floaterm', before = 'vim-floaterm.vim', on = "FloatermToggle"}
Plug {'mg979/vim-visual-multi', before = 'vim-visual-multi.vim', key = "<c-d>"}
Plug {'skywind3000/asyncrun.vim', on="AsyncRun" }
Plug {'pwntester/octo.nvim' , config = 'octo' , on = "Octo"}
Plug {'folke/lsp-trouble.nvim', config = 'lsp-trouble' , on = 'LspTroubleOpen'}
Plug {'sindrets/diffview.nvim', on = 'DiffviewOpen'}
Plug {'folke/which-key.nvim', config = 'which-key'}

Plug 'godlygeek/tabular'               --" Markdown Tables
Plug {'mbbill/undotree', on="UndotreeShow"}                 --" undo tree
Plug 'djoshea/vim-autoread'            --" auto update after save outside vim
Plug {'machakann/vim-sandwich', event = "BufRead"}
Plug 'obxhdx/vim-auto-highlight'       --" highlight current world

Plug {'lukas-reineke/indent-blankline.nvim',  cond = vim.g.wind_use_indent == 1, config = "indent-blankline"}
-- better match pairs and it can disable on insert mode
Plug {'andymass/vim-matchup', config = 'matchup'}
Plug {'hrsh7th/vim-eft', config = 'eft'} -- hight light character on ft key
-- Plug {'dstein64/vim-startuptime' }

-- }}}


plug.load_config()

Wind.load_plug('_end')
