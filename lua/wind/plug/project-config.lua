require('nvim-projectconfig').load_project_config({
  project_dir = "~/.config/projects-config/",
  silent = false
})


vim.cmd[[
  autocmd DirChanged * lua require('nvim-projectconfig').load_project_config()
]]
