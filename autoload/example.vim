echom "Loading..."

let example#mylist = ['one', 2, 'III', 0x4, 'cinco']

function! example#Hello()
    " echom "Hello, world!"
    echohl Error | echom "Hello, AGAIN, world!" | echohl none
endfunction

echom "Done loading."
