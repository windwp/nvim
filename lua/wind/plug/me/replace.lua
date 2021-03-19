local M={}
local nmap=import('core.keymap').nmap

-- small plugin to replace text quote and bracket

M.bracket = function (amode)
  local pos = vim.api.nvim_win_get_cursor('.')
  local line =vim.fn.getline('.')
  for l = pos[2],#line, 1 do
    print(line:sub(l, l))
    if string.match(line:sub(l,l),'[%}%]%)]') then
      if amode == "a" then
        return string.format("va%sP", line:sub(l, l))
      else
        return string.format("vi%sP", line:sub(l, l))
      end
    end
  end
  return ''
end

M.quote = function (amode)
  local pos = vim.api.nvim_win_get_cursor('.')
  local line =vim.fn.getline('.')
  local pattern = string.gsub([[ [%"%'%`] ]],'%s','')
  for l = pos[2],#line, 1 do
    if string.match(line:sub(l,l),pattern) then
      if amode == "a" then
        return string.format("va%sP", line:sub(l, l))
      else
        return string.format("vi%sP", line:sub(l, l))
      end
    end
  end
  return ''
end

M.setup = function()
  -- WTF is this :) but it  make I can repeat replace word use dot
  nmap({'grw'  , 'viw"1y:let @/=@1<CR>:let @2=@+<CR>cgn<c-r>2<esc>:let @+=@2<CR>'})
  nmap({'grq'  , 'v:lua.Wind.load_plug("me.replace").quote("i")'   , expr=true})
  nmap({'graq' , 'v:lua.Wind.load_plug("me.replace").quote("a")'   , expr=true})
  nmap({'grb'  , 'v:lua.Wind.load_plug("me.replace").bracket("i")' , expr=true})
  nmap({'grab' , 'v:lua.Wind.load_plug("me.replace").bracket("a")' , expr=true})
  nmap({'grt'  , 'vitp'})
  nmap({'grat' , 'vatp'})
end


return M
