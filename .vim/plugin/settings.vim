let mapleader=" " " Set leader key to be spacebar.
let updatetime=300 "Set time used by CursorHold to 300ms
" UI {{{
" ==
set ruler " Show Ruler.
set showcmd " Show incomplete commands.
set number " Line numbers.
if exists('+relativenumber')
    set relativenumber " Show relative numbers in gutter.
endif
" Terminal specific settings
augroup terminal
    " Disable line numering for terminals.
    if exists('+relativenumber')
        autocmd TermOpen * setlocal nonumber norelativenumber
        autocmd TermEnter * setlocal nonumber norelativenumber
    else
        autocmd TermOpen * setlocal nonumber
        autocmd TermEnter * setlocal nonumber
    endif
augroup END
set cursorline " Highlight current line.
highlight CursorLineNr ctermbg=18 ctermfg=white cterm=bold
set report=0  " Report number of lines changed for all changes.
set showmatch " Show matching brackets.
set noshowmode " Don't show current mode (is shown in airline bar anyway).
set whichwrap=b,h,l,s,<,>,[,] " Allow <BS>/h/l/<left>,<right>/<space>, to cross line boundries.
set list " Display whitespace charactes
set listchars=eol:↩
set listchars+=tab:⬤●
set listchars+=trail:◯
if has('windows')
    set splitbelow " Open horizontal splits below current window.
endif

if has('vertsplit')
    set splitright " Open vertical splits to right of current window.
endif

if has('virtualedit')
    set virtualedit=block "Allow cursor to move where there is no text in visual blockmode (stops cursor getting trapped in empty columns).
endif

set shortmess+=I "Remove splashscreen.

if exists('+colorcolumn')
    " Highlight up to 255 columns (this is the current Vim max) beyond 
    " 'text width'
    let &colorcolumn='+' . join(range(0, 254), ',+')
endif

" Remove banner from netrw file explorer (can be manually enabled with I).
let g:netrw_banner = 0
" Default to tree display.
let g:netrw_liststyle = 3
"}}}
" Backup/Swapfiles/Undo/Viminfo {{{
" =====================
" Backup files {{{
" ============
"
if exists('$SUDO_USER') " Check whether we are editing as sudoer.
 set nobackup " If we are don't creat backups
 set nowritebackup " or backups during writing to a file since they won't be able to be opened by non sudoers.
else
    " Back up directories are appended to list in the following order and the
    " first on found is used.
    " Keep backup files out of the way.
    set backupdir=~/.vim/tmp/backup//
    set backupdir+=. " Use pwd as last resort so backups stay out of the way.
    set backup
    set writebackup
    set backupcopy=yes
endif
" }}}
" Swapfiles {{{
" =========
if exists('$SUDO_USER')
 set noswapfile
else
    " Keep swapfiles out of the way.
    set directory=~/local/.vim/tmp/swap//
    set directory+=~/.vim/tmp/swap//
    set directory+=.
    " Note: // avoids naming conflicts by using absolute paths.
endif
" }}}
" Undo {{{
" ====
if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile
    else
        set undodir=~/local/.vim/tmp/undo//
        set undodir+=~/.vim/tmp/undo//
        set undodir+=.
        set undofile " Actually use undo files.
    endif
endif
" }}}
" Viminfo {{{
" =======
if has('viminfo')
    if exists('$SUDO_USER')
        set viminfo= " For sudors don't create viminfos for same reasons as above (can't be accessed after by normal users)
    else
        if isdirectory('~/local/.vim/tmp')
            set viminfo+=n~/local/.vim/tmp/viminfo// "n is the name of the vim info file.
        else
            set viminfo+=n~/.vim/tmp/viminfo//
        endif

        " Check if it is possible to read the viminfo file and display a
        " warning if it isn't.
        if !empty(glob('~/.vim/tmp/viminfo'))
            if !filereadble(expand('~/.vim/tmp/viminfo))
                echoerr 'warning: ~/.vim/tmp/viminfo exists but is not readable'
            endif
        endif
    endif
endif

" }}}
" Mksession {{{
" =========
if has('mksession') "mksession files are used to save the state of sessions e.g. viewports and tabs.
    if isdirectory('~/local/.vim/tmp')
        set viewdir=~/local/.vim/tmp/view//
    else
        set viewdir=~/.vim/tmp/view//
    endif
    set viewoptions=cursor,folds
endif
" }}}
" }}}
" Buffers {{{
" =======
set hidden "Keep buffers in background without need to save them.
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
" History {{{
" =======
set history=1000 " Set length of command history.
" }}}
" Indentation {{{
" ===========
set autoindent " Maintain indent of current line.
" }}}
" Modelines {{{
" =========
" Debian, Ubuntu, Gentoo, OSX, etc. by default disable modelines for security reasons.
set modeline
set modelines=5
" }}}
" Scrolling {{{
" =========
set scrolloff=5            " Keep a minimum of 5 line below the cursor.
set sidescrolloff=5        " Keep a minimum of 5 columns left of the cursor.
if has('linebreak')
    set breakindent " Indent wrapped lines to match indentation of line they wrapped from.
    if exists('&breakindentopt')
        set breakindentopt=shift:2 " Emphasize broken lines by indenting them.
    endif
endif
" }}}
" Searching {{{
" =========
set hlsearch        " Highlight matches.
" Search results should be white and underline, none of that gross yellow.
highlight Search ctermbg=black ctermfg=white cterm=bold
highlight IncSearch ctermbg=black ctermfg=white cterm=bold
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
if has('wildmenu')
    set wildmode=longest,list,full
    set wildmenu
endif
 " Patterns to ignore during file-navigation.
 if has('wildignore')
     set wildignore+=*.o
 endif
" }}}
if exists('&bellof')
    set belloff=all " Never ring the bell for any reason.
endif
set expandtab "Always use spaces.
set mouse=a " Enable mouse.
" vim: foldenable foldmethod=marker foldlevel=0 ts=4 sts=4 sw=4
