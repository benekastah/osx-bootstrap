
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

" Window navigation
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

vmap ff :<C-u>exe ':Ag -Q '''.substitute(GetVisualSelection(), "'", "''", "")."'"<CR>

" " Syntastic
" nmap wce :w <bar> SyntasticCheck<CR>
" nmap ce :SyntasticCheck<CR>
" nmap <C-e>l :lnext<CR>
" nmap <C-e>h :lprev<CR>
