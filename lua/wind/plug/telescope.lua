local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local conf = require('telescope.config').values
local themes=require('telescope.themes')
local flatten = vim.tbl_flatten
require'telescope'.load_extension('gh')
require'telescope'.load_extension('media_files')

local nnoremap = import'core.keymap'.nnoremap
local tab_open = import'core.nav'.tab_open
-- require('telescope').load_extension('fzy_native')
-- Global remapping
------------------------------
require('telescope').setup{
  -- extensions = {
  --   fzy_native = {
  --     override_generic_sorter = false,
  --     override_file_sorter = true,
  --   }
  -- },
  defaults = {
    color_devicons= true,
      vimgrep_arguments = {
      'ag',
      '--column',
      '--numbers',
      '--noheading',
      '--nocolor',
      '--smart-case',
      '--ignore',
      'yarn.lock',
      '--ignore',
      'package-lock.json',
    },
    mappings = {
      i= {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-l>"] = actions.select_vertical,
        ["<C-o>"] = actions.select_tab,
        ['<C-q>'] = actions.send_to_qflist,
        ['<Tab>'] = actions.toggle_selection,
        ["<esc>"] = actions.close
      },
      n = {
        ["<esc>"] = actions.close
      },
    },
  },
}

local M={}
M.root = ''
------------------------------
local k_mappings= function(prompt_bufnr)
    actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry.col and entry.lnum and not entry[1] then
            -- mark current cursor open to jumplist
            vim.api.nvim_command[[execute "normal! m` "]]
            vim.fn.cursor(entry.lnum,entry.col)
            vim.api.nvim_feedkeys('zz','n',true)
        elseif entry[1] then
            local sections = vim.split(entry[1], ":")
            local filename = sections[1]
            filename = M.root..filename;
            local row = tonumber(sections[2])
            local col = tonumber(sections[3])
            -- mark current cursor open to jumplist
            vim.api.nvim_command[[execute "normal! m` "]]
            if row and col then
                tab_open({filename,row,col})
                vim.fn.cursor(row,col)
                -- center position
                vim.api.nvim_feedkeys('zz','n',true)
            else
                tab_open({filename,row,col})

            end
        end
    end)

    return true
end

function M.goto_definition(opts)
 opts = opts or {}
 local params = vim.lsp.util.make_position_params()
 -- print(vim.inspect(params))
 -- need to process when it have multiple result and multiple language server
 local results_lsp = vim.lsp.buf_request_sync(0, "textDocument/definition", params, opts.timeout or 10000)
    if not results_lsp or vim.tbl_isempty(results_lsp) then
        print("No results from textDocument/definition")
        return
    end
  for _, lsp_data in pairs(results_lsp) do
    if lsp_data ~= nil and lsp_data.result ~= nil and not vim.tbl_isempty(lsp_data.result) then
      for _, value in pairs(lsp_data.result) do
        local range = value.range or value.targetRange
        if range ~= nil then
          local line = range.start.line
          local character = range.start.character
          local file = value.uri or value.targetUri
          -- skipp node module
          -- if file ~=nil and not string.match(file,'node_modules') then
          if file ~=nil then
            -- mark current cursor open to jumplist
            vim.api.nvim_command[[execute "normal! m` "]]
            tab_open({file , line + 1 , character + 1})
            vim.fn.cursor(line + 1 , character + 1)
            vim.api.nvim_feedkeys('zz','n',true)
            return
          end
        end
      end
    end
  end
  -- try to call default lsp function
  vim.lsp.buf.definition()
end


function M.picker_codeaction(opts)
  opts = opts or {}
  opts = themes.get_dropdown(opts)
  opts.previewer = false
  opts.width = nil
  builtin.lsp_code_actions(opts)
end

function M.picker_current_folder(opts)
   opts = opts or {}
  opts.cwd = "%:p:h"
  opts.tilte = ""
  M.file_picker(opts)
end


function M.picker_buffers(opts)
  opts = opts or {}
  opts = themes.get_dropdown(opts)
  opts.previewer = false
  opts.width = nil
  builtin.buffers(opts)
end

function M.picker_oldfiles(opts)
  opts = opts or {}
  opts.shorten_path = true
  opts = themes.get_dropdown(opts)
  opts.width = nil
  opts.previewer = false
  builtin.oldfiles(opts)
end
function M.picker_document_symbol(opts)
  opts = opts or {}
  opts = themes.get_dropdown(opts)
  opts.previewer = false
  opts.hide_filename = true
  opts.attach_mappings = k_mappings
  builtin.lsp_document_symbols(opts)
end
local function closeFern()
  if vim.bo.filetype == 'fern' then
    vim.cmd(":q")
  end
end

function M.live_grep()
  closeFern()
  builtin.live_grep()
end

function M.git_picker(opts)
  closeFern()
  M.root=''
  opts = opts or {}
  opts.title = ''
  opts = themes.get_dropdown(opts)
  opts.width = nil
  opts.attach_mappings = k_mappings
  if opts.cwd then
    opts.cwd = vim.fn.expand(opts.cwd)
    M.root = opts.cwd ..'/'
    opts.title = opts.cwd
  end
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)
  pickers.new(opts, {
    prompt_title = 'Git File',
    finder = finders.new_oneshot_job(
      { "git", "ls-files", "--exclude-standard", "--cached",  "--others" },
      opts
    ),
    previewer = false,
    sorter = conf.file_sorter(opts),
  }):find()
end
function M.file_picker(opts)
  closeFern()
  M.root=''
  opts = opts or {}
  opts.title = ''
  opts = themes.get_dropdown(opts)
  opts.width = nil
  opts.attach_mappings = k_mappings
  if opts.cwd then
    opts.cwd = vim.fn.expand(opts.cwd)
    M.root = opts.cwd ..'/'
    opts.title=opts.cwd
  end

  if not opts.cwd and vim.fn.expand("%:p:h") == vim.fn.expand("~") then
      print("We don't search in home directory")
      return
  end
  local find_command = { "ag", "-g", ""}
  if vim.g.wind_use_agsort == 1 then
    find_command = { vim.fn.expand('$HOME/.config/nvim/scripts/agfile.sh'), vim.fn.expand('%')   }
  end
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

  pickers.new(opts, {
    prompt_title = 'Find Files'..opts.title,
    finder = finders.new_oneshot_job(
      find_command,
      opts
    ),
    previewer = false,
    sorter = conf.file_sorter(opts),
  }):find()
end




function M.ag_find_filetype(opts)
  closeFern()
  opts = opts or {}
  opts.attach_mappings=k_mappings
  opts.shorten_path = true
  local filetype=vim.fn.input("Input file type : ")
  local vimgrep_arguments=  {
      'ag',
      '--column',
      '--numbers',
      '--noheading',
      '--nocolor',
      '--smart-case',
      '-G',
      '.*\\.' .. filetype
  }
  local live_grepper = finders.new_job(function(prompt)
      if not prompt or prompt == "" then
        return nil
      end
      -- print (table.tostring(flatten { vimgrep_arguments, prompt }))
      return flatten { vimgrep_arguments, prompt }
    end,
    opts.entry_maker or make_entry.gen_from_vimgrep(opts),
    opts.max_results
  )

  pickers.new(opts, {
    prompt_title = 'Search file ' .. filetype,
    finder = live_grepper,
    previewer = previewers.vimgrep.new(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end


function M.ag_find_folder(opts)
  closeFern()
  -- close fern
  opts = opts or {}
  opts.attach_mappings = k_mappings
  opts.cwd = opts.cwd or vim.fn.expand("%:p:h")
  opts.shorten_path = true
  local vimgrep_arguments=  {
      'ag',
      '--column',
      '--numbers',
      '--noheading',
      '--nocolor',
      '--smart-case',
  }
  local live_grepper = finders.new_job(function(prompt)
      if not prompt or prompt == "" then
        return nil
      end
      -- print (table.tostring(flatten { vimgrep_arguments, prompt }))
      return flatten { vimgrep_arguments, prompt ,opts.cwd}
    end,
    opts.entry_maker or make_entry.gen_from_vimgrep(opts),
    opts.max_results
  )

  pickers.new(opts, {
    prompt_title = 'Search file '.. opts.cwd,
    finder = live_grepper,
    previewer = previewers.vimgrep.new(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end

nnoremap({'<c-p>'     , '<cmd>lua Wind.load_plug("telescope").file_picker()<cr>'     })
nnoremap({'<c-t>p'    , '<cmd>Telescope commands<cr>'                                })
nnoremap({'<c-t>p'    , '<cmd>Telescope commands<cr>'                                })
nnoremap({'<c-t>f'    , '<cmd>lua Wind.load_plug("telescope").live_grep()<cr>'       })
nnoremap({'g;'        , '<cmd>lua Wind.load_plug("telescope").picker_buffers()<cr>'  })
nnoremap({'g,'        , '<cmd>lua Wind.load_plug("telescope").picker_oldfiles()<cr>' })

vim.api.nvim_exec([[
  command! -nargs=* SearchByFileType call v:lua.Wind.load_plug("telescope").ag_find_filetype()
  command! -nargs=* SearchCurrentFolder call v:lua.Wind.load_lsp("telescope").ag_find_folder()
  command! -nargs=* LspCodeAction call v:lua.Wind.load_lsp("telescope/builtin").lsp_range_code_actions()
]],false)

import('general.autocmd').add_autocmd_color('telescope', function ()
  vim.api.nvim_exec([[
    highlight TelescopeSelection      guifg=#9cf087 gui=bold  guibg=#00384d
    highlight TelescopeSelectionCaret guifg=#9cf087 guibg=#00384d 
    highlight TelescopeMultiSelection guifg=#928374 
    highlight TelescopeNormal         guibg=#00000  
    highlight TelescopeMatching       guifg=#ffcc1b
    highlight TelescopePromptPrefix   guifg=#9cf087
  ]],false)
end)

return M

