local paq = require('paq-nvim').paq

-- default config it will load after packadd
local configs = {}


-- manual pack it load use load_pack
local manual_packs = {}
-- list back
local packs = {}

local M = {}

-- customize paq
M.Plug = function(opts)
    local plugin_name = ''
    if type(opts) == 'string' then
        plugin_name = string.match(opts, '/(.*)')
        opts = { opts }
    else
        plugin_name = string.match(opts[1], '/(.*)')
    end
    local add_to_rtp = true
    if opts.manual == true then
        -- that option mean you need to load plugin by function load_pack
        opts.name = plugin_name
        table.insert(manual_packs, vim.deepcopy(opts))
        opts.opt = true
        opts.async = false
        opts.manual = false
        opts.config = false
        opts.on = false
        add_to_rtp = false
    end

    if opts.on then
        M.load_on_command(plugin_name, opts.on, opts.confg, opts.before)
        opts.before = false
        opts.config = false
        add_to_rtp = false
    end

    if opts.event then
        M.load_on_event(plugin_name, opts.event, opts.config, opts.before)
        opts.before = false
        opts.config = false
        add_to_rtp = false
    end

    if opts.key then
        M.load_on_key(plugin_name, opts.key, opts.config, opts.before)
        opts.before = false
        opts.config = false
        add_to_rtp = false
    end

    if opts.ft then
        M.load_on_ft(plugin_name, opts.ft, opts.config, opts.before)
        opts.before = false
        opts.config = false
        add_to_rtp = false
    end

    if opts.cond == false then
        opts.config = false
        add_to_rtp = false
    end

    -- force all plugin is option except the opt = false
    -- paq will add this to folder start but i don't like it because
    -- if i remove the plugin from config file it still loading that
    if opts.opt == nil then
        opts.opt = true
    end

    if add_to_rtp == true then
        table.insert(packs, plugin_name)
    end

    -- loading config
    if opts.config then
        table.insert(configs, opts.config)
    end

    -- print(plugin_name)
    paq(opts)
end

M.load_config = function()
    for _, plugin in pairs(packs) do
        local ok, msg = pcall(vim.cmd, 'packadd ' .. plugin)
        if not ok then
            print('load pack error: ' .. plugin)
            print(msg)
        end
    end

    for _, value in pairs(configs) do
        Wind.load_plug(value)
    end
end

M.load_on_event = function(plugin_name, event, cfg, before)
    cfg = cfg or ''
    before = before or''
    vim.api.nvim_exec(
        string.format(
            [[au %s *  ++once call v:lua.Wind.plug_cb_event('%s','%s','%s')]],
            event,
            plugin_name,
            cfg,
            before
        ),
        false
    )
end

M.plug_cb_event = function(plugin_name, cfg, before)
    if #before > 1 then
        Wind.load_plug(before)
    end
    local ok, msg = pcall(vim.cmd, 'packadd ' .. plugin_name)
    if not ok then
        print('load pack error: ' .. plugin_name)
        print(msg)
    end
    if #cfg > 1 then
        Wind.load_plug(cfg)
    end
end

M.load_on_key = function (plugin_name, key, cfg, before)
    if type(key) == 'table' then
        for _, k in pairs(key) do
            M.load_on_key(plugin_name, k, cfg, before)
        end
        return
    end
    vim.api.nvim_set_keymap('n', key,
        string.format("<cmd>lua Wind.plug_cb_key('%s','%s','%s','%s')<cr>",
            key,
            plugin_name,
            cfg or '',
            before or ''
        ),
        {noremap = true}
    )
end


M.plug_cb_key = function (key, plugin_name, cfg, before)
    vim.api.nvim_del_keymap('n', key)
    M.plug_cb_event(plugin_name, cfg, before)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), 'x', true)
end

M.load_on_ft = function (plugin_name, ft, cfg, before)
    if type(ft)=='table' then
        ft = table.concat(ft, ',')
    end
    vim.cmd(string.format(
        [[au FileType %s ++once call v:lua.Wind.plug_cb_event('%s','%s','%s')]],
        ft,
        plugin_name,
        cfg or '',
        before or ''
    ))
end

M.load_on_command = function(plugin_name, on_cmd, cfg, before)
    if type(on_cmd) == 'string' then
        on_cmd = { on_cmd }
    end
    for _, command in pairs(on_cmd) do
        vim.cmd(string.format(
            [[command! -nargs=* -range -bang -complete=file %s call v:lua.Wind.plug_cb_cmd('%s','%s','%s','%s',<f-args>)]],
            command,
            command,
            plugin_name,
            cfg or ' ',
            before or ''
        ))
    end
end

M.plug_cb_cmd = function(cmd, plugin_name, cfg, before, ...)
    vim.cmd(string.format([[delcommand %s]], cmd))
    M.plug_cb_event(plugin_name, cfg, before)
    local params = { ... }
    vim.cmd(cmd .. ' ' .. table.concat(params, ' '))
end

M.load_pack = function(name)
    for _, v in pairs(manual_packs) do
        if v.name == name then
            local ok, msg = pcall(vim.cmd, 'packadd ' .. name)
            if not ok then
                print('load pack error: ' .. name)
                print(msg)
            end
            if v.config then
                Wind.load_plug(v.config)
            end
            manual_packs.name = ''
            return
        end
    end
    print("We can't not find that pack " .. name)
end

--sorry paq it is a dirty think but i keep typing
--Plug in my command and my mind
vim.api.nvim_exec([[
command! PlugInstall  lua require('paq-nvim').install()
command! PlugUpdate   lua require('paq-nvim').update()
command! PlugClean    lua require('paq-nvim').clean()
command! PlugLogOpen  lua require('paq-nvim').log_open()
command! PlugLogClean lua require('paq-nvim').log_clean()
]],
    false
)

Wind.load_pack     = M.load_pack
Wind.plug_cb_cmd   = M.plug_cb_cmd
Wind.plug_cb_event = M.plug_cb_event
Wind.plug_cb_key   = M.plug_cb_key
return M
