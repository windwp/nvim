require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitGutterAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='DiffAdd'},
    change       = {hl = 'GitGutterChange', text = '┃', numhl='GitSignsChangeNr', linehl='DiffChange'},
    -- delete       = {hl = 'GitGutterDelete', text = 'ﬠ', numhl='GitSignsDeleteNr', linehl='DiffDelete'},
    -- topdelete    = {hl = 'GitGutterDelete', text = 'ﬢ', numhl='GitSignsDeleteNr' ,linehl='DiffDelete'},
    delete       = {hl = 'GitGutterDelete', text = '┃', numhl='GitSignsDeleteNr', linehl='DiffDelete', show_count = true},
    topdelete    = {hl = 'GitGutterDelete', text = '▔', numhl='GitSignsDeleteNr' ,linehl='DiffDelete',  show_count = true},
    changedelete = {hl = 'GitGutterDelete', text = '┃', numhl='GitSignsChangeNr', linehl='DiffDelete', show_count = true},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n <leader>gj'] =  '<cmd>lua require"gitsigns".next_hunk()<CR>',
    ['n <leader>gk'] =  '<cmd>lua require"gitsigns".prev_hunk()<CR>',

    -- ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    -- ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>gu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>gR'] = ':Gread<cr>', -- reset buffer
    ['n <leader>gh'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

    -- Text objects
    -- ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    -- ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
  },
  watch_index = {
    interval = 1000
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  use_decoration_api = true,
  use_internal_diff = true,  -- If luajit is present
}
