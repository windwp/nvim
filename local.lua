local utils = import('core.utils')
utils.set_vim_global({
  wind_use_bg           = 1,
  wind_use_agsort       = 0,
  wind_use_treesitter   = 1,

  wind_use_icon         = 1,
  wind_use_dap          = 0,
  wind_lsp_mode         = 'lsp',
  wind_tmux_line        = 1,
  wind_auto_close       = 1,
  wind_use_indent       = 1,
  wind_theme            = 'wind',
  wind_statusline_theme = 'wind',
}, true)
