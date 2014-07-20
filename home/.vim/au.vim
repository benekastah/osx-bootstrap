
augroup paulh
    autocmd!

    " handlebars
    autocmd BufNewFile,BufRead,BufFilePost *.handlebars :set ft=mustache

    " Salt
    autocmd BufNewFile,BufRead,BufFilePost *.sls :set ft=yaml

    " Clean up smartindent behavior for non-c files
    let cFileTypes = ['c', 'c++', 'objc']
    autocmd BufWritePre * if index(cFileTypes, &ft) < 0 | inoremap <buffer> # X#| endif

    let textFileTypes = ['text', 'html', 'markdown']
    autocmd BufNewFile,BufRead,BufFilePost * if index(textFileTypes, &ft) > 0 | setlocal spell spelllang=en_us | endif

    autocmd BufNewFile,BufRead,BufFilePost * if index(textFileTypes, &ft) > 0 | setlocal wrap | endif

    " Diet templates
    autocmd BufNewFile,BufRead,BufFilePost *.dt :set ft=jade

    autocmd BufNewFile,BufRead,BufFilePost *.h,*.cpp :let b:syntastic_cpp_cflags='@g++_opts'

    autocmd BufNewFile,BufRead,BufFilePost *.jison set ft=yacc

    autocmd Filetype go set makeprg=go\ build
augroup END
