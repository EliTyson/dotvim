" " remove mappings if filetype changed
function! UnmapMarkdownSections()
    for mapping in ['[]', '][', '[[', ']]']
        silent! execute 'nunmap <buffer> ' . mapping
        silent! execute 'ounmap <buffer> ' . mapping
        silent! execute 'xunmap <buffer> ' . mapping
    endfor
endfunction

if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|call UnmapMarkdownSections()"
    " echom "undo_ftplugin exists"
else
    let b:undo_ftplugin = "call UnmapMarkdownSections()"
    " echom "undo_ftplugin does not exist"
endif

