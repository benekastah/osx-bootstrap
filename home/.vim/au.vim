
augroup paulh
    autocmd!

    " handlebars
    autocmd BufNewFile,BufRead,BufFilePost *.handlebars :set ft=mustache

    " Salt
    autocmd BufNewFile,BufRead,BufFilePost *.sls :set ft=yaml

    " Clean up smartindent behavior for non-c files
    let cFileTypes = ['c', 'c++', 'objc']
    autocmd BufNewFile,BufRead,BufFilePost * if index(cFileTypes, &ft) < 0 | set cindent | endif

    autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=ghmarkdown

    let textFileTypes = ['text', 'html', 'markdown', 'ghmarkdown']
    autocmd BufNewFile,BufRead,BufFilePost * if index(textFileTypes, &ft) > 0 | setlocal spell spelllang=en_us | endif

    autocmd BufNewFile,BufRead,BufFilePost * if index(textFileTypes, &ft) > 0 | setlocal wrap | endif

    autocmd BufNewFile,BufRead,BufFilePost *.json :set ft=json
    autocmd FileType json runtime! syntax/javascript.vim

    " Diet templates
    autocmd BufNewFile,BufRead,BufFilePost *.dt :set ft=jade

    autocmd BufNewFile,BufRead,BufFilePost *.h,*.cpp :let b:syntastic_cpp_cflags='@g++_opts'

    autocmd BufNewFile,BufRead,BufFilePost *.jison set ft=yacc

    autocmd Filetype go set makeprg=go\ build

    autocmd Filetype rust set makeprg=cargo\ build

    autocmd Filetype haskell set makeprg=~/Library/Haskell/bin/cabal\ build

    autocmd Filetype python :let b:indentNoEndDelimiter = 1
    autocmd Filetype python let &makeprg='pylint -f text --msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}" -r n'
    " Error format for pylint
    set errorformat+=%f:%l:%c:%t:\ %m
    set errorformat+=%f:%l:\ %m
    set errorformat+=%f:(%l):\ %m

    autocmd VimLeave * :VimuxCloseRunner

    " YCM
    autocmd FileType * let g:ycm_auto_trigger = 0
    autocmd FileType c,cpp,objc,objcpp,python,cs let g:ycm_auto_trigger = 1
    autocmd Filetype c,cpp,objc,objcpp,python,cs nnoremap <buffer> <C-]> :YcmCompleter GoTo<CR>
augroup END
