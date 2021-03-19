local lspsaga= require('lspsaga')
-- local lsp=import('plug/lsp/lsp')
-- local nnoremap = import('core.keymap').nnoremap

lspsaga.init_lsp_saga({
  code_action_prompt = {
    enable = false,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
  code_action_keys = { quit = '<esc>',exec = '<CR>' },
  rename_action_keys = {
    quit = '<esc>', exec = '<CR>'  -- quit can be a table
  }
})

