-- global utils
local M = {}
_G.Wind = _G.Wind or M
M.is_dev = false
M.root='wind'

local home    = os.getenv('HOME')
local path_sep = M.is_windows and '\\' or '/'
local os_name = vim.loop.os_uname().sysname
vim.g.wind_os_name = os_name

local function load_variables ()
  M.is_mac     = os_name == 'Darwin'
  M.is_linux   = os_name == 'Linux'
  M.is_windows = os_name == 'Windows'
  M.vim_path   = vim.fn.stdpath('config')
  M.cache_dir  = home .. path_sep .. '.vim' .. path_sep .. '.cache' .. path_sep
  M.path_sep = path_sep
  M.home = home
end

-- load custom lsp
M.load_lsp = function (langs)
  if type(langs) == 'string' then langs = {langs} end
  for _, lang in pairs(langs) do
    Wind.load_plug('lsp/lsp').load_lsp(lang)
  end
end

M.load_theme= function(theme_name)
  if vim.g.theme_name == theme_name then return end
  vim.g.theme_name = theme_name
  import('general.setting').load_theme(theme_name)
end

M.load_plug = function (plug)
  if string.match(plug, '.vim') then
    import(string.format('%s/plug/%s', Wind.vim_path, plug))
  else
    return import('plug.' .. plug)
  end
end

-- https://github.com/nvim-lua/plenary.nvim/blob/master/lua/plenary/reload.lua
local function reload_module(module_name, starts_with_only)
  -- TODO: Might need to handle cpath / compiled lua packages? Not sure.
  local matcher
  if not starts_with_only then
    matcher = function(pack)
      return string.find(pack, module_name, 1, true)
    end
  else
    matcher = function(pack)
      return string.find(pack, '^' .. module_name)
    end
  end

  for pack, _ in pairs(package.loaded) do
    if matcher(pack) then
      package.loaded[pack] = nil
    end
  end
end

_G.P = function (a)
  print(vim.inspect(a))
end

_G.R = function(name)
  reload_module(name)
  return require(name)
end

M.import_vim = function(path)
  vim.cmd("source" .. path )
end

M.import_lua = function(path)
  vim.cmd("luafile ".. path)
end

_G.import = function (path)
  if string.match(path, '%.vim$') then
    local err, detail = pcall(M.import_vim, path)
    if not err then
      print("Import vim error: " .. path)
      vim.api.nvim_err_writeln(vim.inspect(detail))
    end
    return
  end
  if string.match(path, '%.lua$') then
    local err, detail = pcall(M.import_lua, path)
    if not err then
      print("Import lua error: " .. path)
      vim.api.nvim_err_writeln(vim.inspect(detail))
    end
    return
  end

  path = string.format("%s.%s", M.root, path)
  if M.is_dev then
    return R(path)
  else
    local check, detail = pcall(require,path)
    if check then
      return detail
    else
      print('Import module error: ' .. path)
      vim.api.nvim_err_writeln(detail)
    end
  end
end

load_variables()

return M
