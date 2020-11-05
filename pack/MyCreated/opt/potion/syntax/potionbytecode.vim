if exists("b:current_syntax")
    finish
endif

syntax keyword potionBytecodeKeyword code block
 syntax keyword potionBytecodeKeyword assign expr msg list
 syntax keyword potionBytecodeKeyword bind call getlocal getupval loadk loadpn move msg proto return self setlocal code expr getlocal getupval loadpn msg mult return setupval
highlight link potionBytecodeKeyword Keyword

syntax match PotionBytecodeDebug "\v^-- \w* --$"
syntax match PotionBytecodeDebug "\v^\*\* .*$"
highlight link potionBytecodeDebug Debug

syntax match potionBytecodeType "\v\.\w+>"
highlight link potionBytecodeType Type

syntax match potionBytecodeComment "\v;.*$"
" syntax match potionBytecodeComment "\v\[\s*\d+\]"
highlight link potionBytecodeComment Comment


syntax match potionBytecodeNumber "\v(\s|\n)\zs\d+\ze(\s|\n)"
highlight link potionBytecodeNumber Number

let b:current_syntax = "potionbytecode"

