local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end
function autocmd.setup()
    if Wind.__autocmd_setup then return end
    Wind.__autocmd_setup = true
    local definitions = {
        lens ={
            {"BufWinEnter,WinEnter" ,"*", "silent! call win#lens()"}
        },
        bufs = {
            {"BufWritePre","*.tmp","setlocal noundofile"};
            {"BufWritePre","*.log","setlocal noundofile"};
            {"BufWritePre","*.bak","setlocal noundofile"};
        };
        wins = {
            -- write file when focus lost
            {'FocusLost','*','silent! wa'},
            -- if open 2 buffer in diffrent tab close it
            -- {"BufEnter"    , '*' , "call v:lua.import('core.nav').on_buffer_open(expand('<abuf>'))"};
            {"VimEnter"    , "*" , "lua import('general.autocmd').on_enter()"};
            {"ColorScheme" , "*" , "lua import('general.autocmd').on_color()"}
        };
        ft = {
            {"FileType", "typescript,typescriptreact,javascript", "imap <buffer><silent>; ;<esc>:lua require('nvim-autospace').format(999)<CR>A"},
        };
        lsp = {
            {"BufWritePre" ,"*.tsx", ":Format"}
        };
        yank = {
            {"TextYankPost", [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})]]};
        };
    }

    autocmd.nvim_create_augroups(definitions)
end


Wind.enter_event = Wind.enter_event or  {}
Wind.color_event = Wind.color_event or {}


autocmd.add_autocmd_enter = function(name, func)
    Wind.enter_event[name] = func
end

autocmd.on_enter = function()
    for _, handler in pairs(Wind.enter_event) do
        handler()
    end
end

autocmd.add_autocmd_color = function(name, func,add_to_enter)
    Wind.color_event[name] = func
    if add_to_enter then
        Wind.enter_event[name] = func
    end
end

autocmd.on_color = function()
    for _, handler in pairs(Wind.color_event) do
        handler()
    end
end

autocmd.setup()
return autocmd
