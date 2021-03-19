
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'
local nvim_lsp = require('lspconfig')

local server_name = 'tailwindls'

configs[server_name] = {
  default_config = {
    cmd = {server_name};
    filetypes = {'html','svelte','typescriptreact'};
    root_dir = util.root_pattern("package.json", ".git");
  };
  docs = {
    description = [[ ]];
    default_config = {
        root_dir = [[root_pattern("package.json", ".git")]];
    };
  }
}


import('plug/lsp/lsp').lsp_setup(nvim_lsp.tailwindls)

