
augroup paulh
  autocmd!

  " handlebars
  autocmd BufNewFile,BufRead,BufFilePost *.handlebars :set ft=mustache

  " Salt
  autocmd BufNewFile,BufRead,BufFilePost *.sls :set ft=yaml

  " Clean up smartindent behavior for non-c files
  let cFileTypes = ['c', 'c++', 'objc']
  autocmd BufWritePre * if index(cFileTypes, &ft) < 0 | inoremap <buffer> # X#
augroup END
