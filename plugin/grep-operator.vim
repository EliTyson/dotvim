nnoremap <silent> <leader>g :set operatorfunc=<SID>GrepOperator<CR>g@
xnoremap <silent> <leader>g :<C-U>call <SID>GrepOperator(visualmode())<CR>

" Grep Operator Function
function! s:GrepOperator(type)
    " save unnamed register
    let saved_unnamed_register = @@
    " save 'selection' setting
    let sel_save = &selection
    " temporarily set 'selection' to inclusive (default)
    let &selection = "inclusive"

    " Copying visually selected text to Grep
    if a:type ==# 'v' && line("'<") ==# line("'>")
        " copy visually selected text
        normal! `<v`>y

    " Copying motion selected text to Grep
    elseif a:type ==# 'char' && line("'[") ==# line("']")
        " save last visual selection
        let save_visual_start_mark = getpos("'<")
        let save_visual_end_mark = getpos("'>")

        " copy text that was operated on
        normal! `[v`]y

        " restore last visual selection
        call setpos("'<", save_visual_start_mark)
        call setpos("'>", save_visual_end_mark)

    " Return if no text to grep
    else
        " restore 'selection' setting
        let &selection = sel_save
        return

    endif

    " Choose grepprg based on shell
    if match(&shell, 'cmd.exe') >= 0
        let &g:grepprg='findstr /n'
        silent execute 'grep! /SC:^"' . escape(substitute(escape(@@, '\"^<>()'), '\', '\\^', 'g'), '!%#')  . '^" %:p:h/*'
        redraw
        copen

"     elseif match(&shell, 'bash.exe') >= 0
"         let &g:grepprg='grep -n'
"         silent execute "grep! -R " . shellescape(@@, 1) . " %:p:h/*"
"         redraw
"         copen

"     elseif match(&shell, 'powershell.exe') >= 0
"         let &g:grepprg='grep -n'
"         silent execute "grep! -R " . shellescape(@@, 1) . " %:p:h/*"
"         redraw
"         copen
    else
        let &g:grepprg='grep -n'
        silent execute "grep! -R " . shellescape(@@, 1) . " %:p:h/*"
        redraw
        copen
    endif

    " restore unnamed register
    let @@ = saved_unnamed_register
    " restore 'selection' setting
    let &selection = sel_save
endfunction
