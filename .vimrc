" Jack Frankland's .vimrc Configuration
" =====================================
" ViCompatibility(DO NOT MOVE - MUST BE FIRST IN FILE) {{{
" ============
" If a .vimrc is found in the $HOME directory then `:set nocompatible`
" happens by default.
if &compatible
  " Only set no 'nocompatible' when 'compatible' is set.
  set nocompatible
endif
" }}}
" Buffers {{{
" =======
set hidden "Keep buffers in background without need to save them.
" }}}
" Colors {{{
" =====
syntax enable " Set syntax highlighting.
colorscheme default " Set colorscheme.
" }}}
" Commenting {{{
" ==========
" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif
" }}}
" Deletion {{{
" ========
set backspace=indent,eol,start " Allow backspacing over autoindent, line breaks and start of insert action.
" }}}
" File reading {{{
" ============
set autoread " If file changed outside vim reload it.
"}}}
" Filetype Specific {{{
" =================
if has("autocmd")
	au FileType python setl ts=8 sw=2 sts=2 expandtab
endif
"}}}
" Folding {{{
" =======
set foldenable               " Enable folding.
set foldlevelstart=0         " Fold everything upon opening a file.
set foldnestmax=10           " 10 nested folds max.
set foldmethod=syntax        " Fold based on syntax (for C++)
" }}}
" History {{{
" =======
set history=1000 " Set length of command history.
" }}}
" Mappings {{{
" ========
" Set leader key to be spacebar.
let mapleader=" " 
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
" For exiting insert mode without moving away from home row.
inoremap jk <Esc>
inoremap kj <Esc>
" To stop myself reaching for escape (TEMPORARY).
inoremap <C-[> <Nop>
" For reloading .vimrc file, useful if changes are made and don't want to exit
" vim.
nnoremap <leader>r :so $MYVIMRC<CR>
" For more quickly opening new tabs.
nnoremap <leader>t :tabnew<CR>
"}}}
" Misc {{{
" ====
set mouse= " Disable mouse.
" Disable arrow keys.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
"}}}
" Modelines {{{
" =========
" Debian, Ubuntu, Gentoo, OSX, etc. by default disable modelines for security reasons.
set modeline 
set modelines=5
" }}}
" Plugins {{{
" =======
" Automatic VimPlug installation.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'sjl/badwolf' " Colorscheme.
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " NerdTree directory browser on-demand loading.
Plug 'airblade/vim-gitgutter' " GitGutter displays git diffs in margin.
Plug 'vim-airline/vim-airline' " Status/Tabline.
Plug 'vim-airline/vim-airline-themes' " Theme of airline.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Will install command line fzf as well.
Plug 'junegunn/fzf.vim' " Fuzzy file finder.
Plug 'w0rp/ale' " Asynchronous Lint Engine.
Plug 'tpope/vim-fugitive' " Git wrapper.
Plug 'scrooloose/nerdcommenter' " For commenting files.
" Initialize plugin system
call plug#end()
" }}}
" Plugin Configuration {{{
" ====================
" Badwolf {{{
let g:badwolf_darkgutter=1 " Make gutters darker than the background.
let g:badwolf_tabline=3 " Make tab line much lighter than the background.
let g:badwolf_html_link_underline=1 " Turn on HTML link underlining.
let g:badwolf_css_props_highlight=1 " Turn on CSS properties highlighting.
colorscheme badwolf " Actually set the colorscheme.
" }}}
" Airline {{{
" =======
let g:airline#extensions#tabline#enabled=1 " Enable tabline to be displayed.
let g:airline#extensions#tabline#left_sep = ' ' " Seperator around current tab in tabline.
let g:airline#extensions#tabline#left_alt_sep = '|' " Seperator around other tabs in tabline.
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' "  Sets how file paths are displayed in each individual tab as well as the current buffer indicator in the upper right.
" }}}
" Airline Themes {{{
" ==============
let g:airline_theme='badwolf'
" }}}
" ALE {{{
" ===
" Enable completion.
let g:ale_completion_enabled = 1
" Fix completion bug in some versions of Vim.
set completeopt=menu,menuone,preview,noselect,noinsert

" Set formatting.
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Set linters and fixers.
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'c': [ 'cquery' ],
\   'cpp': [ 'cquery' ],
\   'css': [ 'csslint' ],
\   'llvm': [ 'llc' ],
\   'lua': [ 'luac' ],
\   'python': [ 'flake8' ],
\   'ruby': [ 'rubocop' ],
\   'rust': [ 'cargo', 'rls' ],
\   'vim': [ 'vint' ],
\ }

" Use stable Rust for RLS.
let g:ale_rust_rls_toolchain = 'stable'

let g:ale_fix_on_save = 0
let g:ale_fixers = {
\   '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
\   'rust': [ 'rustfmt' ],
\ }

" Disable Ale for .tex.njk files.
let g:ale_pattern_options = {
\   '.*\.tex\.njk$': { 'ale_enabled': 0 },
\ }

" Limit clangtidy checks.
let g:ale_cpp_clangtidy_checks = ['clang-analyzer-*']

" Set bindings.
nmap <leader>ad <plug>(ale_go_to_definition)
nmap <leader>ar <plug>(ale_find_references)
nmap <leader>ah <plug>(ale_hover)
nmap <leader>af <plug>(ale_fix)
nmap <leader>at <plug>(ale_detail)
nmap <leader>an <plug>(ale_next_wrap)
nmap <leader>ap <plug>(ale_previous_wrap)

" Set quicker bindings.
nmap <C-n> <plug>(ale_next_wrap)
nmap <C-@> <plug>(ale_previous_wrap)
nmap <C-q> <plug>(ale_go_to_definition)
nmap <C-s> <plug>(ale_fix)
nmap <C-x> <plug>(ale_find_references)
" }}}
" FZF {{{
" ===
" Usage mappings.
nnoremap <C-p> :Files<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>pg :GFiles<CR>
nnoremap <leader>pc :Commits<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pt :Tags<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><C-k> <plug>(fzf-complete-word)
imap <c-x><C-f> <plug>(fzf-complete-path)
imap <c-x><C-j> <plug>(fzf-complete-file-ag)
imap <c-x><C-l> <plug>(fzf-complete-line)
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
" Match current colorscheme.
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" }}}
" NERD Commenter {{{
" ==============
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default.
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments.
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } } " Begin c-sytle comment with double *.
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region).
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting.
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not.
" }}}
" }}}
" Scrolling {{{
" =========
set scrolloff=5            " Keep a minimum of 5 line below the cursor.
set sidescrolloff=5        " Keep a minimum of 5 columns left of the cursor.
" }}}
" Searching {{{
" =========
set hlsearch        " Highlight matches.
set incsearch       " Highlight matches as we type.
set ignorecase      " Ignore case when searching.
set smartcase       " Don't ignore case when different cases searched for.
" }}}
" Spelling {{{
" ========
set spelllang=en_us " Set spellcheck language.
" }}}
" Tab Completion {{{
" ==============
" Turn on wildmenu for file name tab completion.
set wildmode=longest,list,full
set wildmenu
" }}}
" UI {{{
" ==
set ruler " Show Ruler.
set showcmd " Show incomplete commands.
set number " Line numbers.
set lazyredraw " Lazy redraw.
set cursorline " Highlight current line.
set report=0  " Report number of lines changed for all changes.
set showmatch " Show matching brackets.
set noshowmode " Don't show current mode (is shown in airline bar anyway).
"}}}
" UNDO/Backups {{{
" ============
" }}}
" vim: foldenable foldmethod=marker foldlevel=0 ts=4 sts=4 sw=4
