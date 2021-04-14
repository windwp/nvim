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
    local plugin_name = ''
    if type(opts) == 'string' then
        plugin_name = string.match(opts,'/(.*)')
        opts = {opts}
    else
        plugin_name = string.match(opts[1],'/(.*)')
    end

    local add_to_rtp = true
    if opts.on then
        -- still have some problem here with argument on command
        -- when you type it first time it will not understand argument
        -- but it fine for me now
        if opts.config then
            vim.cmd(string.format(
                [[command! -nargs=* -range -bang -complete=file %s silent! delcommand %s | packadd %s | call v:lua.Wind.load_plug('%s') | %s]],
                opts.on, opts.on, plugin_name, opts.config, opts.on))
            opts.config = false
        else
            vim.cmd(string.format(
                [[command! -nargs=* -range -bang -complete=file %s silent! delcommand %s | packadd %s | %s]],
                opts.on, opts.on, plugin_name, opts.on))
        end
        add_to_rtp = false
    end

    if opts.ft then
        if opts.config then
            vim.cmd(string.format(
                [[au FileType %s ++once packadd %s | call v:lua.Wind.load_plug('%s') | e]] ,
                opts.ft, plugin_name, opts.config))
            opts.config = false
        else
            vim.cmd(string.format([[au FileType %s ++once packadd %s | e]] ,opts.ft,plugin_name))
        end
        add_to_rtp = false
    end

    if opts.cond ~= nil then
        if opts.cond == true then
            table.insert(packs, plugin_name)
        else
            opts.config = false
            add_to_rtp = false
        end
    end

    -- force all plugin is option except the opt = false
    -- paq will add this to folder start but i don't like it because
    -- if i remove the plugin from config file it still loading that
    if opts.opt == nil then opts.opt = true end

    if add_to_rtp == true then table.insert(packs, plugin_name) end

    -- some config need to load before we use it
    -- (vim global setting for vimscript)
    if opts.before then
        table.insert(configs_before, opts.before)
    end

    -- loading another config
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
    local ok, msg = pcall(vim.cmd, "packadd " .. plugin)
    if not ok then
      print('load pack error: ' .. plugin)
      print(msg)
    end
  end

  for _, value in pairs(configs) do
    Wind.load_plug(value)

  end
end



return M
