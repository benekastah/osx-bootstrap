
augroup paulh
    autocmd!

    " handlebars
    autocmd BufNewFile,BufRead,BufFilePost *.handlebars :set ft=mustache

    " Salt
    autocmd BufNewFile,BufRead,BufFilePost *.sls :set ft=yaml

    " Clean up smartindent behavior for non-c files
    let cFileTypes = ['c', 'c++', 'objc']
    autocmd BufNewFile,BufRead,BufFilePost * if index(cFileTypes, &ft) < 0 | set cindent | endif

    let textFileTypes = ['text', 'html', 'markdown']
    autocmd BufNewFile,BufRead,BufFilePost * if index(textFileTypes, &ft) > 0 | setlocal spell spelllang=en_us | endif

    autocmd BufNewFile,BufRead,BufFilePost * if index(textFileTypes, &ft) > 0 | setlocal wrap | endif

    autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=ghmarkdown

    autocmd BufNewFile,BufRead,BufFilePost *.json :set ft=json
    autocmd FileType json runtime! syntax/javascript.vim

    " Diet templates
    autocmd BufNewFile,BufRead,BufFilePost *.dt :set ft=jade

    autocmd BufNewFile,BufRead,BufFilePost *.h,*.cpp :let b:syntastic_cpp_cflags='@g++_opts'

    autocmd BufNewFile,BufRead,BufFilePost *.jison set ft=yacc

    autocmd Filetype go set makeprg=go\ build

    autocmd Filetype rust set makeprg=cargo\ build

    autocmd Filetype haskell set makeprg=~/Library/Haskell/bin/cabal\ build
    autocmd Filetype cabal set makeprg=~/Library/Haskell/bin/cabal\ build
    " See http://hackage.haskell.org/package/hothasktags
    " autocmd Filetype haskell set iskeyword=a-z,A-Z,_,.,39

    autocmd Filetype python :let b:indentNoEndDelimiter = 1

    autocmd VimLeave * :VimuxCloseRunner
augroup END
