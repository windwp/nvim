
local hiLink= import('core.utils').hiLink
local ts = require 'nvim-treesitter.configs'
local keymap = import('core.keymap')
-- local parser_config = require"nvim-treesitter.parsers".get_parser_configs()

-- parser_config.svelte = {
--   install_info = {
--     url = "~/test/tree-sitter-svelte", -- local path or git repo
--     files = {"src/parser.c", "src/scanner.cc"}
--   },
--   filetype = "svelte",
--   used_by = {"svelte"}
-- }

-- parser_config.xml = {
--   install_info = {
--       url = "https://github.com/windwp/tree-sitter-html",
--       files = { "src/parser.c", "src/scanner.cc" },
--   },
--   filetype = "xml",
--   used_by = {"xml"}
-- }

ts.setup {
  ensure_installed = 'maintained',
  highlight = {enable = true},
  indent = {
    enable = false
  },
  autotag = {
    enable = true,
  }
}

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/javascript/highlights.scm
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/7edf1d1c2bfb4bdc53319494697ca2947920b69e/lua/nvim-treesitter/highlight.lua
if vim.g.wind_theme == 'miramare' then
 hiLink('TSVariableBuiltin','Purple')
 hiLink('TSConstructor','Cyan')
 hiLink('TSProperty','White')
end
vim.cmd[[set foldmethod=expr]]
vim.cmd[[ set foldexpr=nvim_treesitter#foldexpr() ]]
keymap.nnoremap({'<leader><leader>.', '<cmd>:TSHighlightCapturesUnderCursor<cr>'})
