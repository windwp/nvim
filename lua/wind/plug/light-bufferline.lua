local keymap = import('core.keymap')

for i = 1, 10, 1 do
  keymap.nmap({string.format('<c-t>%s',i) ,string.format('<Plug>lightline#bufferline#go(%s)',i)})
  keymap.nmap({string.format('<A-%s>',i)  ,string.format('<Plug>lightline#bufferline#go(%s)',i)})
end



