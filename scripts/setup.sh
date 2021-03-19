#!/bin/bash
git clone https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/paq-nvim
cp ./local.sample.lua ./local.lua

nvim -c ":PaqInstall"
