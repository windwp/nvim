local keymap = import('core.keymap')

require'compe'.setup {
 enabled = true,
  debug = true,
  min_length = 2,
  preselect = "disable",
  source_timeout = 200,
  incomplete_delay = 400,
  allow_prefix_unmatch = false,
  source = {
    path = true;
    buffer = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}
require('vim.lsp.protocol').CompletionItemKind = {
    '';             -- Text          = 1;
    '';             -- Method        = 2;
    'ƒ';             -- Function      = 3;
    '';             -- Constructor   = 4;
    '';             -- Field         = 5;
    '';             -- Variable      = 6;
    '';             -- Class         = 7;
    'ﰮ';             -- Interface     = 8;
    '';             -- Module        = 9;
    '';             -- Property      = 10;
    '';             -- Unit          = 11;
    '';             -- Value         = 12;
    '了';            -- Enum          = 13;
    '';             -- Keyword       = 14;
    '﬌';             -- Snippet       = 15;
    '';             -- Color         = 16;
    '';             -- File          = 17;
    '';     -- Reference     = 18;
    '';             -- Folder        = 19;
    '';             -- EnumMember    = 20;
    '';             -- Constant      = 21;
    '';             -- Struct        = 22;
    "⌘";             -- Event         = 23;
    "";             -- Operator      = 24;
    "♛";             -- TypeParameter = 25;
  }



keymap.imap({'<tab>',function ()
  if vim.fn.pumvisible() == 1 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"]()
    else
      return keymap.t("<esc>a")
    end
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return keymap.t "<Plug>(vsnip-expand-or-jump)"
  else
    return keymap.t""
  end
end, expr = true, noremap = false})

keymap.imap({'<c-space>', 'compe#complete()',silent = true, expr = true, noremap = true})
