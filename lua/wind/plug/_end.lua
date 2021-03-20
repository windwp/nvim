require("nvim-autopairs").setup({
  ignored_next_char = string.gsub([[ [%w%%%'%[%"] ]],"%s+", "")
})
require 'colorizer'.setup {
  'css' ; 'scss' ; 'yml' ; 'yaml' ; 'vim' ; 'javascript' ; 'html' ; "rasi", "conf", "lua"
}


Wind.load_plug('me')
import('general.autocmd').add_autocmd_color('whitespace',function ()
  vim.cmd[[highlight ExtraWhitespace ctermbg=red guibg=red]]
  vim.cmd[[match ExtraWhitespace /\s\+$/]]
end)

