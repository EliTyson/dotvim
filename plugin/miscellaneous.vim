
" " helper function to store buffer information
" function! s:SaveBufferInfo()
"     let saved_info = {
"         \ 'v_start':getpos("'<"),
"         \ 'v_end':getpos("'>"),
"         \ 'c_start':getpos("'["),
"         \ 'c_end':getpos("']"),
"         \ 'v_mode':visualmode(),
"         \ 'r_unnnamed':getreg('"'),
"     \}
"     return saved_info
" endfunction

" " helper function to restore buffer information
" function! s:RestoreBufferInfo(saved)

"     " Restore the visual mode to (line or blockwise)
"     if a:saved.v_mode ==# "V"
"         silent execute "normal V\<C-C>"
"     elseif a:saved.v_mode ==# "\<C-V>"
"         silent execute "normal \<C-V>\<C-C>"
"     endif

"     " restore marks and unnamed register
"     call setpos("'<", a:saved.v_start)
"     call setpos("'>", a:saved.v_end)
"     call setpos("'[", a:saved.c_start)
"     call setpos("']", a:saved.c_end)
"     let @@ = a:saved.r_unnnamed

" endfunction


" Rot13 encode a string
" Intended to work like `toupper()` and `tolower`
" Issues: function results in a modified buffer.
" function! ToRot13(string)
"     " Check for an empty string
"     if empty(a:string)
"         return ""
"     endif

"     " Save buffer information and cursor position
"     let saved = s:SaveBufferInfo()
"     let saved_view = winsaveview()
"     let last_line = line('$')

"     " Temporarily paste string at bottom of file
"     silent execute "keepjumps normal! Go\<C-R>=a:string\r"
"     " Rot13 the pasted string and delete everything
"     silent execute "keepjumps normal! " . (last_line + 1) . "G" . 'vGg_g?gvd"_dd'
"     " Save the rot13_string as a variable
"     let rot13_string = @@

"     " Restore marks, cursor position, previous visual mode & unnamed register
"     call s:RestoreBufferInfo(saved)
"     call winrestview(saved_view)

"     " return Rot13 encoded string
"     return rot13_string
" endfunction

" Rot13 encode a string
" Intended to work like `toupper()` and `tolower`
function! ToRot13(string)
    return tr(a:string,
        \ 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
        \ 'NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm')
endfunction
