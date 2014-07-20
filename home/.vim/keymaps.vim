
nmap <leader>w :w<CR>
nmap <leader>qq :q<CR>
nmap <leader>wq :wq<CR>
nmap <leader>qqa :qa<CR>
nmap <leader>wqa :wqa<CR>

" Window navigation
function! Wincmd(cmd)
    if exists('w:winmax')
        let l:prev_winmax = w:winmax
    else
        let l:prev_winmax = 0
    endif

    exe ":wincmd ".a:cmd

    if &previewwindow || &buftype ==# 'quickfix'
        resize 10
        return
    endif

    if a:cmd ==# '-' || a:cmd ==# '+'
        let t:winmax = 0
        let w:winmax = 0
        return
    endif

    let w:wineq = exists('w:wineq') && w:wineq
    if ((exists('t:winmax') && t:winmax) || (exists('w:winmax') && w:winmax)) && !w:wineq
        :wincmd _
    elseif l:prev_winmax || w:wineq
        :wincmd =
    endif
endfunction

nmap w_ :wincmd _<CR> :let t:winmax = 1<CR> :let w:wineq = 0<CR> :let w:winmax = 0<CR>
nmap w= :wincmd =<CR> :let t:winmax = 0<CR> :let w:wineq = 0<CR> :let w:winmax = 0<CR>
nmap ww_ :wincmd _<CR> :let w:winmax = 1<CR> :let w:wineq = 0<CR>
nmap ww= :wincmd =<CR> :let w:winmax = 0<CR> :let w:wineq = 1<CR>
nmap w- :call Wincmd('-')<CR>
nmap w+ :call Wincmd('+')<CR>
nmap wh :call Wincmd('h')<CR>
nmap wj :call Wincmd('j')<CR>
nmap wk :call Wincmd('k')<CR>
nmap wl :call Wincmd('l')<CR>

" Tab navigation
nmap tl :tabn<CR>
nmap th :tabp<CR>

" Buffer navigatior
map <C-l> :bn<CR>
map <C-h> :bp<CR>
map <C-j> :b#<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" OSX Clipboard
map <leader>y "*y:call system("pbcopy", @*)<CR>
nmap <leader>p :let @* = substitute(system("pbpaste"), "\n\$", "", "")<CR>"*p

" Merge helpers
" Find the next merge section
nmap <leader>ml :exe "/<<<<<<<\\\|=======\\\|>>>>>>>"<CR>
nmap <leader>mh :exe "?<<<<<<<\\\|=======\\\|>>>>>>>"<CR>

vmap * :<C-u>exe '/'.GetVisualSelection()<CR>
vmap <leader>* :<C-u>call AgLiteral(GetVisualSelection())<CR>
nmap <leader>* *N:call ag#AgFromSearch('grep', '')<CR>

" Syntastic
nmap <leader>e :SyntasticCheck<CR>
nmap <leader>eh :lnext<CR>
nmap <leader>el :lprev<CR>

" Clear search
nmap <leader>/ :let @/ = ""<CR>

nmap <leader>rg :EditRelatedFilesGit<CR>
nmap <leader>rs :EditRelatedFilesName<CR>
