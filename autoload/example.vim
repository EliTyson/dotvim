echom "Loading..."

let example#mylist = ['one', 2, 'III', 0x4, 'cinco']

function! example#Hello()
    " echom "Hello, world!"
    echohl Special | echom "Hello, AGAIN, world!" | echohl none
    echohl Underlined | echom "Use 'h group-name' to get highlighting groups" | echohl none
endfunction

echom "Done loading."
