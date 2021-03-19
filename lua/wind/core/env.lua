local utils = import('core.utils')
local local_env = string.format('%s/local.lua', Wind.vim_path)

if vim.fn.filereadable(local_env) == 1 then
  vim.cmd("luafile " .. local_env)
end

utils.set_vim_global({
  wind_use_agsort       = 1,
  wind_use_plugin       = 1,
  wind_use_bg           = 1,
  wind_use_treesitter   = 1,
  wind_use_icon         = 1,
  wind_use_buffline     = 1,
  wind_use_dap          = 0,
  wind_lsp_mode         = 'lsp',
  wind_tmux_line        = 1,
  wind_auto_close       = 1,
  wind_use_indent       = 1,
  wind_theme            = 'rigel',
  wind_statusline_theme = 'pywal',
}, true)

