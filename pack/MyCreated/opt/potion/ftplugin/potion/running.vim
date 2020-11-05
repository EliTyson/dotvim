if ! exists("g:potion_command")
    let g:potion_command = "potion"
endif

nnoremap <silent> <buffer> <localleader>r :call potion#running#PotionCompileAndRunFile()<CR>
nnoremap <silent> <buffer> <localleader>b :call potion#running#PotionShowBytecode()<CR>

