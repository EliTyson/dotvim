" function! s:NextSection(type, backwards, visual)
"     if a:visual
"         normal! gv
"     endif

"     if a:type == 1
"         let pattern = '\v(\n\n^\S|%^)'
"         let flags = 'e'
"     elseif a:type == 2
"         let pattern = '\v^\S.*\=.*:$'
"         let flags = ''
"     endif

"     if a:backwards
"         let dir = '?'
"     else
"         let dir = '/'
"     endif

"     execute 'silent normal! ' . dir . pattern . dir . flags . "\r"
" endfunction

" noremap <script> <buffer> <silent> ]]
"         \ :call <SID>NextSection(1, 0, 0)<cr>

" noremap <script> <buffer> <silent> [[
"         \ :call <SID>NextSection(1, 1, 0)<cr>

" noremap <script> <buffer> <silent> ][
"         \ :call <SID>NextSection(2, 0, 0)<cr>

" noremap <script> <buffer> <silent> []
"         \ :call <SID>NextSection(2, 1, 0)<cr>

" vnoremap <script> <buffer> <silent> ]]
"         \ :<c-u>call <SID>NextSection(1, 0, 1)<cr>

" vnoremap <script> <buffer> <silent> [[
"         \ :<c-u>call <SID>NextSection(1, 1, 1)<cr>

" vnoremap <script> <buffer> <silent> ][
"         \ :<c-u>call <SID>NextSection(2, 0, 1)<cr>

" vnoremap <script> <buffer> <silent> []
"         \ :<c-u>call <SID>NextSection(2, 1, 1)<cr>
function! s:PotionSection(isSameBracket, isForward, isVisual)
    if a:isVisual
        silent normal! gv
    endif

    let section_search = (a:isSameBracket) ? '\v(%^)|(^\s*$\n\zs^\S)' : '\v^\S.*\=.*:$'
    let section_direction = (a:isForward) ? '/' : '?'
    execute 'silent normal! ' . section_direction . section_search . "\r"
endfunction

noremap <script> <buffer> <silent> [[ :call <SID>PotionSection(1, 0, 0)<CR>
noremap <script> <buffer> <silent> ]] :call <SID>PotionSection(1, 1, 0)<CR>

noremap <script> <buffer> <silent> [] :call <SID>PotionSection(0, 0, 0)<CR>
noremap <script> <buffer> <silent> ][ :call <SID>PotionSection(0, 1, 0)<CR>

xnoremap <script> <buffer> <silent> [[ :<C-U>call <SID>PotionSection(1, 0, 1)<CR>
xnoremap <script> <buffer> <silent> ]] :<C-U>call <SID>PotionSection(1, 1, 1)<CR>

xnoremap <script> <buffer> <silent> [] :<C-U>call <SID>PotionSection(0, 0, 1)<CR>
xnoremap <script> <buffer> <silent> ][ :<C-U>call <SID>PotionSection(0, 1, 1)<CR>


