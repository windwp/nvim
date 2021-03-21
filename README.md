## NEOVIM Config - Windvim

![demo](https://i.imgur.com/T8Sj1uS.png)

## Install
``` bash
./scripts/setup.sh

```
## Plugins

* [Paq](https://github.com/savq/paq-nvim)
* [Telescope](https://github.com/nvim-telescope/telescope.nvim)


## Plug

I use [Paq](https://github.com/savq/paq-nvim) and create a function Plug so I can use it like (vim-plug)
with Plug you can customize it to load config from lua or vim

``` lua

Plug {'neoclide/jsonc.vim'   , ft = 'json'}
Plug {'junegunn/gv.vim'      , on = 'GV'}

-- load lspsaga in folder /lua/wind/plug/lspsaga.lua
Plug {'glepnir/lspsaga.nvim' , branch = 'main'      , config = "lspsaga"}

-- load vim file in /plug/fern.vim
Plug {'lambdalisue/fern.vim' , config = 'fern.vim'}

```
Plug can lazy load with filetype(ft) and command(on).

I don't need to rename Plug to `pag` or `use` :)

All plugins config is store on folder /plug/.vim and /lua/wind/plug/.lua

If you are develop or test config you can run command `:WindDev`.
It will enable dev mode and all import module is auto reload.


## LSP

by default it load some lsp server lua, jsonls, yamls.

Another lsp can load when you open project and run script with my plugin
[project-config](https://github.com/windwp/nvim-projectconfig)

``` lua

Wind.load_lsp {'tsserver', 'efm'}
Wind.load_lsp 'gopls'

Wind.load_theme 'gruvbox'

```
## Thanks

* [habamax](https://github.com/habamax/)
* [tjdevries](https://github.com/tjdevries)
* [glepnir](https://github.com/glepnir)

