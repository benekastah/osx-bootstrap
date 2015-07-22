" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Once you've updated the list of plugin, you can run vundle update by issuing
" the command :PlugInstall from within vim or directly invoking it from the
" command line with the following syntax:
" vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +PlugClean! +PlugInstall +qall
" Filetype off is required by vundle
filetype off

" Local plugins
if len(glob('`ls -d ~/Tortoise-Typing`'))
    set rtp+=~/Tortoise-Typing
endif

" set rtp+=~/.vim/bundle/Vundle.vim/

if has('nvim')
    runtime! python_setup.vim
endif

" Install neobundle if needed
call system('test -d ~/.vim/bundle/neobundle.vim')
if v:shell_error
    echom system('mkdir -p ~/.vim/bundle')
    echom system('git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim')
endif

if has('vim_starting')
    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" let Vundle manage Vundle (required)
" NeoBundle 'gmarik/Vundle.vim'


" ========================================
" Vim utilities that may be used by other plugins
" ========================================
NeoBundle 'vim-misc'

" ========================================
" Added functionality
" ========================================
NeoBundle 'xolox/vim-session'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-fugitive'
" A plugin which makes swapping of text in Vim easier
NeoBundle 'kurkale6ka/vim-swap'

" ========================================
" General text editing improvements...
" ========================================
NeoBundle 'tomtom/tcomment_vim'

if len(glob("`ls -d ~/.vim/dev/neomake`"))
    " set rtp+=~/.vim/dev/neomake
    " helptags ~/.vim/dev/neomake/doc
    NeoBundle '~/.vim/dev/neomake'
else
    NeoBundle 'benekastah/neomake'
    " NeoBundle 'scrooloose/syntastic'
endif

NeoBundle 'skwp/vim-colors-solarized'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'michaeljsmith/vim-indent-object'

" ========================================
" Language/syntax bundles
" ========================================
NeoBundle 'jdonaldson/vaxe'
NeoBundle 'wting/rust.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
" NeoBundle 'git://github.com/jsx/jsx.vim.git'
NeoBundle 'kchmck/vim-coffee-script'
" Provides ghmarkdown (github-flavored markdown)
NeoBundle 'jtratner/vim-flavored-markdown'
" Faster yaml syntax files
NeoBundle 'stephpy/vim-yaml'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'idris-hackers/idris-vim'
NeoBundle 'derekwyatt/vim-scala'
" syntax, indent, and filetype plugin files for git, gitcommit, gitconfig,
" gitrebase, and gitsendemail.
NeoBundle 'tpope/vim-git'
NeoBundle 'tejr/vim-tmux'
NeoBundle 'glsl.vim'

" ========================================
" Trying before buying...
" ========================================
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'benmills/vimux'

" ========================================
" Shits and giggles
" ========================================
" Adventure game
NeoBundle 'katono/rogue.vim'


call neobundle#end()

"Filetype plugin indent on is required by vundle
filetype plugin indent on
