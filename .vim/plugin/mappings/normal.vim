" So Y behaves like D and C and yanks to the end of the line without yanking
" newline character.
nnoremap Y y$
" Puts vim into very special mode automatically when searching; this escapes
" all special regex characters automatically.
nnoremap  / /\v
nnoremap  ? ?\v

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
nnoremap ]os :set spell!<CR>
" Quicfix mappings (takes a count)
nnoremap [q :<C-U> execute v:count . "cprevious"<CR>
nnoremap ]q :<C-U> execute v:count . "cnext"<CR>
" Location list mappings (takes a count)
nnoremap [l :<C-U> execute v:count . "lprevious"<CR>
nnoremap ]l :<C-U> execute v:count . "lnext"<CR>

" Plugin specific mappings
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

" Insert new line at cursor position and change to insert mode.
nnoremap <leader>i i<CR>
nnoremap <leader>a a<CR>
