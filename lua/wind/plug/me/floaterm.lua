
-- cheat lspsaga floaterm to work like vim-floaterm  - floaterm to use lspsaga floaterm

local floaterm=require('lspsaga.floaterm')
local api = vim.api
local M = {}
function M.toggleFloatTerm()
  local has_var = pcall(api.nvim_buf_get_var,0,'float_terminal_win')
  if has_var then
    floaterm.close_float_terminal()
  else
    floaterm.open_float_terminal()
  end
end
function M.command(opt1,opt2,opt3)
  if not opt1 then return end
  opt2 = opt2 or ""
  opt3 = opt3 or ""
  floaterm.open_float_terminal(string.format("%s %s %s", opt1, opt2, opt3))
end

function M.kill()
    floaterm.close_float_terminal()
end

function M.setup()
  keymap.nnoremap({'<a-q>',"<cmd>lua Wind.load_plug('me.floaterm').toggleFloatTerm()<CR>"})
  keymap.tnoremap({'<a-q>',"<C-\\><C-n>:lua Wind.load_plug('me.floaterm').toggleFloatTerm()<CR>"})
  api.nvim_exec([[
  command! -nargs=*  -bang -range  FloatermNew  call v:lua.Wind.load_plug("me.floaterm").command(<f-args>)
  command! -nargs=? -count=0 -bang  FloatermKill  call v:lua.Wind.load_plug("me.floaterm").kill(<bang>0, <count>, <q-args>)
  ]],false)
end
M.setup()
return M
