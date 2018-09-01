" Exit viewport quickly.
nnoremap <Leader>q :q<CR>
" Focus on single viewport quickly.
nnoremap <Leader>o :only<CR>
" Treat wrapped lines as newlines for scrolling purposes.
nnoremap j gj
nnoremap k gk
" For quicker movement between viewports.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" So Y behaves like D and C and yanks to the end of the line without yanking
" newline character.
nnoremap Y y$

