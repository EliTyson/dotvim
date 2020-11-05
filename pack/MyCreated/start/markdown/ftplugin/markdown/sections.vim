" Adds section-movements for markdown files
" Type 0: (e.g., '][' and '[]') moves between level 1 markdown headings
" Type 1: (e.g., ']]' and '[[') moves between any markdown headings
"   The top line of a file is also matched with these section movements

if !exists("no_plugin_maps") && !exists("no_markdown_maps")
    function! s:MarkdownSections(type, isForward, isVisual)
        let section_count = v:count1    " store v:count1 so 'gv' does not reset it
        if a:isVisual
            silent normal! gv
        endif

        let direction = (a:isForward) ? '/' : '?'
        let section_pattern = (a:type) ? '\v%^|^#+\s|((^[=-]+[^=-]+\s*$)|(^[^=-].*))\n^[=-]+\s*$'
                                    \ : '\v%^|^#\s|((^[=-]+[^=-]+\s*$)|(^[^=-].*))\n^[=]+\s*$'

        silent execute  'normal! ' .  section_count . direction . section_pattern . "\r"

    endfunction

    nnoremap <script> <buffer> <silent> [] :<C-U>call <SID>MarkdownSections(0, 0, 0)<CR>
    nnoremap <script> <buffer> <silent> ][ :<C-U>call <SID>MarkdownSections(0, 1, 0)<CR>
    nnoremap <script> <buffer> <silent> [[ :<C-U>call <SID>MarkdownSections(1, 0, 0)<CR>
    nnoremap <script> <buffer> <silent> ]] :<C-U>call <SID>MarkdownSections(1, 1, 0)<CR>
    "
    onoremap <script> <buffer> <silent> [] :<C-U>call <SID>MarkdownSections(0, 0, 0)<CR>
    onoremap <script> <buffer> <silent> ][ :<C-U>call <SID>MarkdownSections(0, 1, 0)<CR>
    onoremap <script> <buffer> <silent> [[ :<C-U>call <SID>MarkdownSections(1, 0, 0)<CR>
    onoremap <script> <buffer> <silent> ]] :<C-U>call <SID>MarkdownSections(1, 1, 0)<CR>
    "
    xnoremap <script> <buffer> <silent> [] :<C-U>call <SID>MarkdownSections(0, 0, 1)<CR>
    xnoremap <script> <buffer> <silent> ][ :<C-U>call <SID>MarkdownSections(0, 1, 1)<CR>
    xnoremap <script> <buffer> <silent> [[ :<C-U>call <SID>MarkdownSections(1, 0, 1)<CR>
    xnoremap <script> <buffer> <silent> ]] :<C-U>call <SID>MarkdownSections(1, 1, 1)<CR>
endif

" " remove mappings if filetype changed (see /after/markdown.vim)
" function! UnmapMarkdownSections()
"     for mapping in ['[]', '][', '[[', ']]']
"         silent execute 'nunmap ' . mapping
"         silent execute 'ounmap ' . mapping
"         silent execute 'xunmap ' . mapping
"     endfor
" endfunction

" if exists('b:undo_ftplugin')
"     let b:undo_ftplugin .= "|call UnmapMarkdownSections()"
"     echo "undo_ftplugin exists"
" else
"     let b:undo_ftplugin = "call UnmapMarkdownSections()"
"     echo "undo_ftplugin does not exist"
" endif
