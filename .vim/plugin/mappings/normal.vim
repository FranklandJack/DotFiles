" So Y behaves like D and C and yanks to the end of the line without yanking
" newline character.
nnoremap Y y$
" Puts vim into very special mode automatically when searching; this escapes
" all special regex characters automatically.
nnoremap  / /\v
nnoremap  ? ?\v
nnoremap K :nohlsearch<CR>

nnoremap - :Explore<CR>

" Paired mappings
" Place a new line above the current one without entering insert mode (stolen
" from tpopes unimpaired plugin)
nnoremap [<leader> m`O<Esc>``
" Place a new line below the current one without entering insert mode (stolen
" from tpopes unimpaired plugin)
nnoremap ]<leader> m`o<Esc>``
" Enable/disable spell mode (also taken from vim-unimpaired).
nnoremap [os :set spell<CR>
nnoremap ]os :set nospell<CR>
" Quicfix mappings (takes a count)
nnoremap [q :<C-U> execute v:count . "cprevious"<CR>
nnoremap ]q :<C-U> execute v:count . "cnext"<CR>
" Location list mappings (takes a count)
nnoremap [l :<C-U> execute v:count . "lprevious"<CR>
nnoremap ]l :<C-U> execute v:count . "lnext"<CR>

" Insert new line at cursor position and change to insert mode.
nnoremap <leader>i i<CR>
nnoremap <leader>a a<CR>
