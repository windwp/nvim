-- vim: foldmethod=marker  sw=2 formatoptions-=o foldlevel=0

vim.g.lens_disabled_filetypes = {'fugitiveblame', 'fern', 'selectprompt', 'selectresults','quickfix','qf','which_key'}

-- Match up {{{
vim.g.loaded_matchparen = 1
vim.g.matchup_matchparen_offscreen = { method= 'popup'}
vim.g.matchup_matchpref = {
  svelte          = { tagnameonly = 1, },
  vue             = { tagnameonly = 1, },
  typescriptreact = { tagnameonly = 1, },
  html            = { tagnameonly = 1, },
}

-- }}}

-- Compe {{{
vim.g.loaded_compe_treesitter    = 1
vim.g.loaded_compe_calc          = 1
vim.g.loaded_compe_snippets_nvim = 1
vim.g.loaded_compe_spell         = 1
vim.g.loaded_compe_vim_lsc       = 1
vim.g.loaded_compe_vim_lsp       = 1
-- }}}

-- Markdown : {{{
  vim.g.vim_markdown_no_default_key_mappings = 1
  vim.g.vim_markdown_new_list_item_indent = 0
  vim.g.vim_markdown_auto_insert_bullets = 1
  vim.g.vim_markdown_follow_anchor = 1
  vim.g.vim_markdown_conceal_code_blocks = 0
  vim.g.vim_markdown_anchorexpr = [['^#\\\+ *'.v:anchor.'$']]

  vim.api.nvim_exec([[
  augroup markdown_tool
      autocmd!
      autocmd BufReadPost *.md call FixVimMarkdown()
      autocmd InsertLeave *.md call FixMdTable()
  augroup END
  ]],true)

-- }}}

--  GitGutter {{{

  vim.g.gitgutter_sign_added    = '┃'
  vim.g.gitgutter_sign_modified = '┃'
  vim.g.gitgutter_sign_removed  = '┃'

--}}}

-- Conflict Marker {{{

  vim.g.conflict_marker_highlight_group = ''
  vim.g.conflict_marker_begin = '^<<<<<<< .*$'
  vim.g.conflict_marker_end   = '^>>>>>>> .*$'

--}}}

--  hight light extra white space


vim.g.EasyMotion_smartcase = 1
vim.g.switch_mapping = "gst"
vim.g.switch_custom_definitions =  {
       {'0', '1'},
       {'const', 'let', 'var'}
     }

vim.g.undotree_SetFocusWhenToggle = 1
vim.g.no_default_tabular_maps = 0

-- "custom vifm to display image
vim.g.vifm_exec ='$HOME/.config/vifm/scripts/vifmrun'

vim.g.vsnip_snippet_dir = Wind.vim_path .. "/snippets"

-- TmuxLine {{{

if vim.g.wind_tmux_line == 1 then
  vim.g.tpipeline_tabline = 1
  import('general.autocmd').add_autocmd_enter('tpipe', function ()
    vim.cmd[[let g:tpipeline_statusline = &tabline]]
    vim.cmd[[set conceallevel=2]]
  end)
end
--}}}
