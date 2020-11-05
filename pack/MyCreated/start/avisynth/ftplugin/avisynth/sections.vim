" Adds section-movements for avisynth files
" Type 0: (e.g., '][' and '[]') moves between any line with '('
" Type 1: (e.g., ']]' and '[[') moves between any lines with '='
"   The top line of a file is also matched with these section movements
if !exists("no_plugin_maps") && !exists("no_avisynth_maps")

    function! s:AvisynthSections(type, isForward, isVisual)
        let section_count = v:count1    " store v:count1 so 'gv' does not reset it
        if a:isVisual
            silent normal! gv
        endif

        let section_pattern = (a:type) ? '\v%^|^\ze.*\('
                                    \ : '\v%^|^\ze.*\='
        let direction = (a:isForward) ? '/' : '?'

        silent execute  'normal! ' .  section_count . direction . section_pattern . "\r"

    endfunction

    nnoremap <script> <buffer> <silent> [] :<C-U>call <SID>AvisynthSections(0, 0, 0)<CR>
    nnoremap <script> <buffer> <silent> ][ :<C-U>call <SID>AvisynthSections(0, 1, 0)<CR>
    nnoremap <script> <buffer> <silent> [[ :<C-U>call <SID>AvisynthSections(1, 0, 0)<CR>
    nnoremap <script> <buffer> <silent> ]] :<C-U>call <SID>AvisynthSections(1, 1, 0)<CR>
    "
    onoremap <script> <buffer> <silent> [] :<C-U>call <SID>AvisynthSections(0, 0, 0)<CR>
    onoremap <script> <buffer> <silent> ][ :<C-U>call <SID>AvisynthSections(0, 1, 0)<CR>
    onoremap <script> <buffer> <silent> [[ :<C-U>call <SID>AvisynthSections(1, 0, 0)<CR>
    onoremap <script> <buffer> <silent> ]] :<C-U>call <SID>AvisynthSections(1, 1, 0)<CR>
    "
    xnoremap <script> <buffer> <silent> [] :<C-U>call <SID>AvisynthSections(0, 0, 1)<CR>
    xnoremap <script> <buffer> <silent> ][ :<C-U>call <SID>AvisynthSections(0, 1, 1)<CR>
    xnoremap <script> <buffer> <silent> [[ :<C-U>call <SID>AvisynthSections(1, 0, 1)<CR>
    xnoremap <script> <buffer> <silent> ]] :<C-U>call <SID>AvisynthSections(1, 1, 1)<CR>

    " remove mappings if filetype changed
    function! UnmapAvisynthSections()
        for mapping in ['[]', '][', '[[', ']]']
            silent execute 'nunmap <buffer> ' . mapping
            silent execute 'ounmap <buffer> ' . mapping
            silent execute 'xunmap <buffer> ' . mapping
        endfor
    endfunction

    if exists('b:undo_ftplugin')
        let b:undo_ftplugin .= "|call UnmapAvisynthSections()"
    else
        let b:undo_ftplugin = "call UnmapAvisynthSections()"
    endif

endif
