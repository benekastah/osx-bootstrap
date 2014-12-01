" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Once you've updated the list of plugin, you can run vundle update by issuing
" the command :BundleInstall from within vim or directly invoking it from the
" command line with the following syntax:
" vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
" Filetype off is required by vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/

if has('nvim')
    runtime! python_setup.vim
endif

call vundle#begin()

" let Vundle manage Vundle (required)
Bundle "gmarik/Vundle.vim"


" ========================================
" Vim utilities that may be used by other plugins
" ========================================
Bundle 'vim-misc'

" ========================================
" Added functionality
" ========================================
Bundle 'xolox/vim-session'
Bundle "airblade/vim-gitgutter"
Bundle 'moll/vim-bbye'
Bundle "tpope/vim-fugitive"
" A plugin which makes swapping of text in Vim easier
Bundle "kurkale6ka/vim-swap"

" ========================================
" General text editing improvements...
" ========================================
Bundle "tomtom/tcomment_vim.git"
Bundle "rking/ag.vim"

" Always do neomake for now
if len(glob("`ls -d ~/.vim/dev/neomake`"))
    set rtp+=~/.vim/dev/neomake
    helptags ~/.vim/dev/neomake/doc
    " Bundle 'file:///'.expand('~/.vim/dev/neomake')
else
    Bundle "benekastah/neomake"
    " Bundle "scrooloose/syntastic.git"
endif

Bundle "skwp/vim-colors-solarized"
Bundle "kien/ctrlp.vim"
Bundle "SirVer/ultisnips"
Bundle "michaeljsmith/vim-indent-object"

" ========================================
" Language/syntax bundles
" ========================================
Bundle "jdonaldson/vaxe"
Bundle "wting/rust.vim"
Bundle "pangloss/vim-javascript"
Bundle "kchmck/vim-coffee-script"
" Provides ghmarkdown (github-flavored markdown)
Bundle "jtratner/vim-flavored-markdown.git"
" Faster yaml syntax files
Bundle "stephpy/vim-yaml"
Bundle "mustache/vim-mustache-handlebars"
Bundle 'lukerandall/haskellmode-vim'
Bundle "derekwyatt/vim-scala"
" syntax, indent, and filetype plugin files for git, gitcommit, gitconfig,
" gitrebase, and gitsendemail.
Bundle "tpope/vim-git"

" ========================================
" Trying before buying...
" ========================================
" Bundle "benmills/vimux"
" Dispatch may replace vimux
Bundle "tpope/vim-dispatch"
" Bundle "ap/vim-buftabline"

" ========================================
" Shits and giggles
" ========================================
" Adventure game
Bundle "katono/rogue.vim"


call vundle#end()

"Filetype plugin indent on is required by vundle
filetype plugin indent on
