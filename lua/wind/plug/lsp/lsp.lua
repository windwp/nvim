local lsp_util = require 'vim.lsp.util'
local utils = import'core.utils'
local map = utils.map
local mapBuf = utils.mapBuf

vim.fn.sign_define('LspDiagnosticsSignError', {text='', texthl='LspDiagnosticsSignError'})
vim.fn.sign_define('LspDiagnosticsSignWarning', {text='', texthl='LspDiagnosticsSignWarning'})
vim.fn.sign_define('LspDiagnosticsSignInformation', {text='', texthl='LspDiagnosticsSignInformation'})
vim.fn.sign_define('LspDiagnosticsSignHint', {text='', texthl='LspDiagnosticsSignHint'})


local apply_format =function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    local view = vim.fn.winsaveview()
    local totaLine1 = vim.fn.line('$')
    local marks= vim.fn.getmarklist()
    vim.lsp.util.apply_text_edits(result, bufnr)
    vim.fn.winrestview(view)

    local totalLine2 = vim.fn.line('$')
    -- restore marks
    for _,m in pairs(marks) do
      if string.match(m.mark, "'[a-zA-Z]") then
        if bufnr == m.pos[1] then
          m.pos[2] = m.pos[2] + totalLine2 - totaLine1
          if m.pos[2] > 0 and m.pos[2] < totalLine2 then
          vim.fn.setpos(m.mark,m.pos)
        end
        end
      end
    end
    if bufnr == vim.api.nvim_get_current_buf() then
      vim.api.nvim_command("noautocmd :update")
    end
end
vim.lsp.handlers['textDocument/rangeFormatting'] = apply_format
vim.lsp.handlers['textDocument/formatting'] = apply_format
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 5
    virtual_text = {
      spacing = 5,
      severity_limit = 'Warning',
    },
    -- Disable a feature
    update_in_insert = false,
  }
)

local statusline_lsp = function ()
  local clients = vim.lsp.buf_get_clients(0)
  if #clients > 0 then
    local clientName = ''
    for _, server in pairs(clients) do
      if server then
        clientName = server.config.name .. "|" ..  clientName
      end
    end
    vim.b.wind_lsp_server_name = string.format("%s", clientName:sub(0, string.len(clientName) -1))
    return vim.b.wind_lsp_server_name
  end
  return ''
end

local mappping = function (bufnr)
  mapBuf(bufnr, 'n' , 'gh'        , "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>"                )
  mapBuf(bufnr, 'n' , 'gH'        , "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>"                )
  mapBuf(bufnr, 'n' , '<c-]>'     , "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>"          )
  mapBuf(bufnr, 'n' , 'gpd'       , "<cmd>lua vim.lsp.buf.peek_definition()<cr>"      )
  mapBuf(bufnr, 'n' , 'gtd'       , "<cmd>lua vim.lsp.buf.type_definition()<cr>"      )
  mapBuf(bufnr, 'v' , '<leader>f' , "<cmd>lua vim.lsp.buf.formatting()<cr>"     )
  mapBuf(bufnr, 'n' , '<F2>'      , "<cmd>lua require('lspsaga.rename').rename()<CR>"               )
  mapBuf(bufnr, 'n' , 'gse'       , "<cmd>lua vim.lsp.diagnostic.goto_next({severity_limit = 3  })<Cr>"     )
  mapBuf(bufnr, 'n' , 'gsb'       , "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>" )

  mapBuf(bufnr, 'v' , '<leader>a' , "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>")
  mapBuf(bufnr, 'n' , '<leader>a' , '<cmd>lua require("lspsaga.codeaction").code_action()<CR>'                )
  mapBuf(bufnr, 'n' , 'go'        , '<cmd>lua Wind.load_plug("telescope").picker_document_symbol()<cr>')
  mapBuf(bufnr, 'n' , 'gd'        , '<cmd>lua Wind.load_plug("telescope").goto_definition()<cr>')
  mapBuf(bufnr, 'n' , 'gD'        , '<cmd>lua vim.lsp.buf.definition()<cr>')
  mapBuf(bufnr, 'n' , 'gsr'       , '<cmd>Telescope lsp_references<cr>')
  mapBuf(bufnr, 'n' , 'ga'        , '<cmd>Telescope lsp_code_actions<cr>')
  mapBuf(bufnr, 'n' , 'gsl'       , "<cmd>Lspsaga diagnostic_jump_next<CR>")
end

local extend_obj = {}

local on_attach_vim = function(client , bufnr)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- require'completion'.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  statusline_lsp()
  mappping(bufnr)
  if extend_obj.on_attach_vim ~= nil then
    extend_obj.on_attach_vim(client,bufnr)
  end
end

local lsp_extend = function(obj)
   extend_obj= vim.tbl_extend('force', extend_obj, obj)
end

local lsp_setup = function(lsp)
  -- check nil if it already setup and reload
  if lsp ~= nil and lsp.setup ~= nil then
    lsp.setup({
      on_attach = on_attach_vim
    })
  end
end

local onSignatureHelp = function()
  if vim.b.wind_lsp_server_name and string.len(vim.b.wind_lsp_server_name) > 1 then
    local params = lsp_util.make_position_params()
    return vim.lsp.buf_request(1, 'textDocument/signatureHelp', params ,nil)
  end
end

local load_lsp = function (lang)
  local path = string.format('%s/lua/wind/plug/lsp/lang/%s.lua', Wind.vim_path, lang)
  if vim.fn.filereadable(path) == 1 then
    return import('plug.lsp.lang.'..lang)
  else
    local nvim_lsp = require('lspconfig')
    if nvim_lsp[lang] ~= nil then
      lsp_setup(nvim_lsp[lang])
    else
      print("Not found Lsp:" .. lang)
    end
  end
end

return {
  load_lsp        = load_lsp,
  on_attach_vim   = on_attach_vim,
  lsp_setup       = lsp_setup,
  lsp_extend      = lsp_extend,
  onSignatureHelp = onSignatureHelp ,
  statusline_lsp  = statusline_lsp ,
}
