" Disable arrow keys.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Copy/Paste to system clipboard.
if has('clipboard')
    map <leader>y "+y
    map <leader>p "+gp
    map <leader>P "+gP
endif

