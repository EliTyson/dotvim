function! potion#running#PotionCompileAndRunFile()
    silent !clear
    if executable(g:potion_command)
        update
        execute "!" . g:potion_command . " " . bufname("%")
    endif
endfunction

function! potion#running#PotionShowBytecode()
    " Get the bytecode.
    if executable(g:potion_command)
        update
        let bytecode = system(g:potion_command . ' -c -V ' . bufname('%'))
    " temp code used to debug rest of function on ms-win machine
    " elseif filereadable("C:/Users/Nick/vimfiles/pack/MyCreated/start/potion/ftplugin/potion/sample_bytecode.txt")
    "     update
    "     let bytecode = join(readfile("C:/Users/Nick/vimfiles/pack/MyCreated/start/potion/ftplugin/potion/sample_bytecode.txt"), "\n")
    " elseif executable('cmd')
    "     update
    "     let bytecode = system('type ' . bufname('%'))
    else
        return
    endif

    " Open a new split and set it up.
    let bytecode_window_number = bufwinnr(bufnr('__Potion_Bytecode__'))
    if bytecode_window_number ==# -1
        vsplit __Potion_Bytecode__
    else
        execute bytecode_window_number . "wincmd w"
    endif
    normal! ggdG
    setlocal filetype=potionbytecode
    setlocal buftype=nofile

    "  Insert the bytecode.
    if v:shell_error
        echohl Error | echom "Error - Shell Returned " . v:shell_error echohl None
    endif
    call append(0, split(bytecode, '\v\n'))
    normal! gg
endfunction
