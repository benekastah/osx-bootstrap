" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
set runtimepath+=$HOME/dev/git-related  " Remove once it is ready for vundle to install

" ================ General Config ====================

set number                      "Line numbers are good
set relativenumber              "Relative line numbers are also good
set colorcolumn=80              "Show me column 80, plz
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set ruler
set nrformats=octal,hex,alpha
if !has('nvim')
    set cryptmethod=blowfish
endif
set cursorline
set tags=./tags;/,tags;/
set hlsearch
set incsearch

" Change cursor style when entering INSERT mode (works in tmux!)
" Thanks to http://vimrcfu.com/snippet/15
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" This makes vim act like all other editors, buffers can exist in the
" background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on
set synmaxcol=1000

" Leaders
let mapleader="\<Space>"
let maplocalleader='\'

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundle.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
    source ~/.vim/vundles.vim
endif

if filereadable(expand("~/.vim/utils.vim"))
    source ~/.vim/utils.vim
endif

" ================ Colors ========================
set background=dark
set t_Co=256
colorscheme solarized

" ================ Swap Files etc. ==============

silent !mkdir ~/.vim/.backup > /dev/null 2>&1
set backupdir=~/.vim/.backup//
set backup

silent !mkdir ~/.vim/.swp > /dev/null 2>&1
set directory=~/.vim/.swp//
set swapfile

silent !mkdir ~/.vim/.undo > /dev/null 2>&1
set undodir=~/.vim/.undo//
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=manual
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.so,*.dylib,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc,*.pyo,*.pyd,*.egg-info/**,*.egg,develop-eggs/**,__pycache__/**,.Python

" ================ scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins

" ================ Syntastic ========================
" let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_python_checkers = ['pep8', 'pyflakes']
let g:syntastic_python_checkers_full = ['pep8', 'pyflakes', 'pylint']
let g:syntastic_javascript_checkers = ['jshint', 'eslint']
let g:syntastic_c_checkers = ['make']
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = 'E>'

" ================ Neomake ========================
" let g:neomake_open_list = 1
let g:neomake_python_enabled_makers = ['pylint', 'pep8']

" Tortoise Typing
let g:tortoiseTypingKeyLog = $HOME.'/.typing_keys'
let g:tortoiseTypingResultLog = $HOME.'/.typing_tests'

" Vimux config
let g:vimuxHeight = "10"

" RunSqlQuery config
let g:sqlCommand = 'psql'

" ================ Statusline ========================
function! Statusline()
    set noruler
    set laststatus=2

    set statusline=

    set statusline+=%#tag#%{fugitive#statusline()}\      " git statusline
    set statusline+=%#number#%1.3n:%#underlined#%-f\     " Current file name
    set statusline+=%#comment#%y                         " Label
    set statusline+=%*%h%m%r%w                           " File modification info

    set statusline+=%=                                   " Switch to right side
    set statusline+=%#comment#%l,%c%V                    " Line and column info
    set statusline+=\ \ \                                " Separator
    set statusline+=%#comment#%P                         " Percentage through file of displayed window
endfunction
call Statusline()

" ================ Tern ========================
" let tern#command = ['tern', '--no-port-file']

" D
let g:syntastic_d_compiler = "$HOME/bin/dub-syntastic"
" let g:syntastic_d_dmd_exec = "dub"
" let g:syntastic_d_dmd_args = "build --quiet"

let g:haddock_browser = ""


" Allows writing to readonly files
command! -bang Write exe 'w !' . ('<bang>' ==# '!' ? 'sudo ' : '') . 'tee %'


if filereadable(expand("~/.vim/keymaps.vim"))
    source ~/.vim/keymaps.vim
endif

if filereadable(expand("~/.vim/sessions.vim"))
    source ~/.vim/sessions.vim
endif

if filereadable(expand("~/.vim/au.vim"))
    source ~/.vim/au.vim
endif

" if filereadable(expand("~/.vim/ranger.vim"))
"     source ~/.vim/ranger.vim
" endif

let g:project_local_vimrc = FindFileBackward('.project.vim')
if filereadable(g:project_local_vimrc)
    execute 'source ' . g:project_local_vimrc
    let g:last_toggled_background = get(g:, 'last_toggled_background', '')
    " Toggle back to the last toggled version
    if len(g:last_toggled_background) && g:last_toggled_background != &background
        :ToggleBG
    endif
endif
