local paq = require'paq-nvim'.paq

local configs = {}

local pack_lists = {}

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
      table.insert(pack_lists, plugin)
    else
    -- some config will nerver load here
      opts.config = false
    end
  end

  if opts.config then
    table.insert(configs,opts.config)
  end

  paq(opts)

end

M.load_config=function()
  for _, plugin in pairs(pack_lists) do
    vim.cmd("packadd ".. plugin)
  end
  for _, value in pairs(configs) do
    Wind.load_plug(value)
  end
end

return M
