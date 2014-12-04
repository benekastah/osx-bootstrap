
" Window navigation
function! Wincmd(cmd)
    if exists('w:winmax')
        let l:prev_winmax = w:winmax
    else
        let l:prev_winmax = 0
    endif

    exe ":wincmd ".a:cmd

    if a:cmd ==# '_'
        let t:winmax = 1
        let w:wineq = 0
        let w:winmax = 0
        return
    elseif a:cmd ==# '='
        let t:winmax = 0
        let w:wineq = 0
        let w:winmax = 0
        return
    endif

    if &previewwindow || &buftype ==# 'quickfix'
        resize 10
        return
    endif

    if a:cmd ==# '-' || a:cmd ==# '+'
        let t:winmax = 0
        let w:winmax = 0
        return
    endif

    if exists('t:winmax') && t:winmax
        :wincmd _
    elseif l:prev_winmax
        :wincmd =
    endif
endfunction

" Override some of the C-w commands for additional features
noremap <C-w>_ :call Wincmd('_')<CR>
noremap <C-w><C-_> :call Wincmd('_')<CR>
noremap <C-w>= :call Wincmd('=')<CR>
noremap <C-w><C-=> :call Wincmd('=')<CR>
noremap <C-w>- :call Wincmd('-')<CR>
noremap <C-w><C--> :call Wincmd('-')<CR>
noremap <C-w>+ :call Wincmd('+')<CR>
noremap <C-w><C-+> :call Wincmd('+')<CR>
noremap <C-w>h :call Wincmd('h')<CR>
noremap <C-w><C-h> :call Wincmd('h')<CR>
noremap <C-w>j :call Wincmd('j')<CR>
noremap <C-w><C-j> :call Wincmd('j')<CR>
noremap <C-w>k :call Wincmd('k')<CR>
noremap <C-w><C-k> :call Wincmd('k')<CR>
noremap <C-w>l :call Wincmd('l')<CR>
noremap <C-w><C-l> :call Wincmd('l')<CR>

" Buffer navigatior
nnoremap <localleader>bp :<C-U>exe 'bp '.v:count1<CR>
nnoremap <localleader>bn :<C-U>exe 'bn '.v:count1<CR>

" Navigate git hunks
nnoremap <localleader>gn :GitGutterNextHunk<CR>
nnoremap <localleader>gp :GitGutterPrevHunk<CR>

" Merge helpers
" Find the next merge section
nnoremap <leader>ml :exe "/<<<<<<<\\\|=======\\\|>>>>>>>"<CR>
nnoremap <leader>mh :exe "?<<<<<<<\\\|=======\\\|>>>>>>>"<CR>
" In vimdiff I often want to write only the current buffer, and quit all
nnoremap <leader>wqa :w<CR>:qa<CR>
nnoremap <leader>wqa! :w!<CR>:qa!<CR>

vnoremap * :<C-u>exe '/'.GetVisualSelection()<CR>
vnoremap <leader>* :<C-u>exe 'Ag -Q '.shellescape(GetVisualSelection())<CR>
nnoremap <leader>* *N:call ag#AgFromSearch('grep', '')<CR>

" Syntastic
" function! SyntasticFullCheck()
"     let checkers_full_name =  'syntastic_' . &ft . '_checkers_full'
"     let old_checkers = -1
"     if exists('g:' . checkers_full_name)
"         let old_checkers = get(b:, 'syntastic_checkers')
"         let b:syntastic_checkers = get(g:, checkers_full_name)
"     endif
"     SyntasticCheck
"     if old_checkers && old_checkers != -1
"         let b:syntastic_checkers = old_checkers
"     elseif old_checkers != -1
"         unlet b:syntastic_checkers
"     endif
" endfunction
" nnoremap <leader>e :call SyntasticFullCheck()<CR>

" Clear search
nnoremap <leader>/ :let @/ = ""<CR>

" Open and close list
nnoremap <leader>w :cwindow<CR>
nnoremap <leader>q :cclose<CR>
nnoremap <localleader>w :lwindow<CR>
nnoremap <localleader>q :lclose<CR>
" Next/prev error
nnoremap <leader>p :cprev<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <localleader>p :lprev<CR>
nnoremap <localleader>n :lnext<CR>
" First/last error
nnoremap <leader><leader>p :cfirst<CR>
nnoremap <leader><leader>n :clast<CR>
nnoremap <localleader><localleader>p :lfirst<CR>
nnoremap <localleader><localleader>n :llast<CR>

" Sort
function! SortLines(type, ...)
    let visual_mode = a:0
    let cmd = ""
    if visual_mode
        let cmd .= "'<,'>"
    else
        let cmd .= "'[,']"
    endif
    let cmd .= "sort " . get(g:, 'sort_lines_default_args', '')
    exe cmd
endfunction

nnoremap <leader>s :set opfunc=SortLines<CR>g@
vnoremap <leader>s :<C-U>call SortLines(visualmode(), 1)<CR>


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

" " Vimux
" nnoremap <leader>vl :VimuxRunLastCommand<CR>
" nnoremap <leader>vc :VimuxRunCommand 'clear'<CR>
" nnoremap <Leader>vp :VimuxPromptCommand<CR>
" nnoremap <Leader>vi :VimuxInspectRunner<CR>
" nnoremap <Leader>vq :VimuxCloseRunner<CR>
" nnoremap <Leader>vx :VimuxInterruptRunner<CR>
" nnoremap <Leader>vz :call VimuxZoomRunner()<CR>
" nnoremap <leader>pl :call PylintFile()<CR>
"
" function! PylintFile(...)
"     if a:0 && len(a:0)
"         let file = a:file
"     else
"         let file = '%'
"     endif
"     :VimuxRunCommand 'pylint '.expand(file)
" endfunction

" Sql tester
nnoremap <leader>sq :call RunSqlQuery()<CR>

function! RunSqlQuery()
python << EOF

import os
import tempfile
import time
import vim

def run_query(sqlFile):
    cmd = '{} < {}'.format(vim.eval('get(b:, "sqlCommand", g:sqlCommand)'),
                           sqlFile)
    if int(vim.eval('get(b:, "sqlUseDispatch", '
                    'get(g:, "sqlUseDispatch", exists(":Dispatch")))')):
        vim.command('Dispatch {}'.format(cmd))
    else:
        makeprg = vim.eval('&makeprg')
        vim.command('let &l:makeprg="{}"'.format(cmd))
        vim.command('make | copen')
        vim.command('let &l:makeprg="{}"'.format(makeprg))

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

let s:shell_cmd_id = 0
function! ShellCommand(cmd, ...)
    let quiet = a:0 && a:1
    if has('nvim')
        let jobname = 'ShellCommand'.s:shell_cmd_id
        let s:shell_cmd_id += 1
        let job = jobstart(jobname, &shell, ['-c', a:cmd])
        if !quiet
            function! JobHandler()
                if index(['stdout', 'stderr'], v:job_data[1]) >= 0
                    echom v:job_data[2]
                else
                    exe 'au! '.jobname
                endif
            endfunction
            exe 'augroup '.jobname.' | augroup END'
            exe 'au '.jobname.' JobActivity '.jobname.' call JobHandler()'
        endif
    elseif exists(':Start')
        if quiet
            let prefix = ':Start!'
        else
            let prefix = ':Start'
        endif
        exe prefix.' '.a:cmd
    else
        if quiet
            call system(a:cmd)
        else
            exe '!'.a:cmd
        endif
    endif
endfunction

" Gen tags
if !exists('g:neomake_ctags_maker')
    let g:neomake_ctags_maker = {'args': ['-R']}
endif
nnoremap <leader>gt :Neomake! ctags<CR>

" Refactoring helpers
nnoremap <leader>" :%s/"\(.\{-}\)"/\="'".substitute(submatch(1), "'", '"', 'g')."'"/gc<CR>
nnoremap <leader>. :%s/\['\(\w\+\)\'\]/.\1/gc<CR>:%s/\["\(\w\+\)\"\]/.\1/gc<CR>


" nnoremap <leader>pass :call VimuxPromptPassword()<CR>
" function! VimuxPromptPassword()
"     call inputsave()
"     call VimuxSendText(inputsecret("Enter password: "))
"     call inputrestore()
"     call VimuxSendKeys("Enter")
" endfunction


" Solarized toggle light/dark
function! ToggleBGPersist()
    :ToggleBG
    let comment = 'Automatically added by ToggleBGPersist'
    let setvar = 'let g:last_toggled_background = "' . &background . '"'
    if len(get(g:, 'project_local_vimrc', ''))
        let ed_cmd = 'ed -s ' . shellescape(g:project_local_vimrc)
        let cmd = ed_cmd . " <<< $'1,$s/let g:last_toggled_background[ ]*=[ ]*.*/" . setvar . "/\\nw'" .
                    \ ' || ' . ed_cmd . " <<< $'$a\\n\" " . comment . "\\n" . setvar . "\\n.\\nw'"
        " call system('cat > cmd.sh', cmd)
        call system(cmd)
    endif
endfunction

nnoremap <leader>t :call ToggleBGPersist()<CR>
" Ensure the autoload file gets loaded
call togglebg#map("<F5>")


" ======================= HTML/XML Tag operations =============================
" Change tagname
function! ChangeTagName()
    call inputsave()
    let tag = input("New tagname: ")
    call inputrestore()
    exe 'normal! vathciw' . tag
    exe 'normal! gvolciw' . tag . ''
endfunction
nnoremap <leader>ct :call ChangeTagName()<CR>

" Remove tag (leaving inner contents in place)
nnoremap <leader>rt ditvatp

function! WrapTag()
    call inputsave()
    let tag = input("Tagname: ")
    call inputrestore()
    let break = tag =~ ' $'
    if break
        let tag = substitute(tag, '\s\+$', '', '')
    endif
    let cmd = 'normal! cat<' . tag . '>'
    if break
        let cmd .= ''
    endif
    let cmd .= 'gpa'
    if break
        let cmd .= ''
    endif
    let cmd .= '</' . tag . '>'
    if break
        let cmd .= 'vat='
    endif
    exe cmd
endfunction
nnoremap <leader>wt :call WrapTag()<CR>


" ======================= Refactor helpers =============================
command! TODO :silent! exe '/\<\(TODO\|FIXME\|XXX\)\>' | Ag '\b(TODO|FIXME|XXX)\b'


" ======================= Filter text with shell command =============================
function! TextFilter(type, Cmd, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @c

    if a:0 && a:1  " Invoked from Visual mode, use '< and '> marks.
        let visual_select = '`<' . a:type . '`>'
    elseif a:type == 'line'
        let visual_select = "'[V']"
    elseif a:type == 'block'
        let visual_select = '`[\<C-V>`]'
    else
        let visual_select = '`[v`]'
    endif

    exe 'normal! ' . visual_select . '"cy'
    let @c = substitute(a:Cmd(@c), '\_s\+$', '', 'g')
    exe 'normal! ' . visual_select . '"cp'

    let @c = reg_save
    let &selection = sel_save
endfunction

function! CommandFilter(type, ...)
    if a:0 >= 2
        let cmd = a:2
    else
        call inputsave()
        let cmd = input("Command: ")
        call inputrestore()
    endif

    function! Cmd(text)
        return system(cmd, a:text)
    endfunction

    TextFilter(a:type, function('Cmd'), a:0 && a:1)
endfunction
nnoremap <leader>f :set opfunc=CommandFilter<CR>g@
vnoremap <leader>f :<C-U>call CommandFilter(visualmode(), 1)<CR>


" ======================= Calculator Macro =============================
function! CalculateBcCommand(text)
    if !len(a:text)
        return '0'
    endif
    let scale = get(b:, 'calculate_scale', get(g:, 'calculate_scale'))
    if scale
        let cmd = "sed 's/.\\+/scale=" . scale . "; &/' | bc -l"
    else
        let cmd = 'bc -l'
    endif
    " For some reason passing text as second argument gives a syntax error
    " when used with bc.
    return system('echo ' . shellescape(a:text) . ' | ' . cmd)
endfunction

function! CalculatePythonCommand(text)
    if !len(a:text)
        return '0'
    endif
    let scale = get(b:, 'calculate_scale', get(g:, 'calculate_scale'))
    if scale
        let val = '"{:.' . scale . 'f}.format(&)'
    else
        let val = '&'
    endif
    let assgn = split(substitute(a:text, '\(\r\|\n\)\+$', '', ''), '\s*=\s*')
    let text = assgn[-1]
    if len(assgn) > 1
        let vars = join(assgn[:-2], ' = ') . ' = '
    else
        let vars = ''
    endif
    let text = 'print("{}{}".format("' . vars . '", ' . text . '))'
    return system('python', text)
endfunction

function! CalculateJavascriptCommand(text)
    if !len(a:text)
        return '0'
    endif
    let scale = get(b:, 'calculate_scale', get(g:, 'calculate_scale'))
    if scale
        let val = '(\1).toFixed(' . scale . ')'
    else
        let val = '\1'
    endif
    return system("sed " . shellescape('s/\([^;]\+\)\(;\?\)/require("util").print(' . val . ', "\2")/') . " | node", a:text)
endfunction

function! Calculate(type, ...)
    let Cmd = get(b:, 'CalculateCommand',
                \ get(g:, 'CalculateCommand', function('CalculateBcCommand')))
    if type(Cmd) == type(function('tr'))
        call TextFilter(a:type, Cmd, a:0 && a:1)
    else
        call CommandFilter(a:type, a:0, Cmd)
    endif
endfunction
nnoremap <leader>C :set opfunc=Calculate<CR>g@
vnoremap <leader>C :<C-U>call Calculate(visualmode(), 1)<CR>

" This command intentionally ended with a space. Makes it easy to set the
" scale for a given file. Wrap in exe so automatic trailing whitespace removal
" won't mess this up.
exe 'nnoremap <leader>sc :let b:calculate_scale = '


" Text fill / align helpers
function! AlignRight(width)
    let yankSave = @"
    let searchSave = @/
    let oldtextwidth = &textwidth
    if a:width
        let &textwidth = a:width
    endif
    normal! d?\(\S\s\)\@<=mrV:right0d^`rPl
    let &textwidth = oldtextwidth
    let @" = yankSave
    let @/ = searchSave
endfunction
nnoremap <leader>R :<C-U>call AlignRight(v:count)<CR>
