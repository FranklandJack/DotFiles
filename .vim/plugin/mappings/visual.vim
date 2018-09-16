" For quicker movement between viewports in insert mode.
xnoremap <C-h> <C-w>h
xnoremap <C-j> <C-w>j
xnoremap <C-k> <C-w>k
xnoremap <C-l> <C-w>l
" Puts vim into very special mode automatically when searching; this escapes
" all special regex characters automatically.
xnoremap  / /\v

" Shift whole lines up and down.
xnoremap K :move '<-2<CR>gv=gv
xnoremap J :move '>+1<CR>gv=gv
