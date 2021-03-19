local nvim_lsp = require'lspconfig'
local configs = require'lspconfig/configs'

configs.emmet_ls = {
  default_config = {
    cmd = {'node','/home/trieu/test/emmet-ls/out/server.js', '--stdio' };
    filetypes = {'html', 'css' ,'scss','svelte','typescriptreact'};
    root_dir = function()
      return vim.loop.cwd()
    end;
    settings = {};
  };
}
import('plug/lsp/lsp').lsp_setup(nvim_lsp.emmet_ls)

