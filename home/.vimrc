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
set smartcase
set nrformats=octal,hex,alpha
set cursorline
set tags=./tags;/,tags;/
set hlsearch

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader="\<Space>"

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundle.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
    source ~/.vim/vundles.vim
endif

" ================ Colors ========================
set background=dark
set t_Co=256
colorscheme solarized
call togglebg#map("<F5>")

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
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

set foldmethod=indent   "fold based on indent
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
let g:syntastic_python_checkers = ['pylint', 'pep8']
" let g:syntastic_python_pylint_exe = 'pylint-vim'
" let g:syntastic_python_pep8_exe = 'pep8-vim'
let g:syntastic_python_pylint_exe = 'pylint'
let g:syntastic_python_pep8_exe = 'pep8'
let g:syntastic_javascript_checkers = ['jshint', 'eslint']
let g:syntastic_c_checkers = ['make']
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = 'E>'

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
let tern#command = ['tern', '--no-port-file']

" D
let g:syntastic_d_compiler = "$HOME/bin/dub-syntastic"
" let g:syntastic_d_dmd_exec = "dub"
" let g:syntastic_d_dmd_args = "build --quiet"


" Utility functions
function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction
command! GetVisualSelection echo GetVisualSelection()

function! s:findFileBackward(path, filename)
    let file = a:filename
    let path = a:path
    if !strlen(path)
        let path = '.'
    endif
    while !filereadable(file)
        if path ==# '/'
            return ''
        endif
        let path = system('cd '.shellescape(path.'/..').' && echo -n $PWD')
        let file = path.'/'.a:filename
    endwhile
    return file
endfunction

function! FindFileBackward(filename)
    " Try to resolve the file from the current buffer first
    let file = s:findFileBackward(expand('%:h'), a:filename)
    if !strlen(file)
        " Try to resolve the file from the cwd
        return s:findFileBackward(getcwd(), a:filename)
    endif
    return file
endfunction


function! AgLiteral(term)
    let term = substitute(escape(a:term, '\'), '\n', '\\n', 'g')
    call ag#Ag('grep', '-Q '.term)
endfunction
command! -nargs=* Agq call AgLiteral(<q-args>)


if filereadable(expand("~/.vim/keymaps.vim"))
    source ~/.vim/keymaps.vim
endif

if filereadable(expand("~/.vim/sessions.vim"))
    source ~/.vim/sessions.vim
endif

if filereadable(expand("~/.vim/au.vim"))
    source ~/.vim/au.vim
endif

if filereadable(expand("~/.vim/ranger.vim"))
    source ~/.vim/ranger.vim
endif

let g:project_local_vimrc = FindFileBackward('.project.vim')
if filereadable(g:project_local_vimrc)
    execute 'source ' . g:project_local_vimrc
endif
