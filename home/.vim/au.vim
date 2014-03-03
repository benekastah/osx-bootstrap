
augroup paulh
  autocmd!

  " handlebars
  autocmd BufNewFile,BufRead,BufFilePost *.handlebars :set ft=mustache

  " Salt
  autocmd BufNewFile,BufRead,BufFilePost *.sls :set ft=yaml

  " Diet templates
  autocmd BufNewFile,BufRead,BufFilePost *.dt :set ft=jade

  autocmd BufNewFile,BufRead,BufFilePost *.h,*.cpp :let b:syntastic_cpp_cflags='@g++_opts'

  autocmd FileType go set makeprg="go install"

  " Clean up smartindent behavior for non-c files
  let cFileTypes = ['c', 'c++', 'objc']
  autocmd BufWritePre * if index(cFileTypes, &ft) < 0 | inoremap <buffer> # X#
augroup END
