
-- vim: foldmethod=marker  sw=2 formatoptions-=o foldlevel=0

if vim.g.wind_use_plugin == 0 then return end

local plug = import('core.plug')
local Plug = plug.Plug


-- some config for plugin if it use with packadd
Wind.load_plug('_start')



-- Git: {{{
Plug 'airblade/vim-gitgutter'
Plug {'tpope/vim-fugitive'      , config = 'gitopen.vim'}
Plug {'rhysd/git-messenger.vim' , on = 'GitMessenger'}
Plug {'junegunn/gv.vim'         , on = 'GV' ,}
Plug 'rhysd/conflict-marker.vim'

-- }}}

-- Basic: {{{
Plug 'editorconfig/editorconfig-vim'
Plug 'mhinz/vim-grepper'               --Handle multi-file find and replace. display all grep result to a list in vim

Plug 'godlygeek/tabular'               --" Markdown Tables
Plug {'liuchengxu/vim-which-key'  , config = 'which-key.vim'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'mbbill/undotree'                 --" undo tree
Plug 'djoshea/vim-autoread'            --" auto update after save outside vim
Plug 'tpope/vim-commentary'
-- Plug 'tpope/vim-surround'
Plug {'machakann/vim-sandwich',}
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-expand-region'
Plug 'obxhdx/vim-auto-highlight'       --" highlight current world

Plug {'lukas-reineke/indent-blankline.nvim', branch = 'lua', cond = vim.g.wind_use_indent == 1, config = "indent-blankline"}

-- Find and replace
Plug {'brooth/far.vim', config = 'far.vim', on='Far'}
-- better match pairs and it can disable on insert mode
Plug {'andymass/vim-matchup', config = 'matchup'}
-- hight light character on ft key
Plug {'hrsh7th/vim-eft', config = 'eft'}

---}}}

-- Lsp: {{{

Plug {'neovim/nvim-lspconfig', config = 'lsp.setup'}

Plug {'hrsh7th/nvim-compe', config = 'compe'}
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug {'mhartington/formatter.nvim' , config = 'formatter'}
Plug {'glepnir/lspsaga.nvim' , branch = 'main' , config = "lspsaga"}

-- }}}
--
-- Telescope:{{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
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
Plug {'vifm/vifm.vim' ,  on = 'Vifm'}
Plug {'lambdalisue/fern.vim' , config = 'fern.vim'}

local use_icon = vim.g.wind_use_icon == 1

Plug {'kyazdani42/nvim-web-devicons'      , config = 'web-devicons' , cond = use_icon}
Plug {'windwp/fern-renderer-nerdfont.vim' , branch = 'devicon'      , cond = use_icon}
Plug {'lambdalisue/glyph-palette.vim'     , cond = use_icon}
-- }}}


-- Lightline {{{
Plug {'itchyny/lightline.vim', config = 'lightline.vim'}
Plug {'mengelbrecht/lightline-bufferline', config = 'light-bufferline', cond = vim.g.wind_use_buffline == 1}
Plug {'vimpostor/vim-tpipeline', cond = vim.g.wind_tmux_line == 1}
--}}}

-- Filetype {{{
Plug {'neoclide/jsonc.vim'           , ft = 'json'}
Plug {'plasticboy/vim-markdown'      , ft = 'markdown'}
Plug {'leafOfTree/vim-svelte-plugin' , ft = 'svelte'}
Plug {'fatih/vim-go'                 , ft = 'go'}
-- }}}

-- Others: {{{
Plug 'phaazon/hop.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-autospace'
Plug {'windwp/nvim-projectconfig' , config = 'project-config'}
Plug 'norcalli/nvim-colorizer.lua'

-- toggle between true or false
Plug 'AndrewRadev/switch.vim'
Plug {'voldikss/vim-floaterm', before = 'vim-floaterm.vim'}
Plug 'windwp/vim-floaterm-repl'
Plug {'mg979/vim-visual-multi', before = 'vim-visual-multi.vim'}
Plug {'skywind3000/asyncrun.vim' }
Plug {'pwntester/octo.nvim' , config = 'octo' , on = "Octo"}
-- Plug {'dstein64/vim-startuptime' }

-- }}}


plug.load_config()

Wind.load_plug('_end')
