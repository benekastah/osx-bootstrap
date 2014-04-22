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

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle "gmarik/vundle"

" Vim utilities that may be used by other plugins
Bundle 'vim-misc'
Bundle "tomtom/tlib_vim.git"

Bundle 'xolox/vim-session'
Bundle 'ack.vim'
Bundle "marijnh/tern_for_vim"
Bundle "airblade/vim-gitgutter"
Bundle 'wlangstroth/vim-racket'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'moll/vim-bbye'

" SQL
Bundle "mattn/vdbi-vim"
    Bundle "mattn/webapi-vim"

" Javascript
Bundle "briancollins/vim-jst"
Bundle "pangloss/vim-javascript"

" Html, Xml, Css, Markdown, Yaml...
Bundle "itspriddle/vim-jquery.git"
Bundle "tpope/vim-markdown"
Bundle "jtratner/vim-flavored-markdown.git"
Bundle "kchmck/vim-coffee-script"
Bundle "stephpy/vim-yaml"
Bundle "mustache/vim-mustache-handlebars"
Bundle "digitaltoad/vim-jade"
Bundle "matchit.zip"

" D
Bundle "d.vim"

" Git related...
Bundle "gregsexton/gitv"
Bundle "tjennings/git-grep-vim"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-git"

" " General text editing improvements...
Bundle "nelstrom/vim-visual-star-search"
Bundle "tomtom/tcomment_vim.git"
Bundle "rking/ag.vim"
Bundle "scrooloose/syntastic.git"
Bundle "tpope/vim-endwise.git"
Bundle "skwp/vim-colors-solarized"
Bundle "python_match.vim"
Bundle "bkad/CamelCaseMotion"
Bundle "majutsushi/tagbar"

"Filetype plugin indent on is required by vundle
filetype plugin indent on
