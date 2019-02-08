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
" Place a new line above the current one without entering insert mode (stolen
" from tpopes unimpaired plugin)
nnoremap [<leader> m`O<Esc>``
" Place a new line below the current one without entering insert mode (stolen
" from tpopes unimpaired plugin)
nnoremap ]<leader> m`o<Esc>``
" Enable/disable spell mode (also taken from vim-unimpaired).
nnoremap [os :set spell<CR>
nnoremap ]os :set spell!<CR>

" YCM mapping to force a full blocking compilation cycle on the file.
" Calling this command will force YCM to immediately recompile the file and
" display any new diagnostics it encounters. Recompilation with this command
" may take a while and furing this time the vim gui will be blocked.
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
" YCM mapping to GoTo whatever is under the cursor, the meaning of this
" command depends on the context, there are more specific versions of this
" function for when this doesn't work.
nnoremap <leader>gt :YcmCompleter GoTo<CR>
" YCM mapping to fix whatever compilation error is currently detected on the
" line.
nnoremap <leader>fi :YcmCompleter FixIt<CR>
