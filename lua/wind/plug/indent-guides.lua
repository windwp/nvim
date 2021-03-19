if vim.g.wind_use_indent == 1 then
require('indent_guides').setup({
  indent_levels = 30;
  indent_guide_size = 1;
  indent_start_level = 1;
  indent_space_guides = true;
  indent_tab_guides = false;
  indent_soft_pattern = '\\s';
  exclude_filetypes =
  {'help', 'dashboard', 'dashpreview', 'NvimTree', 'vista', 'sagahover', 'fern', 'markdown', 'which_key', 'terminal'};
  -- even_colors = { fg ='#517f8d',bg='#AEEA00' };
  -- odd_colors = {fg='#c43060',bg='#77929e'};
  indent_char = '┊';
})
end
