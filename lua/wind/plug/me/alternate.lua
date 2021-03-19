-- fast switch to another file match pattern
-- vim.g.wind_switch_file = {
--   {
--     source = "main.svelte",
--     target = "editor.svelte"
--   },
--   {
--     source = "editor.svelte",
--     target = "main.svelte"
--   },
-- }
local M={}
local nav=import('core.nav')

local function getTargetPath(prefix)

  if vim.g.wind_switch_file == nil then
    print("Not have a config file")
    return
  end
  local filename = vim.fn.expand("%:t")
  local data = vim.g.wind_switch_file
-- TEST
  -- filename="dio.lua"
  -- local data = {
  --   {
  --     source = ".*%.lua",
  --     target = "yank.xml"
  --   },
  --   {
  --     source = ".*%.html",
  --     target = "{}.ts"
  --   },
  --   {
  --     source = ".*%.ts",
  --     target = "{}.html"
  --   },
  -- }
  local path=''
  for _,item in pairs(data) do
    if filename:match(item.source) then
      path = vim.fn.expand("%:h")
      if item.target:match("{}") then
        filename=filename:gsub("%.%w*$","")
        local targetName=string.gsub(item.target,"{}",filename)
        path = path .. "/"..targetName
      else
        path = path .. "/"..item.target
      end
      if prefix ~= nil then
        if not path:match(prefix..'$') then
          path = "not valid"
        end
      end
      if vim.fn.filereadable(path) == 1 then
        return path
      end
    end
  end
  return ""
end
function M.switch(prefix)
  local target=getTargetPath(prefix)
  if vim.fn.filereadable(target) == 1 then
    nav.tabOpen(target)
    return
  end
end

function M.vsplit(prefix)
  local target=getTargetPath(prefix)
  if vim.fn.filereadable(target) == 1 then
    local windowId  = nav.get_window_id(target)
    if windowId and windowId > 0 then
      vim.fn.win_gotoid(windowId)
    else
      vim.cmd (":vsplit " .. target)
    end
    return
  end
end

return M
