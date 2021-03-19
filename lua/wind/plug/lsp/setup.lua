local nvim_lsp = require('lspconfig')

local mlsp = Wind.load_plug("lsp/lsp")

Wind.load_plug('lsp/functions')
mlsp.lsp_setup(nvim_lsp.yamlls)
mlsp.lsp_setup(nvim_lsp.jsonls)
mlsp.lsp_setup(nvim_lsp.cssls)
mlsp.load_lsp('mlua')
-- vim.lsp.set_log_level("debug")

