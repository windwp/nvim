
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'
local nvim_lsp = require('lspconfig')

local server_cmd = 'lsp_eslint'
-- local server_cmd = 'node /home/trieu/.vscode/extensions/dbaeumer.vscode-eslint-2.1.14/server/out/eslintServer.js -f unix --stdin --stdin-filename'
local server_name = "eslint"

configs[server_name] = {
  default_config = {
    cmd = vim.fn.split(server_cmd, ' ');
    setting = {
      nodePath = '/home/trieu/.fnm/node-versions/v14.3.0/installation/bin/';
      lala = '/home/trieu/.fnm/node-versions/v14.3.0/installation/bin/';
    };
    filetypes = {'html','typescript','typescriptreact'};
    root_dir = util.root_pattern("package.json", ".git");
  };
  docs = {
    description = [[ ]];
    default_config = {
        root_dir = [[root_pattern("package.json", ".git")]];
    };
  }
}


import('plug/lsp/lsp').lsp_setup(nvim_lsp[server_name])

