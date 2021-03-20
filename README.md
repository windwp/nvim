## NEOVIM Config - Windvim

![demo](https://i.imgur.com/APKMx0f.png)

## Install
``` bash
./scripts/setup.sh

```
## Plugins

* [Paq](https://github.com/savq/paq-nvim)
* [Telescope](https://github.com/nvim-telescope/telescope.nvim)


## LSP

default It load some lsp server lua,jsonls ,yamls.

Another lsp can load when you open project and run script with my plugin
[project-config](https://github.com/windwp/nvim-projectconfig)

``` lua

Wind.load_lsp {'tsserver','efm'}
Wind.load_lsp 'gopls'

Wind.load_theme 'gruvbox'

```
## Plug

I use paq and create a function Plug so I can use it like (vim-plug)
with Plug you can customize it to load config from lua or vim

``` lua

Plug {'neoclide/jsonc.vim'   , ft = 'json'}
Plug {'junegunn/gv.vim'      , on = 'GV'}

-- load lspsaga in folder /lua/wind/lsp/plug/lspsaga.lua
Plug {'glepnir/lspsaga.nvim' , branch = 'main'      , config = "lspsaga"}

-- load vim file in /plug/fern.vim
Plug {'lambdalisue/fern.vim' , config = 'fern.vim'}

```
Plug can lazy load with filetype(ft) and command(on).
and I don't need to rename Plug to pag or use :)


## Thanks

[habamax](https://github.com/habamax/.vim/)
[tjdevries](https://github.com/tjdevries)
