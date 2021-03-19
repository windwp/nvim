local function prettier(args)
  if args == nil then args = {} end
  return function ()
    args = vim.tbl_flatten({"--stdin-filepath", vim.api.nvim_buf_get_name(0), args})
    return {
      exe = "prettier",
      args = args,
      stdin = true
    }
  end
end
local function rustywind()
  local args = vim.tbl_flatten({ vim.api.nvim_buf_get_name(0), '|', 'head', '-n', '-3', '|', 'tail', '-n', '+5'})
    return {
      exe = "rustywind",
      args = args,
      stdin = true
    }
end
local default_prettier = prettier()
require('formatter').setup({
 filetype = {
   json       = { default_prettier },
   xml        = { default_prettier },
   scss       = { default_prettier },
   html       = { default_prettier },
   svelte     = { rustywind},
   javascript = { prettier({'--single-quote'}) },
   javascriptreact = { prettier({'--single-quote'}) },
   typescript = { prettier({'--single-quote'}) },
   typescriptreact = { prettier({'--single-quote'}) },
  }
})
