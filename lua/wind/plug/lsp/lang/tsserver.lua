
local nvim_lsp = require('lspconfig')
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  }
import('plug/lsp/lsp').lsp_setup(nvim_lsp.tsserver)
