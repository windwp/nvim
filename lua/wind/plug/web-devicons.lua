require'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- DevIcon will be appended to `name`
  override = {
    svelte = {
      icon = "",
      color = "#D50000",
      name = "svelte"
    },

    folderopen = {
      icon = "",
      color = "#019833",
      name = "folderopen"
    },
    folderclose = {
      icon = "",
      color = "#AA00FF",
      name = "folderopen"
    }
  };
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}
vim.cmd[[
    autocmd ColorScheme * lua require'nvim-web-devicons'.setup()
]]
