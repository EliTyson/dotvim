" vim: foldmethod=marker
set encoding=utf-8      "if encounter 'CONVERSION ERROR' use ':w ++enc=utf-8'
scriptencoding utf-8
"
"--------------
"   MY VIMRC   "
"--------------
"
"Learning Vimscript the Hard Way {{{1
"=======================================================
nnoremap <leader>ve :split $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
nnoremap <C-H> 0
nnoremap <C-L> $
inoremap jk <ESC>
inoremap <ESC> <NOP>
nnoremap <leader># :execute "rightbelow split " . bufname("#")<CR>
nnoremap <silent> <leader>w :2match Error /\v\s+$/<CR>
nnoremap <silent> <leader>W :2match none<CR>
nnoremap <silent> <leader>\ :nohlsearch<CR>
"
nnoremap <silent> <leader>f :call <SID>FoldColumnToggle()<CR>
"
" toggle fold columns
function! s:FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=3
    endif
endfunction
"
" toggle quickfix window
nnoremap <silent> <leader>q :call <SID>QuickfixToggle()<CR>
"
function! s:QuickfixToggle()
    let g:quickfixtoggle_previous_window_id = win_getid()
    let win_info = copy(getwininfo())
    cclose
    "
    " copen if cclose did nothing
    if win_info ==# getwininfo()
        let g:quickfixtoggle_copen_window_id = win_getid()
        copen
    else
        " restore to previous window location for successful cclose
        " if previous window was quickfix go to window when toggle opened
        if !win_gotoid(g:quickfixtoggle_previous_window_id)
            if exists("g:quickfixtoggle_copen_window_id")
                call win_gotoid(g:quickfixtoggle_copen_window_id)
                " echom "go to copen window"
            endif
        endif
    endif
endfunction
"
"
iabbrev teh the
iabbrev ->;; →
iabbrev =>;; ⇒
iabbrev SE;; §
abbrev <expr> d;; strftime("%Y-%m-%d")
abbrev <expr> D;; '['.strftime("%Y-%m-%d").']'
"
augroup learning_vimscript
    autocmd!
    autocmd FileType markdown setlocal list
    autocmd FileType markdown setlocal spell
    autocmd FileType python nnoremap <buffer> <localleader>c I# <ESC>
    autocmd FileType avisynth nnoremap <buffer> <localleader>c I# <ESC>
    autocmd FileType vim nnoremap <buffer> <localleader>c I" <ESC>
    autocmd FileType markdown iabbrev <buffer> +;; <TAB>+
    autocmd FileType markdown iabbrev <buffer> -;; <TAB><TAB>-
augroup END
"
augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
"
augroup filetype_markdown
    autocmd!
    autocmd FileType markdown inoremap ',, &apos;
    autocmd FileType markdown inoremap ",, &quot;
    autocmd FileType markdown inoremap &,, &amp;
    autocmd FileType markdown inoremap <,, &lt;
    autocmd FileType markdown inoremap >,, &gt;
    autocmd FileType markdown onoremap ih :<C-U>exe "norm! ?\\(^==\\+$\\)\\\|\\(^--\\+$\\)\r:nohlsearch\rkvg_\"<CR>
    autocmd FileType markdown onoremap ah :<C-U>exe "norm! ?\\(^==\\+$\\)\\\|\\(^--\\+$\\)\r:nohlsearch\rg_vk0"<CR>
    autocmd FileType markdown setlocal statusline=%.20f     "Path to the file (max 20 chars)
    autocmd FileType markdown setlocal statusline+=\ [%n]   "Buffer number in ' [#]'
    autocmd FileType markdown setlocal statusline+=%m       "Mofied Flag in brackets [+] or [-]
    autocmd FileType markdown setlocal statusline+=%r       "Readonly Flag in brackets [RO]
    autocmd FileType markdown setlocal statusline+=%=       "Switch to right side
    autocmd FileType markdown setlocal statusline+=[%03b]   "[Dec val] char (≥ 3, zero pad)
    autocmd FileType markdown setlocal statusline+=[0x%02B] "[0xHex val] char (≥ 2, zero pad)
    autocmd FileType markdown setlocal statusline+=[        "Add '['
    autocmd FileType markdown setlocal statusline+=%4l      "Current line (min 4 width)
    autocmd FileType markdown setlocal statusline+=/        "Add '/'
    autocmd FileType markdown setlocal statusline+=%L       "Total lines
    autocmd FileType markdown setlocal statusline+=\ :      "Add ' Col'
    autocmd FileType markdown setlocal statusline+=%2c      "Column (min 2 width)
    autocmd FileType markdown setlocal statusline+=]        "Add ']'
augroup END
"
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker "unnecessary if use modelines
augroup END
"
let g:potion_command = "/Users/pi/potion/bin/potion"
"
"VIMRC DEFAULT SETTINGS {{{1
"=======================================================
set nocompatible                "don't change defaults to make Vim Vi compatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim   "sets Ctrl-V to paste, arrow keys, etc.
"behave mswin                   "set 'mswin' behavior for mouse and selection
"
if has('win32')
    set diffexpr=MyDiff()
endif
"
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
        let cmd = '"' . $VIMRUNTIME . '\diff"'
        let eq = '""'
    else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
    else
    let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
"
"GENERAL {{{1
"=======================================================
set hidden                                 "allow hiding unsaved buffers
set shellslash                            "force forward slash for expanded filenames
set history=100                           "command line history (Default:50)
set undolevels=1000                       "(ul) Max # of undos (Default: 10000)
"don't expand these filetypes
set wildignore+=*\^ntuser.*,*\Web\*,*\AppData\*,*.dat,*.ini,*.exe
set wildignore+=*.mp4,*.mkv,*.m4a,*.mka,*.wav,*.aac,*.ffindex,*.pdf,*.jpg,*.gif,*.png
if has('win32')
    set path+=$HOME,$HOME/Desktop             "set path to search for find commands
    " cd $HOME/Desktop                        "sets current directory
    " set shell=<path to shell>               "use alternate shell
    set viewdir=$HOME/vimfiles/views//        "sets directory to save views
    set directory=$HOME/AppData/Roaming/Vim// "sets file directory (used for swap files)
    set backupdir=$HOME/AppData/Roaming/Vim// "sets directory for write backups
    set undodir=$HOME/AppData/Roaming/Vim//   "sets directory for undo files
    set viminfofile=$HOME/AppData/Roaming/Vim/_viminfo "sets file name for viminfo
    " set undofile                              "persistent undo, .un~ files saved
endif
if has('gui_running')
    " GUI is running or is about to start.
    " Maximize gvim window (for an alternative on Windows, see simalt below).
    " set lines=99 columns=999
    set lines=50 columns=100
endif
"
"INTERFACE {{{1
"=======================================================
colorscheme gruvbox
if has('win32')
    set guifont=Hack:h9:cDEFAULT    "good programming font with decent utf support
endif
"set t_Co=256                   "256 color mode; rec'd for  Vim over SSH
set splitbelow                  "(sb/nosb) new split below
set splitright                  "(spr/nospr) new split to right
"set guioptions=egmrLt          "settings w/ menu (default: "egmrLtT")
set guioptions-=m               "get rid of menu
set guioptions-=t               "get rid of tear-off menu items
set guioptions-=T               "get rid of toolbar
set guioptions+=e               "use GUI tab bar [Causes Airline issues]
set guioptions+=c               "use console dialogs instead of gui ones
set guitablabel=[%N]            "define tab text: buffer number [#]
set guitablabel+=%h             "define tab text: help buffer is [help]
set guitablabel+=%t             "define tab text: show just filename (tail)
set shortmess+=I                "disable the welcome screen
set shortmess-=S                "do show search count message when searching!
set number                      "show line numbers
set ruler                       "show cursor position below each window
set virtualedit=all             "allow cursor out of bounds
set scrolloff=4                 "minimal # of lines above/below cursor
set cmdheight=1                 "(ch) command height
set laststatus=2                "status always on (0 never; 1 split)
set lazyredraw                  "Don't update the display while executing macros
set showcmd                     "show commands as typed
set showmode                    "show mode at bottom of screen
set wildmenu                    "(wmu) make the command-line completion better
set visualbell                  "(vb) use visual bell instead of beeping!
"set fillchars=""               "get rid of characters in window separators
"set colorcolumn=80             "(cc) comma separated list of highlighted columns
"set cursorline                 "(cul/nocul) highlight cursor's line
"set guicursor=n-v-c:block-Cursor-blinkon0   # no blink cursor
"
set listchars=tab:▸\ ,eol:¬     "vimcast #1 textmate tabstops(u25b8) and EOL(u00ac)
""" STATUS LINE SETTINGS FROM DEREK WYATT """
set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]
"
"TEXT {{{1
"=======================================================
filetype plugin indent on   "ensure filetype detection enabled
syntax enable           "enable syntax highlighting, 'on' forces defaults
if executable('par') == 1   "executable() returns '-1' for 'not implemented...'
    set formatprg=par\ -w80
endif
set wrap                "word wrap (on by default) (soft-wraps text)
set linebreak           "prevent word wrap from splitting words
set breakindent         "indents broken lines to match 1st line
set showbreak=…         "elipsis char (u2026) for soft-wrapped lines
" set wrapmargin=5        "(if tw=0) # of chars to win border before wrapping starts
" set textwidth=80      "# of columns before new row automatically starts
set whichwrap=<,>,[,]   "enable <left>/<right> to loop up/down lines
set formatoptions+=l    "long lines already past tw not auto-wrapped in insert mode
" set formatoptions+=a  "automatic formatting of paragraphs
" set formatoptions-=a  "remove automatic formatting of paragraphs
" set nrformats+=alpha  "increment [A-Z a-z] (disrupts linewise " /)
" set cpo+=$            "use on screen '$' display w/ 'c' or 'C' commands
" set display=lastline  "don't display @ with long paragraphs
"
"TABS {{{1
"=======================================================
set expandtab      "expand <Tab> to spaces
set tabstop=4      "# spaces for a <Tab>
set shiftwidth=0   "(0=> follow ts) # spaces for auto indent (>> <<)
set softtabstop=-1 "(-1=> follow sw) counts n spaces when TAB or BCKSPCE key used
set backspace=2    "backspace options: 1(indent,eol); 2(indent,eol,start)
set shiftround     "round '<' '>' (same as i_ and i_) to multiples of sw
"
"SEARCH {{{1
"=======================================================
set wrapscan   "(ws) set the search scan to wrap end of buffer
set hlsearch   "highlight all search results
set incsearch  "increment search (show matches as type)
set ignorecase "case-insensitive search
set smartcase  "upper-case sensitive search
"
"AUTO-COMMANDS {{{1
"=======================================================
augroup my_autocmds
    autocmd!
    autocmd BufWinEnter *.txt,*.md silent loadview  "auto-load views
    if executable('pandoc') == 1   "executable() returns '-1' for 'not implemented...'
        autocmd Filetype html set formatprg=\ pandoc\ -f\ html\ -t\ html
    endif
augroup END
"
"PACKAGES/PLUGINS {{{1
"=======================================================
"Core Plugins
" trial plugins
packadd! exchange
packadd! scratch
"<leader>s mapped to open Scratch buffer
" packadd! loupe              "(1)center,underline; (2)\v default; (3)sets some defaults
" let g:LoupeClearHighlightMap = 0    "prevent nohls mapping to leader-n
" let g:LoupeVeryMagic = 0            " disable auto '\v'

" background plugins
packadd! matchit            "Vim distribution % plugin
packadd! commentary         "Tim Pope's commentary.vim
packadd! surround           "Tim Pope's surround.vim
packadd! unimpaired         "Tim Pope's unimpaired.vim
packadd! abolish            "Tim Pope's abolish.vim
packadd! repeat             "Tim Pope's repeat.vim
packadd! tabular            "tabular.vim for aligning text
"
" search plugins
packadd! visual-star-search "enables */# searches on visual selections
packadd! traces             "previews of ranges and substitutions
"
" visible plugins
packadd! ctrlp              "ctrlp.vim fuzzy file finder
if has('win32')
    let g:ctrlp_cache_dir =$HOME.'/AppData/Roaming/Vim/ctrlp_cache//'       " sets cache dir
endif
let g:ctrlp_arg_map = 1     "<Ctrl-Y> and <Ctrl-O> require h,v,t,<CR> as default behavior
" let g:ctrlp_switch_buffer = 'et' "only jumps to buf in window w/ <CR>; tab w/ <C-t>
" let g:ctrlp_open_multiple_files = 'h'   " open multiple files in horizontal splits
"
packadd! mundo                   "undo tree plugin (fork of gundo) REQ's Python
"let g:mundo_width = 60          "default: 45
"let g:mundo_preview_height = 40 "default: 15
"let g:mundo_right = 1           "default: 0 (off, open's on left)
"<leader>m mapped to toggle
"
packadd! nerdtree           "NerdTree File Browser for vim
if has('win32')
    let g:NERDTreeBookmarksFile=$HOME.'/vimfiles/.NERDTreeBookmarks' "set bmark loc
    let g:NERDTreeIgnore=['\c^ntuser\..*'] "don't show ntuser.* files
endif
let g:NERDTreeAutoDeleteBuffer=1 "auto bd on file delete/rename
let g:NERDTreeShowBookmarks=1   "show bookmarks by default
let g:NERDTreeShowHidden=1      "show hidden (i.e., "dot files")
" <leader>n mapped to toggle
"
let g:airline_powerline_fonts = 1 "use powerline symbols (only available for some fonts)
packadd! airline            "fancy status/tabline for vim
if !has('gui_running')
    let g:airline_powerline_fonts = 0 "don't use powerline symbols (only available for some fonts)
    let g:airline_symbols_ascii = 1   "use plain ascii symbols
endif
"
" let g:airline_section_b = airline#section#create_left(['[%n]']) "buffer # (no hunks, branch)
let g:airline_section_y = airline#section#create_right(['ffenc','[%b][0x%B]']) "add charcodes
let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]' "ignore if utf8 (windows)
if has('linux')
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' " ignore if uf8 (linux)
endif
" let g:airline_extensions = []         "disable all airlie extensions
" let g:airline_statusline_ontop = 1	"experimental feature (failed for me)
" let g:airline#extensions#tabline#enabled = 1 "show buffs in tabline (disables go+=e)
" <leader>_ mapped to toggle Whitespace checking and <leader>- to toggle Airline
"
"Terminal Plugins
if !has('gui_running')
    "for console vim
    " packadd! terminus   "Changes cursor, mouse, etc. for terminal vim
endif
"
"Colorscheme Plugins
packadd! ScrollColors       "Scroll through color schemes
" usage
"  :SCROLL or :COLOR => colorscheme browser
"  :CN/:CP => Next Color-Scheme / Previous Color-Scheme
packadd! setcolors          "another colorscheme scroller
let s:reversible = 'gruvbox one solarized8'
let s:light = 'seagrey-light vanilla-cake spring-night'
let s:blue = 'atlantis codeschool colorsbox-material lost-shrine mod8 moonlight pink-moon plastic seagrey-dark termschool two-firewatch vrunchbang-dark yellow-moon'
let s:dark = 'Kafka ayu colorsbox-stbright colorsbox-steighties colorsbox-stnight office-dark slate xoria256 jellybeans badwolf molokai tender'
let g:auto_colors = split(s:reversible.' '.s:light.' '.s:blue.' '.s:dark)
"
"Color Schemes
packadd! darkest        "darkest color schemes
packadd! lightest       "lightest color schemes
packadd! midrange       "midrange color schemes
"
"MAPPINGS {{{1
"=======================================================
" Leader settings (<leader>, <localleader>)
:let mapleader = '\'
:let maplocalleader = '-'
"
"ex mode isn't very useful, make Q repeat last macro
nnoremap Q @@
"
"make Y behave similar to C and D rather than just being yy
nnoremap Y y$
"
"Ctrl-A/Ctrl-E to move to beginning/end of command-line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
"
"FKeys Mapping
if has('win32')
    nnoremap <F2> :set shell=cmd.exe<CR>:set shellcmdflag&<CR>:set shellquote&<CR>:set shellxquote&<CR>:set shellpipe&<CR>:set shellredir&<CR>:echo "[Shell: CMD]"<CR>
    "see https://robindouglas.uk/powershell/vim/2018/04/05/PowerShell-with-Vim.html
    "set shell=powershell.exe
    "set shellcmdflag=-NoProfile\ -NoLogo\ -NonInteractive\ -Command
    "set shellpipe=| " works with '>', not with '\\|'
    "set shellredir=>
    nnoremap <F3> :set shell=powershell.exe<CR>:set shellcmdflag=-NoProfile\ -NoLogo\ -NonInteractive\ -Command<CR>:set shellquote=\"<CR>:set shellxquote=<CR>:set shellpipe=><CR>:set shellredir=><CR>:echo "[Shell: Powershell]"<CR>
    "see https://vim.fandom.com/wiki/Use_cygwin_shell
    nnoremap <F4> :set shell=C:\cygwin64\bin\bash.exe<CR>:set shellcmdflag=--login\ -c<CR>:set shellquote&<CR>:set shellxquote=\"<CR>:set shellpipe&<CR>:set shellredir&<CR>:echo "[Shell: Cygwin]"<CR>
    "<CR>:set shellslash<CR>:set shellxquote=\"<CR>let $PATH .= ';C:\cygwin64\bin'<CR>
endif
nnoremap <F5> :colorscheme gruvbox<CR>:echo g:colors_name<CR>
nnoremap <F6> :colorscheme one<CR>:echo g:colors_name<CR>
nnoremap <F7> :colorscheme Kafka<CR>:echo g:colors_name<CR>
"<F8> mappet to setcolors function NextColor (cycles subset of colorschemes)
nnoremap <F8> :call NextColor(1)<CR>
nnoremap <S-F8> :call NextColor(-1)<CR>
nnoremap <A-F8> :call NextColor(0)<CR>
"
nnoremap <F9> :set guifont=Hack:h9:cDEFAULT<CR>
nnoremap <S-F9> :set guifont=Iosevka_Extended:h10:cDEFAULT<CR>
nnoremap <F10> :set guifont=JetBrains_Mono:h9:cDEFAULT<CR>
nnoremap <S-F10> :set guifont=Fira_Code:h9:cDEFAULT<CR>
nnoremap <F11> :set guifont=Fantasque_Sans_Mono:h11:cDEFAULT<CR>
nnoremap <S-F11> :set guifont=mononoki:h10:cDEFAULT<CR>
" nnoremap <F11> :set guifont=Fantasque_Sans_Mono:h10:cDEFAULT<CR>
" nnoremap <F11> :set guifont=Source_Code_Pro:h9:cDEFAULT<CR>
"
" Vimcast Shortcut to rapidly toggle 'set list'
nnoremap <silent> <leader>l :set list!<CR>:set list?<CR>
"
" Vimcast Shortcut to rapidly toggle 'spelling'
" nnoremap <silent> <leader>s :set invspell<CR>:set spell?<CR>
"
" Vimcast :Bubbling Text
" Visually select the text that was last edited/pasted
" (NOTE if need to bubble through folds get/use upAndDown.vim plugin)
noremap gV `[v`]
" Bubble single lines (NOTE: requires unimpaired.vim)
map <C-UP> [e
map <C-DOWN> ]e
" Bubble multiple lines (NOTE: requires unimpaired.vim)
vmap <C-Up> [egv
vmap <C-DOWN> ]egv
"
" Vimcast :Edit mapping to allow tab completion for current file's directory
" http://vimcasts.org/episodes/the-edit-command/
" note: %% now allows expansion of the current file directory
"   ew (edit in window); es/ev (edit in split/vertical-split); et (edit in tab)
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
noremap <leader>ew :e <C-R>=fnameescape(expand('%:h')).'/'<CR>
noremap <leader>es :sp <C-R>=fnameescape(expand('%:h')).'/'<CR>
noremap <leader>ev :vsp <C-R>=fnameescape(expand('%:h')).'/'<CR>
noremap <leader>et :tabe <C-R>=fnameescape(expand('%:h')).'/'<CR>
"
"Scratch Mappings
nnoremap <leader>s :Scratch<CR>
nnoremap <leader>S :ScratchPreview<CR>
"
"CtrlP Mappings:
nnoremap <space><space> :CtrlPMixed<CR>
nnoremap <leader><C-P> :CtrlPLine<CR>
"
"Create shortcut combining :NERDTreeFind and :NERDTreeToggle functionality
nnoremap <silent> <expr> <leader>n g:NERDTree.IsOpen() ?  "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
"nnoremap <silent> <expr> <leader>n g:NERDTree.IsOpen() ?  "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
"
"Mundo Toggle
nnoremap <leader>m :MundoToggle<CR>
"
"Create shortcut for AirlineToggle
nnoremap <leader>- :AirlineToggle<CR>
nnoremap <leader>_ :AirlineToggleWhitespace<CR>
"
"MISCELLANEOUS {{{1
"=======================================================
" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nnoremap <silent> <leader><C-S> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
     \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
     \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
     \ . ">"<CR>
"
" " Show syntax highlighting groups for word under cursor
" http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nnoremap <leader><C-H> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"
" " Vimcast :Wrap command (:set wrap linebreak nolist)
" command! -nargs=* Wrap set wrap linebreak nolist
"
"" https://vim.fandom.com/wiki/Use_cygwin_shell
"" Credit: Siddhant
""open explorer in the current file's directory
"noremap <leader>e :!start explorer %:p:h:8<cr>
""open windows command prompt in the current file's directory
"noremap <leader>c :!start cmd /k cd %:p:h:8<cr>
""open cygwin bash in the current file's directory
"noremap <leader>b :!start bash --login -i -c 'cd `cygpath "%:p:h:8"`;bash'<cr>
"
"END
