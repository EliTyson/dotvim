" Vim filetype plugin file
" Language:             Avisynth video scripting language
" Maintainer:           Eli Tyson
" Latest Revision:      2020-07-04

" run `let b:did_ftplign = 1` earlier in rtp to disable plugin.
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setlocal comments< commentstring<"


" " function! s:AVSDissolveBasic1(frames) range
" "     let cuts = getline(a:firstline, a:lastline)->join('), v.trim(')
" "     let formatted_text = "Dissolve(v.trim(" . cuts . "), " . a:frames . ")"
" "     call append(a:lastline, formatted_text)
" " endfunction

" function! s:AVSDissolveBasic2(frames) range
"     let checked_frames  = (!a:frames) ? 30 : a:frames
"     let cuts_list = getline(a:firstline, a:lastline)
"     let inner_text = map(cuts_list, '"v.Trim(" . v:val . "),"')->join()
"     let formatted_text = 'Dissolve(' . inner_text . ' ' . checked_frames . ')'
"     call append(a:lastline, formatted_text)
" endfunction

function! s:AVSDissolve(frames, ...) range
    " Defaults
    let checked_frames  = (!a:frames) ? 30 : a:frames
    let video = 'v'
    let blank_frames = 10
    let fade_frames = 15
    let inner_text = ''
    let queued_fadein = ''

    for item in getline(a:firstline, a:lastline)
        if item !~? '\vfade'
            if inner_text =~? '\v\)$'
                let inner_text .= ", " . video . ".Trim(" . item . ")" . queued_fadein
                let queued_fadein = ''
            else
                let inner_text .= video . ".Trim(" . item . ")" .queued_fadein
                let queued_fadein = ''
            endif
        elseif item =~? '\vfadeout'
            let inner_text .= ".FadeOut(" . fade_frames .
                            \ ") ++ BlankClip(" . video . ", " . blank_frames . ") ++ "
        elseif item =~? '\vfadein'
            let inner_text .= " ++ BlankClip(" . video . ", " . blank_frames . ") ++ "
            let queued_fadein = ".FadeIn(" . fade_frames . ")"
        elseif item =~? '\vfade'
            let inner_text .= ".FadeOut(" . fade_frames .
                            \ ") ++ BlankClip(" . video . ", " . blank_frames . ") ++ "
            let queued_fadein = ".FadeIn(" . fade_frames . ")"
        else
            let inner_text .= "ERROR: Fell through if-statements"
        endif
    endfor

    let formatted_text = 'Dissolve(' . inner_text . ', ' . checked_frames . ')'
    call append(a:lastline, formatted_text)
endfunction

xnoremap <silent> <buffer> <localleader>d :call <SID>AVSDissolve(v:count)<CR>
" xnoremap <silent> <buffer> <localleader>d :call <SID>AVSDissolveAdvanced(v:count)<CR>

nnoremap <silent> <buffer> <localleader>ev :update<CR>:silent !start virtualdub "%:p"<CR>

setlocal comments=:# commentstring=#\ %s
