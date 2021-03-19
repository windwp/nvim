local nvim_lsp = require('lspconfig')
local nvim_setup=import('plug/lsp/lsp')

local prettier  = {
  formatCommand = "./node_modules/.bin/prettier --stdin --stdin-filepath ${INPUT}",
  formatStdin = true
}
local eslint = {
  lintCommand = "eslint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
}
local languages = {
  --lua = {luafmt},
  typescript = { eslint},
  javascript = {prettier, eslint},
  typescriptreact = {prettier, eslint},
  ['typescript.tsx'] = {prettier, eslint},
  javascriptreact = {prettier, eslint},
  ['javascript.jsx'] = {prettier, eslint},
  yaml = {prettier},
  json = {prettier},
  html = {prettier},
  scss = {prettier},
  css = {prettier},
  markdown = {prettier},
}
nvim_lsp.efm.setup{
  on_attach = nvim_setup.on_attach_vim,
  root_dir = nvim_lsp.util.root_pattern("package.json", ".git", vim.fn.getcwd()),
  filetypes = vim.tbl_keys(languages),
  init_options = {
    documentFormatting = true,
    codeAction = true
  },
  settings = {
    rootMarkers = { "package.json", ".git" },
    lintDebounce = 500,
    languages = languages
  },
}
-- require('plug/lsp/lsp').lsp_setup(nvim_lsp.diagnosticls)
