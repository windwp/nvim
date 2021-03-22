local paq = require'paq-nvim'.paq

-- default config it will load after packadd
local configs = {}

-- some vim stuff need to load config before packadd
local configs_before = {}

-- list back
local packs = {}

local M={}

-- customize paq
M.Plug = function(opts)
  local plugin = ''
  if type(opts) == 'string' then
    plugin = string.match(opts,'/(.*)')
    opts = {opts}
  else
    plugin = string.match(opts[1],'/(.*)')
  end

  if opts.on then
    opts.opt = true
    if opts.config then
      vim.cmd(string.format([[command! -nargs=* -range -bang -complete=file %s silent! delcommand %s | packadd %s | call v:lua.Wind.load_plug('%s') | %s]], opts.on, opts.on, plugin, opts.config, opts.on))
      opts.config = false
    else
      vim.cmd(string.format([[command! -nargs=* -range -bang -complete=file %s silent! delcommand %s | packadd %s | %s]], opts.on, opts.on, plugin, opts.on))
    end
  end

  if opts.ft then
    opts.opt = true
    if opts.config then
      vim.cmd(string.format([[au FileType %s ++once packadd %s | call v:lua.Wind.load_plug('%s')]] , opts.ft, plugin, opts.config))
      opts.config = false
    else
      vim.cmd(string.format([[au FileType %s ++once packadd %s]] ,opts.ft,plugin))
    end
  end

  if opts.cond ~= nil then
    opts.opt = true
    if opts.cond == true then
      table.insert(packs, plugin)
    else
    -- some config will nerver load here
      opts.config = false
    end
  end

  -- force all plugin is option except the opt = false
  if opts.opt == nil then
    opts.opt = true
    table.insert(packs, plugin)
  end

  if opts.before then
    table.insert(configs_before, opts.before)
  end

  if opts.config then
    table.insert(configs,opts.config)
  end

  paq(opts)

end

M.load_config=function()

  for _, value in pairs(configs_before) do
    Wind.load_plug(value)
  end

  for _, plugin in pairs(packs) do
    vim.cmd("packadd ".. plugin)
  end

  for _, value in pairs(configs) do
    Wind.load_plug(value)
  end
end

return M
