local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
function M.mapBuf(buf, mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, options)
end

-- Usage:
-- highlight(Cursor, { fg = bg_dark, bg = yellow })
function M.highlight(group, styles)
    local s = vim.tbl_extend('keep', styles, { gui = 'NONE', sp = 'NONE', fg = 'NONE', bg = 'NONE' })
    vim.cmd('highlight! '..group..' gui='..s.gui..' guisp='..s.sp..' guifg='..s.fg..' guibg='..s.bg)
end

-- Usage:
-- highlight({
--      CursorLine   = { bg = bg },
--      Cursor       = { fg = bg_dark, bg = yellow }
-- })
function M.highlights(hi_table)
    for group, styles in pairs(hi_table) do
        M.highlight(group, styles)
    end
end

function M.hiLink(src, dest)
    vim.cmd('highlight link '..src..' '..dest)
end

function M.hiLinks(hi_table)
    for src, dest in pairs(hi_table) do
        M.hiLink(src, dest)
    end
  end


function M.autocmd(event, triggers, operations)
  local cmd = string.format("autocmd %s %s %s", event, triggers, operations)
  vim.cmd(cmd)
end

function M.abbs(wrong_str, correct_str)
  vim.cmd(string.format("%sabbrev %s %s", 'i', wrong_str, correct_str))
end

function M.cabbs(wrong_str, correct_str )
  vim.cmd(string.format("%sabbrev %s %s", 'c', wrong_str, correct_str))
end

function M.buf_get_full_text(bufnr)
  local text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, true), '\n')
  if vim.api.nvim_buf_get_option(bufnr, 'eol') then
    text = text .. '\n'
  end
  return text
end


-- get visual selection text
--https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function M.get_visual_selection()
    local start_pos = vim.api.nvim_buf_get_mark(0, '<')
    local end_pos =  vim.api.nvim_buf_get_mark(0, '>')
    local lines = vim.fn.getline(start_pos[1], end_pos[1])
    -- add when only select in 1 line
    local plusEnd = 0
    local plusStart = 1
    if #lines == 0 then
      return ''
    elseif #lines ==1 then
      plusEnd = 1
      plusStart =1
    end
    lines[#lines] = string.sub(lines[#lines], 0 , end_pos[2]+ plusEnd)
    lines[1] = string.sub(lines[1], start_pos[2] + plusStart , string.len(lines[1]))
    local query=table.concat(lines,'')
    return query
end

function M.check_backspace ()
  local col = vim.fn.col('.') - 1
  local char = vim.fn.getline('.'):sub(col, col)
  if col == 0 or char:match("[%s%'\\\"]") then
    return true
  else
    return false
  end
end


function M.CodeFormat()
  local listFile = {'javascript' , 'typescript' , 'typescriptreact' , 'css' , 'html' , 'scss' , 'md'}
  for _,v in pairs(listFile) do
    if v == vim.bo.filetype then
        vim.cmd("Format")
        return
    end
  end
  vim.lsp.buf.formatting()
end



-- check current cursor is on end line
function  M.is_end_of_line()
  local line = vim.api.nvim_get_current_line()
  local pos  = vim.fn.getpos('.')
  local last = pos[3]
  for i = last, string.len(line), 1 do
    local char=line:sub(i,i)
    if not string.match(char,"%w") then
      return false
    end
  end
  return true
end
-- automatic trim new line when use yy on 1 line
-- and copy it in visual mode
function M.trimNewLine()
  local register = '+'
  local clipboard = vim.fn.getreg(register)
  local _, count  = clipboard:gsub('\n','\n')
  if count == 1 then
    clipboard = clipboard:gsub("\n", "")
    vim.fn.setreg(register,clipboard)
  end
  if M.is_end_of_line() then
   return vim.keymap.t[["1dpgv]]
  else
   return vim.keymap.t[["1dPgv]]
  end
end

local _, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')

-- check is inside in specific treesitter node
-- M.check_ts_node('^jsx')
function M.check_ts_node(pattern)
  if pattern == nil then return false end
  local cur_node = ts_utils.get_node_at_cursor()
  while cur_node ~= nil do
    local node_name = cur_node:type()
    if node_name ~= nil and string.match(node_name, pattern) then
      return true
    else
      cur_node = cur_node:parent()
    end
  end
  return false
end

--- chekc vim global value is exist if it exist skip set
function M.set_vim_global(opts, check)
  for k,v in pairs(opts) do
    if check and vim.g[k] == nil then
      vim.g[k] = v
    else
      vim.g.k=v
    end
  end
end

Wind.trimNewLine=M.trimNewLine

return M
