" For reloading .vimrc file, useful if changes are made and don't want to exit
" vim.
nnoremap <Leader>R :so $MYVIMRC<CR>
" For more quickly opening new tabs.
nnoremap <Leader>t :tabnew<CR>
" Open last buffer.
nnoremap <Leader><Leader> <C-^>
" Cycle through relativenumber + number, number (only), and no numbering.
nnoremap <silent> <leader>r :call mappings#cycle_numbering()<CR>
" For easier saving.
nnoremap <Leader>w :write<CR>
" For easier exiting (saves file as well).
nnoremap <Leader>x :xit<CR>
" Exit viewport quickly.
nnoremap <Leader>q :q<CR>
" Focus on single viewport quickly.
nnoremap <Leader>o :only<CR>
