local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'
local nvim_lsp = require('lspconfig')

local server_name = 'jsboosterls'
local bin_name = 'jsboosterls'

local installer = util.npm_installer {
  server_name = server_name;
  packages = { "@angular/language-server" };
  binaries = { bin_name };
}

configs[server_name] = {
  default_config = {
    cmd = {'jsboosterls.sh'};
    filetypes = {'javacript','typescript','typescriptreact'};
    root_dir = util.root_pattern("package.json", ".git");
  };
  docs = {
    description = [[ ]];
    default_config = {
        root_dir = [[root_pattern("package.json", ".git")]];
    };
  }
}

configs[server_name].install = installer.install
configs[server_name].install_info = installer.info

import('wind/lsp/lsp').lsp_setup(nvim_lsp.jsboosterls)

