if exists("b:current_syntax")
    finish
endif

syntax keyword potionKeyword loop while times to
syntax keyword potionKeyword if elsif else
syntax keyword potionKeyword class
syntax keyword potionKeyword return
highlight link potionKeyword Keyword

syntax keyword potionFunction print join string
highlight link potionFunction Function

syntax match potionComment "\v#.*$"
highlight link potionComment Comment

syntax match potionOperator "\v\*(\=)?"
syntax match potionOperator "\v/(\=)?"
syntax match potionOperator "\v\+(\=)?"
syntax match potionOperator "\v-(\=)?"
syntax match potionOperator "\v\="
syntax match potionOperator "\v\?"
syntax match potionOperator "\v:"
syntax match potionOperator "\v\."
highlight link potionOperator Operator

syntax match potionNumber "\v-?\d+(\.\d+)?(e[-\+]\d+)?"
syntax match potionNumber "\v0x\x+"
highlight link potionNumber Number

syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region potionString start=/\v'/ skip=/\v''/ end=/\v'/
highlight link potionString String

let b:current_syntax = "potion"

