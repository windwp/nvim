--[[
My function to help navigation in vim
--]]
local windutils = import('core.utils')

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
            -- clear old error message
            vim.cmd("echo ")
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
    if bufname == nil or string.len(bufname) < 2 then
        return
    end
    if
        string.match(bufname, "^fugitive") ~= nil
        or string.match(bufname, "^octo") ~= nil
    then
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

function M.get_first_win_id_by_buf(bufnr, wid)
  local windows = vim.fn.win_findbuf(bufnr)
  for _, id in pairs(windows) do
      if id ~= wid then return id end
  end
  return nil
end

function M.get_bufnr_filename(filename)
  local bufname=vim.fn.bufname(filename)
  if filename == nil or string.len(bufname)==0 then
    return nil
  end
  local bufnr = vim.fn.bufnr(bufname)
  return bufnr
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

-- this function help jump to an exists buffer visible in window or different
-- tab. The problem of vim is navigate between buffer it is different with vs code
-- if you open 2 buffer in 2 window. You use gd to navigate to another
-- function in another buffer it will change current buffer and you have 2
-- buffer display same file
-- <c-o> work well with same window but not working with different
-- tab open (Vim have different jumplists window and tab)

function M.wind_open(arr)
    if type(arr) == 'string' then
        arr = {arr}
    end
    if vim.tbl_isempty(arr) then
        return
    end
    local filename = arr[1]
    -- match filename
    filename = string.gsub(filename, "file://" , '' )
    filename = string.gsub(filename, "%%40" , '@'  )
    filename = string.gsub(filename, "%%20" , ' '  )
    local cwd = vim.fn.expand("%:h")
    if cwd == "" then cwd = "." end
    filename = string.gsub(filename, [[^%./]] , cwd .. "/" )

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
            print("error can't get file name " .. filename)
            return
        end
    end

    local windowId  = M.get_window_id(filename)
    local bufnr = vim.fn.bufnr('%')
    local curpos = vim.fn.getpos('.')
    if windowId and windowId > 0 then
        vim.fn.win_gotoid(windowId)
    else
        vim.cmd('edit '..vim.fn.fnameescape(filename))
    end

    -- my code for add another tab jump list
    if #arr>2 then
        local tabJumps = Wind.state.tab_jumps or {}
        local nlnum  = tonumber(arr[2])
        local ncol   = tonumber(arr[3])
        local tabData={
            bufnr  = bufnr,
            lnum   = curpos[2],
            col    = curpos[3],
            nlnum  = nlnum ,
            ncol   = ncol,
            nbufnr = vim.fn.bufnr('%'),
        }
        tabJumps = vim.tbl_filter(function(value)
            if value.nbufnr == tabData.nbufnr and value.nlnum == tabData.nlnum then
                return false
            end
            return true
        end,tabJumps)
        table.insert(tabJumps, tabData)
        Wind.state.tab_jumps = tabJumps
        vim.api.nvim_win_set_cursor(0,{nlnum, ncol})
        if arr[4] == nil then
            vim.api.nvim_command[[execute "normal! m` "]]
        end
    end
end

M.go_back = function()
  local cursor_pos = vim.fn.getpos(".")
  local bufnr = vim.fn.bufnr('%')
  local tabJumps = Wind.state.tab_jumps
  if tabJumps ~= nil then
    for index, jumpPos in pairs(tabJumps) do
      if jumpPos.nbufnr == bufnr and jumpPos.nlnum == cursor_pos[2] then
        local lnum= jumpPos.lnum
        local col = jumpPos.col + 1
        local cwId = vim.fn.win_getid()
        local windowId = M.get_first_win_id_by_buf(jumpPos.bufnr, cwId)
        if windowId ~= nil and windowId > 0 and cwId~=windowId then
          if vim.fn.win_gotoid(windowId) == 1 then
            vim.fn.cursor(lnum, col - 1)
            Wind.state.tab_jumps = windutils.remove_by_index(tabJumps, index)
            return
          end
        elseif jumpPos.bufnr > 0 and jumpPos.bufnr ~= bufnr and vim.fn.bufexists(jumpPos.bufnr) > 0 then
            vim.cmd("buffer" .. jumpPos.bufnr)
            vim.fn.cursor(lnum, col -1)
            Wind.state.tab_jumps = windutils.remove_by_index(tabJumps, index)
            return
        end
      end
    end
  end
  vim.cmd[[execute "normal! \<c-o>zz"]]
end

M.wind_quit = function()

end

function M.sys_open(url)
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
  M.sys_open(url)
end

Wind.wind_open = M.wind_open
Wind.go_back = M.go_back

return M
