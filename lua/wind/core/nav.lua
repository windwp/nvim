--[[
My function to help navigation in vim
--]]
local windutils=import('core.utils')

local M = {}

local function is_qf_open()
  local winCount = vim.fn.winnr('$')
  for i = 1, winCount, 1 do
    local buffnr = vim.fn.winbufnr(i)
    if vim.fn.getbufvar(buffnr, '&filetype') == 'qf' then
      return true
    end
  end
  return false
end

local function is_buffer_fugitive(bufnr)
   bufnr =  bufnr or vim.fn.bufnr('%')
  local bufname = vim.fn.bufname(bufnr)
  if string.match(bufname, "^fugitive") ~= nil then
    return true
  end
  return false
end

-- jump back or next buffer
-- if qf is open it will use qf
M.goto_buff_or_qf = function (command)
  if is_qf_open() then
    if is_buffer_fugitive() then
      local view = vim.fn.winsaveview()
      -- change to quickfix target
      vim.cmd("c"..command)
      vim.fn.winrestview(view)
    else
      vim.cmd("c"..command)
    end
    return
  else
    -- change back to buffer
    vim.cmd("b"..command)
  end
end

-- auto close if it display 2 buffer in diffrent tab file
-- you can display 2 buffer in same tab.
function M.on_buffer_open(bufnr)
  bufnr = tonumber(bufnr)
  local bufname = vim.fn.bufname(bufnr)
  if string.match(bufname, "^fugitive") ~= nil then
    return
  end
  if bufname== nil or string.len(bufname)<2 then
      return
  end
  local windows = vim.fn.win_findbuf(bufnr)
  local winnr = vim.fn.win_getid()
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  if #windows >= 2 then
    for _, windowId in pairs(windows) do
        local cbuff = vim.api.nvim_win_get_buf(windowId)
        local ctab = vim.api.nvim_win_get_tabpage(windowId)
        local cname = vim.fn.bufname(cbuff)
        if windowId~= winnr and cname == bufname  and ctab~= tabnr then
            vim.cmd(":q")
            vim.fn.win_gotoid(windowId)
          return
        end
    end
  end
end

function M.get_window_id(filename)
  local bufname=vim.fn.bufname(filename)
  if filename == nil or string.len(bufname)==0 then
    return
  end
  local bufnr = vim.fn.bufnr(bufname)
  local window = vim.fn.win_findbuf(bufnr)
  if not vim.tbl_isempty(window) then
    return window[1]
  end
end

-- TODO
-- the problem of vim is navigate between buffer it is different with vs code
-- if you open 2 buffer in 2 window. You use gd to navigate to another
-- function in another buffer it will change current buffer and you have 2
-- buffer display same file
-- I want it similar to vs code navigate back and jump but it can't
-- <c-o> work well with same window  but not working with too many
-- tab open (Vim have different jumplists window and tab) it always change
-- current buffer and not jump to an exist buffer
-- I save it to 1 global variable for navigate back but some
-- time it is not working maybe I need to change my flow to 1 window

M.tabJumps={}

function M.tab_open(arr)
  if type(arr) == 'string' then
       arr = {arr}
  end
  if vim.tbl_isempty(arr) then
    return
  end
  local filename=arr[1]
  -- match filename
  filename = string.gsub(filename, "file://" , '' )
  filename = string.gsub(filename, "%%40" , '@'  )
  filename = string.gsub(filename, [[^%./]] , vim.fn.expand("%:h").."/" )
  if string.match(filename ,[[^../]]) ~= nil then
    filename = vim.fn.expand("%:h").."/"..filename
  end
  if vim.fn.filereadable(filename) == 0 then
    filename = vim.fn.expand(filename)
  end

  if vim.fn.filereadable(filename) == 0 then
    local check=false
    for _, value in pairs(vim.fn.split(vim.bo.suffixesadd,",")) do
        if vim.fn.filereadable(filename..value) == 1 then
            filename = filename..value
            check = true
        end
    end
    if check == false then
        local expr = vim.bo.includeexpr
        if string.len(expr)>1 then
            expr = string.gsub(expr, "v:fname", "'" .. filename .. "'" )
            filename = vim.fn.eval(expr) end
    end
    if check == false then
      filename = string.gsub(filename, "^([a-zA-Z])", vim.fn.expand("%:h") .. "/%1")
      for _, value in pairs(vim.fn.split(vim.bo.suffixesadd,",")) do
          if vim.fn.filereadable(filename..value) == 1 then
              filename = filename..value
              check = true
          end
      end
    end
    if vim.fn.filereadable(filename) == 0 then
      print("error can't get file name" .. filename)
      return
    end
  end

  local windowId  = M.get_window_id(filename)
  local bufnr = vim.fn.bufnr('%')
  local curpos = vim.fn.getpos('.')
  if windowId and windowId > 0 then
    vim.fn.win_gotoid(windowId)
  else
      local windows = vim.fn.win_findbuf(bufnr)
      -- only open in new tab if file is modifled
      -- and have 1 window open that file
      if vim.bo.modified == true and #windows == 1 then
          vim.cmd('tabnew '..vim.fn.fnameescape(filename))
      else
          vim.cmd('edit '..vim.fn.fnameescape(filename))
      end
  end

  -- my code for add another tab jump list
  if #arr>2 then
    local cline  = tonumber(arr[2])
    local ccol   = tonumber(arr[3])
    local tabData={
      bufnr  = bufnr,
      lnum   = curpos[2],
      col    = curpos[3],
      nlnum  = cline ,
      ncol   = ccol,
      nbufnr = vim.fn.bufnr('%'),
    }
    for index, value in pairs(M.tabJumps) do
      if value.nbufnr == tabData.nbufnr and value.nlnum == tabData.nlnum then
        table.remove(M.tabJumps,index)
        break
      end
    end
    table.insert(M.tabJumps,tabData)
    vim.g.my_tabs_jumps=M.tabJumps
  end
end

M.go_back = function()
  local cursor_pos = vim.fn.getpos(".")
  local bufnr = vim.fn.bufnr('%')
  if M.tabJumps ~= nil and not vim.tbl_isempty(M.tabJumps) then
    for index, jumpPos in pairs(M.tabJumps) do
      if jumpPos.nbufnr == bufnr and jumpPos.nlnum == cursor_pos[2] then
        table.remove(M.tabJumps , index)
        local lnum= jumpPos.lnum
        local col = jumpPos.col + 1
        local windowId = M.get_window_id(vim.fn.bufname(jumpPos.bufnr))
        local cwId = vim.fn.win_getid()
        if windowId ~= nil and windowId > 0 and cwId~=windowId then
          vim.fn.win_gotoid(windowId)
          vim.fn.cursor(lnum, col)
        elseif jumpPos.bufnr > 0 and jumpPos.bufnr ~= bufnr and vim.fn.bufexists(jumpPos.bufnr) > 0 then
          vim.cmd("buffer" .. jumpPos.bufnr)
          vim.fn.cursor(lnum, col)
        end
        return
      end
    end
  end
  vim.cmd[[execute "normal! \<c-o>zz"]]
end


function M.open(url)
  if Wind.is_linux then
    vim.cmd("silent !xdg-open '".. url .."'")
  else
    vim.cmd("silent !open ".. url)
  end
end

-- I disable netrw but still need open url by gx
function M.open_or_search (isVisual)
  local url= ''
  if isVisual == 1 then
    url = windutils.get_visual_selection()
    url = "https://google.com/search?q="..url
  else
    local urlregex=[[https://[a-zA-Z0-9\?\.\/\#\_\-]*]]
    local line =vim.fn.getline('.')
    url = string.match(line , urlregex)
    if url~= nil then url = url:gsub("#" , "\\#") end
    if vim.fn.empty(url) == 1 then
      url = "https://google.com/search?q="..line
    end
  end
  M.open(url)
end

Wind.tab_open = M.tab_open
Wind.go_back = M.go_back

return M
