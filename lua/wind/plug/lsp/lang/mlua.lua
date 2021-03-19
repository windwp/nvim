local nvim_lsp = require('lspconfig')

nvim_lsp['sumneko_lua'].setup {
    cmd = {
        "/home/trieu/test/lua-language-server/bin/Linux/lua-language-server",
        "-E",
        "/home/trieu/test/lua-language-server/main.lua"
    },
    on_attach =import('plug/lsp/lsp').on_attach_vim,
    settings = {
            Lua = {
                runtime = {
                    -- Get the language server to recognize LuaJIT globals like `jit` and `bit`
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim' , 'Wind', 'import' , 'describe' , 'it'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
        },
}
