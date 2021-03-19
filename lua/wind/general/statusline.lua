local fn = vim.fn
local api = vim.api

local M = {}

-- possible values are 'arrow' | 'rounded' | 'blank'
local active_sep = "rounded"

-- change them if you want to different separator
M.separators = {
  arrow   = { "", "" },
  rounded = { "\u{e0b8}", "\u{e0be}" },
  blank   = { "", "" },
}

-- highlight groups
M.colors = {
  active       = "%#StatusLine#",
  inactive     = "%#StatusLineNC#",
  mode         = "%#StatusLineMode#",
  mode_alt     = "%#StatusLineModeR#",
  git          = "%#Git#",
  git_alt      = "%#GitAlt#",
  filetype     = "%#StatusLineModeR#",
  filetype_alt = "%#StatusLineModeR#",
  line_col     = "%#StatusLineMode#",
  line_col_alt = "%#StatusLineModeR#",
}

M.trunc_width = setmetatable({
  git_status = 90,
  filename   = 140,
}, {
  __index = function()
    return 80
  end,
})

M.is_truncated = function(_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

M.modes = setmetatable({
  ["n"]  = "N",
  ["no"] = "N·P",
  ["v"]  = "V",
  ["V"]  = "V·L",
  [""] = "V·B", -- this is not ^V, but it's , they're different
  ["s"]  = "S",
  ["S"]  = "S·L",
  [""] = "S·B", -- same with this one, it's not ^S but it's 
  ["i"]  = "I",
  ["ic"] = "I",
  ["R"]  = "R",
  ["Rv"] = "V·R",
  ["c"]  = "C",
  ["cv"] = "V·E",
  ["ce"] = "E",
  ["r"]  = "P",
  ["rm"] = "M",
  ["r?"] = "C",
  ["!"]  = "S",
  ["t"]  = "T",
}, {
  __index = function()
    return "U" -- handle edge cases
  end,
})

M.get_current_mode = function(self)
  local current_mode = api.nvim_get_mode().mode
  return string.format(" %s ", self.modes[current_mode]):upper()
end

M.get_filename = function(self)
  if self:is_truncated(self.trunc_width.filename) then
    return " %<%f "
  end
  return " %<%F "
end

M.get_git_status=function()
  return vim.call('fugitive#head')
end

M.get_filetype = function()
  local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
  local icon = ''
  if vim.g.wind_use_icon then
    icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })
  end
  local filetype = vim.bo.filetype
  if filetype == "" then
    return " No FT "
  end
  return string.format(" %s %s ", icon, filetype):lower()
end

M.get_line_col = function()
  return " %l:%c "
end

M.set_active = function(self)
  local colors = self.colors

  local mode = colors.mode .. self:get_current_mode()
  local mode_alt = colors.mode_alt .. self.separators[active_sep][1]
  local git = colors.git .. self:get_git_status()
  local git_alt = colors.git_alt .. self.separators[active_sep][1]
  local filename = colors.inactive .. self:get_filename()
  local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
  local filetype = colors.filetype .. self:get_filetype()
  local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]
  local line_col = colors.line_col .. self:get_line_col()

  return table.concat({
    colors.active,
    mode,
    mode_alt,
    git,
    git_alt,
    filename,
    "%=",
    "%=",
    filetype_alt,
    filetype,
    line_col_alt,
    line_col,
  })
end

M.set_inactive = function(self)
  return self.colors.inactive .. "%= %F %="
end

M.set_explorer = function(self)
  local title = self.colors.mode .. "   "
  local title_alt = self.colors.mode_alt .. self.separators[active_sep][2]

  return table.concat({ self.colors.active, title, title_alt })
end

Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == "active" then
      return statusline:set_active()
    end
    if mode == "inactive" then
      return statusline:set_inactive()
    end
    if mode == "explorer" then
      return statusline:set_explorer()
    end
  end,
})

-- set statusline
-- TODO: replace this once we can define autocmd using lua
api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  au WinEnter,BufEnter,FileType fern setlocal statusline=%!v:lua.Statusline('explorer')
  augroup END
]], false)
