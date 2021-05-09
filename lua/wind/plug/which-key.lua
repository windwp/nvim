
local wk = require('which-key')

        wk.setup {
            triggers = {"<leader>", 'g'},
            plugins = {
                marks = false, -- shows a list of your marks on ' and `
                registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                presets = false
            },
        }
wk.register({
    ['.'] = 'get vim syntax',
    r = {
        name = '+replace'  ,
        r = 'simple replace'       ,
        w = 'replace current word'          ,
        v = 'replace in visual text only'
    },
    e = {
        name = "+edit file",
        a    = 'Algin' ,
        t    = 'table format' ,
    },
    u = {
        name = "+utility",
        i = 'toggle system keyboard'              ,
        k = 'toggle vim keyboard'                 ,
        d = 'diff 2 panel '                       ,
        l = 'format line'                         ,
        f = {':Vifm<cr>'                          , 'vifm '              } ,
        u = {':UndotreeShow<cr>'                  , 'undotreeShow'       } ,
        w = {[[:%s/\s\+$//e<cr>]]                 , 'trim whitespace'    } ,
        t = 'get test cmd'                        ,
        b = {':call MyBoxToilet()<cr>'            , 'create term box'    } ,
        ['m'] = {':MyRedir messages<cr>'          , 'log meesage'        } ,
        ['='] = {':call MyCreateLine("=")<cr>'    , 'create line'        } ,
        ['.'] = {':call MyBackgroundToggle()<cr>' , 'toggle Background'  } ,
    },
    c = {
        name = '+current action'
    },
    l = { name="+lsp" },
    j = { name = "+jump" },
    g = {
        name="+git",
        a = {':Git add %<cr>'                        , 'add current'              } ,
        A = {':Git add .<cr>'                        , 'add all'                  } ,
        b = {':Git blame<cr>'                        , 'blame'                    } ,
        B = {':GBrowse<cr>'                          , 'browse'                   } ,
        c = {':Conflicted<cr>'                       , 'Conflicted'               } ,
        C = {':GitNextConflict<cr>'                  , 'Next Conflicted'          } ,
        d = {':Gvdiffsplit<cr>'                      , 'diff'                     } ,
        D = {':Gdiffsplit<cr>'                       , 'diff split'               } ,
        g = {':GGrep<cr>'                            , 'git grep'                 } ,
        s = {':Git<cr>'                          , 'status'                   } ,
        m = {':GitMessenger<cr>'                     , 'show current line commit' } ,
        h = 'highlight hunks'           ,
        H = 'preview hunk'              ,
        j = 'next hunk'                 ,
        k = 'prev hunk'                 ,
        u = 'undo hunk'                 ,
        l = {':0Gclog<cr>'                            , 'git log current file'     } ,
        e = {':Gedit<cr>'                            , 'edit file from git log'   } ,
        L = {':Glog<cr>'                             , 'git log project'          } ,
        p = {':AsyncRun git push<cr>'                , 'push'                     } ,
        P = {':Git pull<cr>'                         , 'pull'                     } ,
        r = {':GRemove<cr>'                          , 'remove'                   } ,
        v = {':GV<cr>'                               , 'view commits'             } ,
        V = {':GV!<cr>'                              , 'view buffer commits'      } ,
    },
    d = {
        name = '+diff' ,
        ['1'] = 'Diff 2 version from register [1]' ,
        h = 'Diff with head version' ,
        p = 'Diff with previous version' ,
        o = 'Conflict get our version' ,
        t = 'Conflict get their verion' ,
        b = 'Conflict diff both version' ,
        B = 'Conflict diff both rev version' ,
    },
    ["<leader>"] = {
        name = "nvim dev utility",
        l = "excute line",
        x = "excute file"
    },
    t = {
      name = '+terminal' ,
      [';'] =  'toggle terminal'  ,
      f = {':FloatermNew fzf'                               , 'fzf'      } ,
      g = {':FloatermNew lazygit'                           , 'git'      } ,
      d = {':FloatermNew lazydocker'                        , 'docker'   } ,
      n = {':FloatermNew node'                              , 'node'     } ,
      N = {':FloatermNew fm'                                , 'fm'       } ,
      t = {':FloatermToggle'                                , 'toggle'   } ,
  },
    [';'] = {
        name = "+find"
    }
},{prefix = "<leader>"})


vim.api.nvim_exec ([[
    augroup which_key_buf
    autocmd!
    autocmd VimEnter * :lua require("wind.plug.which-key").on_enter()
    augroup end
]],false)

return {
    on_enter = function ()
        for key, value in pairs(vim.keymap.which_key) do
            wk.register(value,{prefix = key})
        end
    end
}
