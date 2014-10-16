
nnoremap <leader>w :w<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>qqa :qa<CR>
nnoremap <leader>wqa :wqa<CR>

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

nnoremap w_ :wincmd _<CR> :let t:winmax = 1<CR> :let w:wineq = 0<CR> :let w:winmax = 0<CR>
nnoremap w= :wincmd =<CR> :let t:winmax = 0<CR> :let w:wineq = 0<CR> :let w:winmax = 0<CR>
nnoremap ww_ :wincmd _<CR> :let w:winmax = 1<CR> :let w:wineq = 0<CR>
nnoremap ww= :wincmd =<CR> :let w:winmax = 0<CR> :let w:wineq = 1<CR>
nnoremap w- :call Wincmd('-')<CR>
nnoremap w+ :call Wincmd('+')<CR>
nnoremap wh :call Wincmd('h')<CR>
nnoremap wj :call Wincmd('j')<CR>
nnoremap wk :call Wincmd('k')<CR>
nnoremap wl :call Wincmd('l')<CR>

" Buffer navigatior
noremap <C-l> :bn<CR>
noremap <C-h> :bp<CR>

" Merge helpers
" Find the next merge section
nnoremap <leader>ml :exe "/<<<<<<<\\\|=======\\\|>>>>>>>"<CR>
nnoremap <leader>mh :exe "?<<<<<<<\\\|=======\\\|>>>>>>>"<CR>

vnoremap * :<C-u>exe '/'.GetVisualSelection()<CR>
vnoremap <leader>* :<C-u>call AgLiteral(GetVisualSelection())<CR>
nnoremap <leader>* *N:call ag#AgFromSearch('grep', '')<CR>

" Syntastic
nnoremap <leader>e :SyntasticCheck<CR>
nnoremap <leader>eh :lnext<CR>
nnoremap <leader>el :lprev<CR>

" Clear search
nnoremap <leader>/ :let @/ = ""<CR>

nnoremap <leader>rg :EditRelatedFilesGit<CR>
nnoremap <leader>rs :EditRelatedFilesName<CR>

" Errors
nnoremap <leader>ck :cnext<CR>
nnoremap <leader>cj :cprev<CR>

" Sort
function! SortLines(type, ...)
    let visual_mode = a:0
    let sort_line_args = ""
    if exists('g:sort_lines_default_args')
        let sort_line_args = g:sort_lines_default_args
    endif
    let cmd = ""
    if visual_mode
        let cmd .= "'<,'>"
    else
        let cmd .= "'[,']"
    endif
    let cmd .= "sort " . sort_line_args
    exe cmd
endfunction

nnoremap <leader>s :set opfunc=SortLines<CR>g@
vnoremap <leader>s :<C-U>call SortLines(visualmode(), 1)<CR>

" Indent text object. See http://vim.wikia.com/wiki/Indent_text_object
onoremap <silent>ai :<C-U>call <SID>IndTxtObj(0)<CR>
onoremap <silent>ii :<C-U>call <SID>IndTxtObj(1)<CR>
vnoremap <silent>ai :<C-U>call <SID>IndTxtObj(0)<CR><Esc>gv
vnoremap <silent>ii :<C-U>call <SID>IndTxtObj(1)<CR><Esc>gv

nnoremap <leader>[ :<C-U>call <SID>GoToIndStart(1)<CR>
onoremap <leader>] :<C-U>call <SID>GoToIndEnd(1)<CR>
nnoremap <leader>{ :<C-U>call <SID>GoToIndStart(0)<CR>
nnoremap <leader>} :<C-U>call <SID>GoToIndEnd(0)<CR>

function! <SID>IndLevel(lineno, default)
    if g:LineIsBlank(a:lineno)
        return a:default
    else
        return indent(a:lineno)
    endif
endfunction

function! g:NextNonBlankLine()
    let search = @/
    try
        exe '/^\s*\S'
    catch
        normal! gg
    endtry
    let @/ = search
endfunction

function! g:PrevNonBlankLine()
    let search = @/
    try
        exe '?^\s*\S'
    catch
        normal! G
    endtry
    let @/ = search
endfunction

function! g:LineIsBlank(...)
    if a:0
        let ln = a:1
    else
        let ln = '.'
    endif
    return getline(ln) =~# '^\s*$'
endfunction

function! <SID>GoToIndStart(inner)
    let i = <SID>ContextualIndent()
    let p = line('.')
    while p >= 1 && <SID>IndLevel(p, i) >= i
        normal! -
        let p = line(".")
        if p ==# 1
            break
        endif
    endwhile
    if a:inner && <SID>IndLevel(p, i) < i
        normal! +
    endif

    if g:LineIsBlank()
        call g:NextNonBlankLine()
    endif

    normal! 0
endfunction

function! <SID>GoToIndEnd(inner)
    let i = <SID>ContextualIndent()
    let lastline = line('$')
    let n = line('.')
    while n <= lastline && <SID>IndLevel(n, i) >= i
        normal! +
        let n = line(".")
        if n ==# lastline
            break
        endif
    endwhile
    if (a:inner || (exists('b:indentNoEndDelimiter') && b:indentNoEndDelimiter)) && <SID>IndLevel(n, i) < i
        normal! -
    endif

    if g:LineIsBlank()
        call g:PrevNonBlankLine()
    endif

    normal! $
endfunction

function! <SID>ContextualIndent(...)
    let curline = line('.')
    let curcol = col('.')
    if a:0
        let ln = a:1
    else
        let ln = curline
    endif

    let i = indent(ln)
    if g:LineIsBlank(ln)
        call g:NextNonBlankLine()
        let i = indent(line('.'))
        call cursor(curline, curcol)
    endif

    return i
endfunction

" TODO refactor so this doesn't use visual mode?
function! <SID>IndTxtObj(inner)
    let curline = line('.')
    let curcol = col('.')
    call <SID>GoToIndEnd(a:inner)
    normal! $V
    call cursor(curline, curcol)
    call <SID>GoToIndStart(a:inner)
    normal! 0
endfunction

" Vimux
nnoremap <leader>vl :VimuxRunLastCommand<CR>
nnoremap <leader>vc :VimuxRunCommand 'clear'<CR>
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vq :VimuxCloseRunner<CR>
nnoremap <Leader>vx :VimuxInterruptRunner<CR>
nnoremap <Leader>vz :call VimuxZoomRunner()<CR>
nnoremap <leader>pl :call PylintFile()<CR>

function! PylintFile(...)
    if a:0 && len(a:0)
        let file = a:file
    else
        let file = '%'
    endif
    :VimuxRunCommand 'pylint '.expand(file)
endfunction

" Sql tester
nnoremap <leader>sq :call RunSqlQuery()<CR>

function! RunSqlQuery()
python << EOF

import os
import tempfile
import time
import vim

def run_query(sqlFile):
    sqlCmd = vim.eval('b:sqlCommand') if int(vim.eval('exists("b:sqlCommand")')) else vim.eval('g:sqlCommand')
    vim.command('VimuxRunCommand "cat {} | {} | less"'.
        format(sqlFile, sqlCmd))

fname = vim.eval('expand("%")')
if not os.path.exists(fname):
    with tempfile.NamedTemporaryFile() as f:
        f.write('\n'.join(vim.current.buffer))
        f.flush()
        run_query(f.name)
        # This just ensures that cat can read the file before it gets deleted
        time.sleep(0.1)
else:
    run_query(fname)

EOF
endfunction

" Gen tags
let g:gentag_command = 'ctags -R .'
let g:gentag_vimux = exists(':VimuxRunCommand')
function! g:GenTags(...)
    if a:0
        let vimux = a:1
    else
        let vimux = g:gentag_vimux
    endif
    if vimux
        exe ':VimuxRunCommand '.shellescape(g:gentag_command)
    else
        exe '!'.g:gentag_command
    endif
endfunction

nnoremap <leader>gt :call g:GenTags()<CR>
nnoremap <leader>gts :call g:GenTags(0)<CR>
nnoremap <leader>gtv :call g:GenTags(1)<CR>

" Refactoring helpers
nnoremap <leader>" :%s/"\(.\{-}\)"/\="'".substitute(submatch(1), "'", '"', 'g')."'"/gc<CR>
nnoremap <leader>. :%s/\['\(\w\+\)\'\]/.\1/gc<CR>:%s/\["\(\w\+\)\"\]/.\1/gc<CR>


nnoremap <leader>pass :call VimuxPromptPassword()<CR>
function! VimuxPromptPassword()
    call inputsave()
    call VimuxSendText(inputsecret("Enter password: "))
    call inputrestore()
    call VimuxSendKeys("Enter")
endfunction


nnoremap <leader>jd :YcmCompleter GoTo<CR>
