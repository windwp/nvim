
local function bind_option(options)
  for k, v in pairs(options) do
    if v == true or v == false then
      vim.cmd('set ' .. k)
    else
      vim.cmd('set ' .. k .. '=' .. v)
    end
  end
end

local function load_options()
  local options = {
    termguicolors  = true;
    mouse          = "nv";
    errorbells     = true;
    visualbell     = true;
    hidden         = true;
    fileformats    = "unix,mac,dos";
    magic          = true;
    virtualedit    = "block";
    encoding       = "utf-8";
    viewoptions    = "folds,cursor,curdir,slash,unix";
    sessionoptions = "curdir,help,tabpages,winsize";
    clipboard      = "unnamedplus";
    wildignorecase = true;
    wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
    backup         = false;
    writebackup    = false;
    undofile       = true;
    swapfile       = false;
    directory      = Wind.cache_dir .. "swag/";
    undodir        = Wind.cache_dir .. "undo/";
    backupdir      = Wind.cache_dir .. "backup/";
    viewdir        = Wind.cache_dir .. "view/";
    spellfile      = Wind.cache_dir .. "spell/en.uft-8.add";
    history        = 2000;
    shada          = "!,'300,<50,@100,s10,h";
    backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";
    smarttab       = true;
    shiftround     = true;
    timeout        = true;
    ttimeout       = true;
    timeoutlen     = 500;
    ttimeoutlen    = 10;
    updatetime     = 100;
    redrawtime     = 1500;
    ignorecase     = true;
    smartcase      = true;
    infercase      = true;
    incsearch      = true;
    -- wrapscan       = true;
    complete       = ".,w,b,k";
    inccommand     = "nosplit";
    grepformat     = "%f:%l:%c:%m";
    grepprg        = 'rg --hidden --vimgrep --smart-case --';
    breakat        = [[\ \	;:,!?]];
    startofline    = true;
    -- whichwrap      = "h,l,<,>,[,],~";
    splitbelow     = true;
    splitright     = true;
    switchbuf      = "useopen";
    backspace      = "indent,eol,start";
    diffopt        = "filler,iwhite,internal,algorithm:patience";
    completeopt    = "menu,menuone,noselect";
    jumpoptions    = "stack";
    showmode       = false;
    shortmess      = "aoOTIcF";
    scrolloff      = 3;
    sidescrolloff  = 5;
    foldlevelstart = 99;
    ruler          = false;
    list           = true;
    showtabline    = 2;
    pumheight      = 15;
    helpheight     = 12;
    previewheight  = 12;
    showcmd        = false;
    cmdheight      = 2;
    cmdwinheight   = 5;
    equalalways    = false;
    laststatus     = 2;
    display        = "lastline";
    showbreak      = "↳  ";
    listchars      = "tab:………,nbsp:░,extends:»,precedes:«,trail:·";
    pumblend       = 10;
    winblend       = 10;
    confirm        = true;
    cursorline     = true;
  }

  local bw_local  = {
    nowrap         = true,
    synmaxcol      = 2500;
    formatoptions  = "1jcroql";
    textwidth      = 80;
    expandtab      = true;
    autoindent     = true;
    tabstop        = 2;
    shiftwidth     = 2;
    softtabstop    = -1;
    breakindentopt = "shift:2,min:20";
    linebreak      = true;
    number         = true;
    relativenumber = true;
    foldenable     = true;
    signcolumn     = "yes";
    conceallevel   = 2;
  }

  if Wind.is_mac then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = {
        ["+"] = "pbcopy",
        ["*"] = "pbcopy",
      },
      paste = {
        ["+"] = "pbpaste",
        ["*"] = "pbpaste",
      },
      cache_enabled = 0
    }
    vim.g.python_host_prog = '/usr/bin/python'
    vim.g.python3_host_prog = '/usr/local/bin/python3'
  end
  for name, value in pairs(options) do
    vim.o[name] = value
  end
  bind_option(bw_local)
end

local function disable_distribution_plugins()
  vim.g.did_install_default_menus = 1
  vim.g.loaded_gzip               = 1
  vim.g.loaded_tar                = 1
  vim.g.loaded_tarPlugin          = 1
  vim.g.loaded_zip                = 1
  vim.g.loaded_zipPlugin          = 1
  vim.g.loaded_getscript          = 1
  vim.g.loaded_getscriptPlugin    = 1
  vim.g.loaded_vimball            = 1
  vim.g.loaded_vimballPlugin      = 1
  vim.g.loaded_matchit            = 1
  vim.g.loaded_matchparen         = 1
  vim.g.loaded_2html_plugin       = 1
  vim.g.loaded_logiPat            = 1
  vim.g.loaded_rrhelper           = 1
  vim.g.loaded_netrw              = 1
  vim.g.loaded_netrwPlugin        = 1
  vim.g.loaded_netrwSettings      = 1
  vim.g.loaded_netrwFileHandlers  = 1
end

local function load_theme(theme_name)
    local themepath = string.format('%s/lua/wind/general/themes/%s.lua', Wind.vim_path, theme_name)
    if vim.fn.filereadable(themepath) == 1 then
      import(themepath)
    else
      vim.cmd(string.format([[colorscheme %s]], vim.g.wind_theme))
    end
end

local function  load_command()
  vim.api.nvim_exec([[
  filetype plugin indent on
  command! -nargs=* TabCustomOpen call v:lua.import('core.nav').tab_open(<f-args>)
  command! -nargs=* WindDev lua Wind.is_dev=true
  " enable italic in tmux
  set t_ZH=^[[3m
  set t_ZR=^[[23m
  ]],true)
end

local function setup()
  disable_distribution_plugins()
  load_options()
  load_theme(vim.g.wind_theme)
  load_command()
end

setup()

return {
  load_theme = load_theme
}
