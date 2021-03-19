-- use Telescopt to get text from copyq
--
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local themes=require('telescope.themes')

local M={}
local popup = require('popup')
local conf = require('telescope.config').values
local utils = require('telescope.utils')
local log = require('telescope.log')

M.msgLoadingPopup = function(msg, cmd, complete_fn)
  local row = math.floor((vim.o.lines-5) / 2)
  local width = math.floor(vim.o.columns / 1.5)
  local col = math.floor((vim.o.columns - width) / 2)
  for _ = 1, (width-#msg)/2, 1 do
    msg = " "..msg
  end
  local prompt_win, prompt_opts = popup.create(msg, {
    border ={},
    borderchars = conf.borderchars ,
    height = 5,
    col = col,
    line = row,
    width = width,
  })
  vim.api.nvim_win_set_option(prompt_win, 'winhl', 'Normal:TelescopeNormal')
  vim.api.nvim_win_set_option(prompt_win, 'winblend', 0)
  local prompt_border_win = prompt_opts.border and prompt_opts.border.win_id
  if prompt_border_win then vim.api.nvim_win_set_option(prompt_border_win, 'winhl', 'Normal:TelescopePromptBorder') end
  vim.defer_fn(vim.schedule_wrap(function()
    local results = utils.get_os_command_output(cmd)
    if not pcall(vim.api.nvim_win_close, prompt_win, true) then
      log.trace("Unable to close window: ", "copyq", "/", prompt_win)
    end
    complete_fn(results)
  end),10)
end

M.show = function()
  local max=100
  local opts = {}
  local separator=[[|||]]
  local cmd = {'copyq', 'separator', "\n"..separator, 'read'}
  for i = 0, max, 1 do
    table.insert(cmd, "" .. i)
  end
  M.msgLoadingPopup("Loading copyq ", cmd, function (results)
    local list = {}
    local item = {
      key = '',
      display = '',
      line = 1,
      text = ''
    }
    for _, value in pairs(results) do
      if string.match(value, "^" .. separator) ~= nil then
        if string.len(item.key) > 1 then
          table.insert(list, item)
        end
        local text=value:sub(#separator + 1, string.len(value) );
        item = {
          line    = 0,
          display = text,
          key     = text,
          text    = text ,
        }
      else
        if item.key == '' and string.len(value) > 2 then
          item.key = value
          item.display = value
          item.line = 0
        end
        item.line = item.line + 1
        if item.line > 1 then
          item.display = item.key .. string.format("   [[%s lines]]", item.line)
        end
        item.text = item.text .. "\n" .. value
      end
    end
    table.insert(list, item)
    opts = themes.get_dropdown(opts)
    opts.previewer = false
    opts.width = nil
    pickers.new(opts,{
      prompt_title = 'Copyq',
      finder = finders.new_table {
        results = list,
        entry_maker = M.make_entry(),
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function()
        actions.select_default:replace(function (prompt_bufnr)
        local entry = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modifiable") then
              lines = {}
              for s in entry.value:gmatch("[^\r\n]+") do
                  table.insert(lines, s)
              end
            vim.api.nvim_put(lines,'c',true ,true)
          end
        end
        )
        return true
      end,
    }):find()
  end)
end
M.make_entry=function()
  return function(entry)
    return{
      valid = true,
      value = entry.text,
      ordinal = entry.key,
      display = entry.display
    }
  end
end

return M
