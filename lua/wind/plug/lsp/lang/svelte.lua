local configs = require 'lspconfig/configs'
local nvim_lsp = require('lspconfig')
local util = require 'lspconfig/util'

local server_name = 'svelte'
local bin_name = 'svelteserver'


configs[server_name] = {
  default_config = {
    cmd = {bin_name, '--stdio'};
    filetypes = {'svelte'};
    root_dir = util.root_pattern("package.json" );
  };
  docs = {
    description = [[
```sh
npm install -g svelte-language-server
```
]];
    default_config = {
      root_dir = [[root_pattern("package.json" )]];
    };
  }
}

vim.cmd[[
  autocmd BufWritePost *.ts lua require('wind.plug.lsp.lang.svelte').svelte_update()
]]


import('plug/lsp/lsp').lsp_setup(nvim_lsp.svelte)

local M ={}
function M.svelte_update()
  local buffList = vim.fn.getbufinfo({
    bufloaded = 1;
    buflisted = 1
  })
  for _, buf in pairs(buffList) do
    if string.match(buf.name,".*svelte$") then
      if buf.bufnr  then
        local bufnr = vim.fn.bufnr('%')
        local uri = vim.uri_from_bufnr(bufnr)
        local text= require('wind.core.utils').buf_get_full_text(bufnr)
        local params = {
          uri = uri;
          changes = { { text = text } }
        }
        vim.lsp.buf_notify(buf.bufnr, '$/onDidChangeTsOrJsFile', params)
      end
    end
  end
end
return M
