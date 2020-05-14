function! Sorted(l)
    let new_list = deepcopy(a:l)
    call sort(new_list)
    return new_list
endfunction

function! Reversed(l)
    let new_list = deepcopy(a:l)
    call reverse(new_list)
    return new_list
endfunction

function! Append(l, val)
    let new_list = deepcopy(a:l)
    call add(new_list, a:val)
    return new_list
endfunction

function! Assoc(l_d, i_k, val)
    let new_l_or_d = deepcopy(a:l_d)
    let new_l_or_d[a:i_k] = a:val
    return new_l_or_d
endfunction

" function! Assoc(l_d, i_k, val)
"     if type(a:l_d) ==# type(v:t_list)
"         let new_list = deepcopy(a:l_d)
"         let new_list[a:i_k] = a:val
"         return new_list
"     elseif type(a:l_d,) ==# type(v:t_dict)
"         let new_dict = deepcopy(a:l_d)
"         let new_dict.a:i_k = a:val
"         return new_dict
"     endif
" endfunction

function! Pop(l_d, i_k)
    let new_l_or_d = deepcopy(a:l_d)
    call remove(new_l_or_d, a:i_k)
    return new_l_or_d
endfunction

function! Mapped(fn, l_d)
    let new_l_or_d = deepcopy(a:l_d)
    call map(new_l_or_d, string(a:fn) . '(v:val)')
    return new_l_or_d
endfunction

function! Filtered(fn, l)
    let new_l_or_d = deepcopy(a:l_d)
    call filter(new_l_or_d, string(a:fn) . '(v:val)')
    return new_l_or_d
endfunction

" My attempt at creating functional reduce()
" similar to what is available in javascript
function! Reduced(fn, l_d, ...)
    if empty(a:l_d)
        echoerr 'Empty list/dictionary'
        return ''
    " create new list from list or dictionary values
    elseif type(a:l_d) ==# v:t_list
        let new_list = deepcopy(a:l_d)
    elseif type(a:l_d) ==# v:t_dict
        let new_list = deepcopy(values(a:l_d))
    else
        echoerr 'Second argument must be a List or a Dictionary'
        return ''
    endif

    " get the initial value for acc (the accumulator)
    if a:0
        let acc = a:1
    else
        let acc = remove(new_list, 0)
    endif

    " apply funcref to each list item and assign result to acc
    for item in new_list
        let acc = eval(string(a:fn) . '(acc, item)')
    endfor
    return acc
endfunction

