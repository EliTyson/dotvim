nnoremap <silent> <leader>g :set operatorfunc=<SID>GrepOperator<CR>g@
xnoremap <silent> <leader>g :<C-U>call <SID>GrepOperator(visualmode())<CR>

" Grep Operator Function
function! s:GrepOperator(type)
    " Save unnamed register
    let saved_unnamed_register = @@
    " Save 'selection' setting
    let sel_save = &selection
    " Temporarily set 'selection' to inclusive (default)
    let &selection = "inclusive"

    " Copying visually selected text to Grep
    if a:type ==# 'v' && line("'<") ==# line("'>")
        " copy visually selected text
        normal! `<v`>y
    " Copying motion selected text to Grep
    elseif a:type ==# 'char' && line("'[") ==# line("']")
        " Save last visual selection
        let v_mode = visualmode()
        let saved_visual_start_mark = getpos("'<")
        let saved_visual_end_mark = getpos("'>")

        " Copy text that was operated on
        normal! `[v`]y

        " Restore the visual mode to (line or blockwise)
        if v_mode ==# "V"
            silent execute "normal V\<ESC>"
        elseif v_mode ==# "\<C-V>"
            silent execute "normal \<C-V>\<ESC>"
        endif
        " Restore last visual selection
        call setpos("'<", saved_visual_start_mark)
        call setpos("'>", saved_visual_end_mark)
    " Return if no text to grep
    else
        " restore 'selection' setting
        let &selection = sel_save
        return
    endif

    " Use grep if available. Change default 'grepprg' if needed.
    if executable('grep') == 1   "executable() returns '-1' for 'not implemented...'
        let &g:grepprg='grep -n'
        " silent execute "grep! -R " . shellescape(@@, 1) . " %:p:h/*"
        if has('win32') && &shell =~? '\v^cmd.exe|command.exe'
            silent execute 'grep! -R ^"' . escape(substitute(escape(@@, '\"^<>()'), '\', '\\^', 'g'), '!%#')  . '^" ./*'
            redraw
            copen
        else
            silent execute "grep! -R " . shellescape(@@, 1) . " ./*"
            redraw
            copen
        endif

    " Use findstr as fallback
    elseif executable('findstr') == 1   "executable() returns '-1' for 'not implemented...'
        let &g:grepprg='findstr /n'
        if has('win32') && &shell =~? '\v^cmd.exe|command.exe'
            " silent execute 'grep! /SC:^"' . escape(substitute(escape(@@, '\"^<>()'), '\', '\\^', 'g'), '!%#')  . '^" %:p:h/*'
            silent execute 'grep! /SPC:^"' . escape(substitute(escape(@@, '\"^<>()'), '\', '\\^', 'g'), '!%#')  . '^" ./*'
            redraw
            copen
        else
            silent execute "grep! /SPC:" . shellescape(@@, 1) . " ./*"
            redraw
            copen
        endif
    endif

    " restore unnamed register
    let @@ = saved_unnamed_register
    " restore 'selection' setting
    let &selection = sel_save
endfunction
