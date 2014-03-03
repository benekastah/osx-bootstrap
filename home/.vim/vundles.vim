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

" Benekastah's plugins
" Bundle 'benekastah/mysql.vim'
" Bundle 'sophacles/vim-bundle-mako'
"   Bundle 'indenthtml.vim'
"   Bundle 'python.vim'
"   Bundle 'ocim/htmlmako.vim'
Bundle 'xolox/vim-session'
" Bundle 'slimv.vim'
" Bundle 'cscope.vim'
" Bundle 'lid.vim'
" Bundle 'jceb/vim-orgmode'
"   Bundle 'tpope/vim-speeddating'
"   Bundle 'utl.vim'
" Bundle 'sontek/rope-vim'
Bundle 'ack.vim'
" Bundle "flazz/vim-colorschemes"
Bundle "marijnh/tern_for_vim"
" Bundle "Shougo/unite.vim"
Bundle "airblade/vim-gitgutter"
Bundle 'wlangstroth/vim-racket'
Bundle 'lukerandall/haskellmode-vim'
" Bundle 'takac/vim-hardtime'
Bundle 'moll/vim-bbye'
" Bundle 'jaxbot/brolink.vim'

" Bundle "Raimondi/delimitMate"

" Javascript
Bundle "briancollins/vim-jst"
Bundle "pangloss/vim-javascript"

" Html, Xml, Css, Markdown, Yaml...
" Bundle "aaronjensen/vim-sass-status.git"
" Bundle "groenewege/vim-less.git"
Bundle "itspriddle/vim-jquery.git"
Bundle "tpope/vim-markdown"
Bundle "jtratner/vim-flavored-markdown.git"
Bundle "kchmck/vim-coffee-script"
" Bundle "kogakure/vim-sparkup.git"
" Bundle "skwp/vim-html-escape"
" Bundle "tpope/vim-haml"
" Bundle "wavded/vim-stylus"
Bundle "stephpy/vim-yaml"
Bundle "mustache/vim-mustache-handlebars"
Bundle "digitaltoad/vim-jade"

" D
Bundle "d.vim"

" Git related...
Bundle "gregsexton/gitv"
Bundle "tjennings/git-grep-vim"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-git"

" " General text editing improvements...
" Bundle "AndrewRadev/splitjoin.vim"
" Bundle "Shougo/neocomplete.vim"
" Bundle "garbas/vim-snipmate.git"
" Bundle "honza/vim-snippets"
" Bundle "godlygeek/tabular"
Bundle "nelstrom/vim-visual-star-search"
Bundle "tomtom/tcomment_vim.git"
" Bundle "vim-scripts/IndexedSearch"
" Bundle "vim-scripts/matchit.zip.git"
" Bundle "terryma/vim-multiple-cursors"
" Bundle "bogado/file-line.git"
" Bundle "jistr/vim-nerdtree-tabs.git"
" Bundle "scrooloose/nerdtree.git"
" Bundle "mattn/webapi-vim.git"
" Bundle "MarcWeber/vim-addon-mw-utils.git"
Bundle "rking/ag.vim"
Bundle "scrooloose/syntastic.git"
" Bundle "skwp/greplace.vim"
Bundle "tpope/vim-endwise.git"
" Bundle "tpope/vim-repeat.git"
" Bundle "tpope/vim-surround.git"
" Bundle "vim-ruby/vim-ruby.git"
Bundle "skwp/vim-colors-solarized"
" Bundle "vim-scripts/AutoTag.git"
" Bundle "vim-scripts/sudo.vim"
" Bundle "xsunsmile/showmarks.git"
" Bundle "vim-scripts/AnsiEsc.vim.git"
" Bundle "hynek/vim-python-pep8-indent"
Bundle "bkad/CamelCaseMotion"
Bundle "majutsushi/tagbar"

" " Text objects
" Bundle "austintaylor/vim-indentobject"
" Bundle "kana/vim-textobj-user"
" Bundle "nathanaelkane/vim-indent-guides"
" Bundle "chrisbra/color_highlight.git"
" Bundle "skwp/vim-powerline.git"
" Bundle "vim-scripts/TagHighlight.git"

"Filetype plugin indent on is required by vundle
filetype plugin indent on
