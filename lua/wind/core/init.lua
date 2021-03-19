local check_dir = function ()
  local data_dir = {
    Wind.cache_dir..'backup',
    Wind.cache_dir..'session',
    Wind.cache_dir..'undo'
  }
  if vim.fn.isdirectory(Wind.cache_dir) == 0 then
    os.execute("mkdir -p " .. Wind.cache_dir)
    for _,v in pairs(data_dir) do
      if vim.fn.isdirectory(v) == 0 then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

local function check_paq()
  local data_dir = string.format('%s/site/',vim.fn.stdpath('data'))
  local pag_dir = data_dir .. 'pack/paqs/opt/paq-nvim'
  local state = vim.loop.fs_stat(pag_dir)
  if not state then
    local cmd = "!git clone https://github.com/savq/paq-nvim.git " ..pag_dir
    vim.api.nvim_command(cmd)
    vim.loop.fs_mkdir(data_dir..'plugin',511,function()
      assert("make compile path dir failed")
    end)
  end
end

local function load_plug()
  vim.cmd 'packadd paq-nvim'         -- Load package
  local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function
  paq{'savq/paq-nvim', opt = true}     -- Let Paq manage itself
end

local function setup()
  vim.g.mapleader = " "
  check_dir()
  check_paq()
  load_plug()
end

setup()
import('core.env')
