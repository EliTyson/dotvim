setlocal foldmethod=expr
setlocal foldexpr=GetPotionFold(v:lnum)

"Helper Functions
function! s:NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction
"
function! s:IndentLevel(lnum)
    let indent_length = (&shiftwidth) ? &shiftwidth : &tabstop
    return indent(a:lnum) / indent_length
endfunction

"Main Function
function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent = s:IndentLevel(a:lnum)
    let next_indent = s:IndentLevel(s:NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
    " if next_indent > this_indent
    "     return '>' . next_indent
    " else 
    "     return this_indent
    " endif
endfunction
" function! GetPotionFold(lnum)
"     if getline(a:lnum) =~? '\v^\s*$'
"         return '-1'
"     elseif indent(a:lnum + 1)/&tabstop > indent(a:lnum)/&tabstop
"         return '>' . indent(a:lnum + 1)/&tabstop
"     else
"         return indent(a:lnum)/&tabstop
"     endif
" endfunction
