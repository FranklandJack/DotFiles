" For quicker movement between viewports.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" So Y behaves like D and C and yanks to the end of the line without yanking
" newline character.
nnoremap Y y$
" Puts vim into very special mode automatically when searching; this escapes
" all special regex characters automatically.
nnoremap  / /\v
" Nerdtree toggle map - toggles nerd tree on and off.
nnoremap <F2> :NERDTreeToggle<CR>
" To toggle tagbar on and off.
nnoremap <F3> :TagbarToggle<CR>
