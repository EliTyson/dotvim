" ____ ____ ____ ____ ____
"||v |||i |||m |||r |||c ||
"||__|||__|||__|||__|||__||
"|/__\|/__\|/__\|/__\|/__\|

"GENERAL {{{1
"=======================================================
filetype plugin indent on   "ensure filetype detection enabled
syntax enable               "enable syntax highlighting, `enable` is default
set commentstring=#\ %s     "(cms) set default comment string to use '#'
set wildignore+=*\\^ntuser.*,*\\AppData\\*,*.dat,*.ini,*.exe,*.ffindex,*.o,*.obj
set undofile                "(udf) create undo file when saving buffer

"INTERFACE {{{1
"=======================================================
set notermguicolors     "(notgc) nvim v0.10.0 enables by default
try|colorscheme gruvbox|catch|try|colorscheme evening|catch|endtry|endtry
"prevent vim background from overwriting terminal transparency
highlight! Normal ctermbg=NONE
" highlight link VimLineComment Comment
set splitbelow          "(sb/nosb) new split below
set splitright          "(spr/nospr) new split to right
set shortmess+=I        "(shm)disable the welcome screen
set number              "(nu)show line numbers
set relativenumber      "(rnu)show relative numbers
set virtualedit=all     "(ve) allow cursor out of bounds
set scrolloff=3         "(so)minimal # of lines above/below cursor
set breakindent         "(bri)indents broken lines to match 1st line
set linebreak           "(lbr)prevent word wrap from splitting words
set showbreak=…         "(sbr)elipsis char (u2026) for soft-wrapped lines
set guicursor+=c:ver20  "(gcr) use vertical bar/beam in command line
set listchars=tab:▸\ ,eol:¬     "vimcast #1 textmate tabstops(u25b8) and EOL(u00ac)
set listchars+=trail:-,nbsp:+   "(lcs) and trail characters and no-break-space
set ignorecase            "(ic)ignore case in search patterns
set smartcase            "(scs)override ignorecase if capitals in pattern
"set spell               "spell checking
"set lazyredraw          "(lz) Don't update the display while executing macros
"set statusline=%.20f\ [%n]%m%r%=[%03b][0x%02B][%4l/%L\ :%2c]

"TABS & WRAPPING {{{1
"=======================================================
set expandtab      "expand <Tab> to spaces
set tabstop=4      "(ts)spaces for a \t character
set shiftwidth=0   "(sw)(0=> follow ts) # spaces for auto indent (>> <<)
set softtabstop=-1 "(sts)(-1=> follow sw) spaces for <TAB> & <BS> keys
set shiftround     "(sr)round '<' '>' (same as i_ and i_) to multiples of sw
"
set wrap                    "word wrap (on by default) (soft-wraps text)
" set textwidth=79            "(tw)# of columns before new row automatically starts
set whichwrap=<,>,[,]       "(ww) enable <left>/<right> to loop up/down line N,V,I,R modes
set formatoptions+=l        "(fo) long lines already past tw not auto-wrapped in insert mode
" set cpoptions+=$          "(cpo) use on screen '$' display w/ 'c' or 'C'
" commands

"AUTO-COMMANDS {{{1
"=======================================================
augroup filetype_markdown
    autocmd!
    autocmd FileType markdown setlocal list spell
    autocmd Filetype markdown setlocal textwidth=79
    autocmd FileType markdown setlocal colorcolumn=79
    autocmd BufEnter *.md,*.markdown match Exception /\v%>79v./
    autocmd BufLeave *.md,*.markdown match none
    autocmd FileType markdown inoremap <buffer> ',, &apos;
    autocmd FileType markdown inoremap <buffer> ",, &quot;
    autocmd FileType markdown inoremap <buffer> &,, &amp;
    autocmd FileType markdown inoremap <buffer> <,, &lt;
    autocmd FileType markdown inoremap <buffer> >,, &gt;
augroup END

augroup filetype_gitcommit
    autocmd!
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType gitcommit setlocal colorcolumn=50,72
    autocmd FileType gitcommit setlocal list spell
augroup END

augroup filetype_html
    autocmd!
    " fold html tags
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
    " make pandoc the default formatprg ("gq" command) for html files
    if executable('pandoc') == 1   "executable() returns '-1' for 'not implemented...'
        autocmd FileType html setlocal formatprg=pandoc\ -f\ html\ -t\ html
    endif
augroup END

augroup filetype_python
    autocmd!
    autocmd FileType python setlocal list spell
    autocmd FileType python setlocal colorcolumn=79
    autocmd BufEnter *.py match Exception /\v%>79v./
    autocmd BufLeave *.py match none
augroup END

augroup filetype_kivy
    autocmd!
    autocmd BufNewFile,BufRead *.kv setfiletype kivy
    autocmd FileType kivy setlocal list spell
    autocmd FileType kivy setlocal commentstring=#\ %s
    autocmd FileType kivy setlocal comments=:#
augroup END

"FUNCTIONAL PLUGINS {{{1
"=======================================================
" TRIAL PLUGINS
packadd! colorizer  " produces errors in vim files: red #123456
"mapping: <leader>c mapped to ':ColorToggle'
packadd! scratch
"mapping: <leader>s mapped to open Scratch buffer

" VIM-ONLY (SEARCH) PLUGINS
if !has('nvim')
    packadd! visual-star-search "enables */# searches on visual selections
    packadd! traces             "previews of ranges and substitutions
endif

" VIM DISTRIBUTION PLUGINS
packadd! matchit            "Extended % matching plugin
packadd! cfilter            "Quickfix list filtering plugin
    " :Cfilter[!] /{pat}/
    " :Lfilter[!] /{pat}/

" Vim markdown ftplugin '$VIMRUNTIME/ftplugin/markdown.vim`
" setting to enable folding (no documentation???)
let g:markdown_folding = 1
" to enable fenced block code syntax highlighting:
" let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
" to disable markdown syntax concealing add the following to your vimrc:
" let g:markdown_syntax_conceal = 0
" Syntax highlight is synchronized in 50 lines
"   It may cause collapsed highlighting at large fenced code block.
" let g:markdown_minlines = 100

" BACKGROUND PLUGINS
packadd! commentary         "Tim Pope's commentary.vim
packadd! surround           "Tim Pope's surround.vim
packadd! unimpaired         "Tim Pope's unimpaired.vim
packadd! abolish            "Tim Pope's abolish.vim
packadd! repeat             "Tim Pope's repeat.vim
packadd! characterize       "Tim Pope's characterize.vim extending `ga`
packadd! tabular            "tabular.vim for aligning text
packadd! exchange           "exchange with cx operator (or v_X)

" VISIBLE PLUGINS
packadd! fugitive           "Git integration plugin

if executable('fzf') == 1   "executable() returns '-1' for 'not implemented...'
    packadd! fzf            "Extra fzf functionality in vim
endif

packadd! ale
let g:ale_use_global_executables = 1 "force global executables
let g:ale_hover_cursor = 0 "hover functionality (echo line)
" let g:ale_set_balloons = 1   "balloon info if ale_hover_cursor=1
" g:ale_completion_enabled = 0 "enable ale completion
    " Fix Python files with 'bar'.
    " Don't fix 'html' files.
    " Fix everything else with 'foo'.
" let g:ale_linters = {'python': ['flake8', 'pylint'],} " ['pylint']
let g:ale_linters = {'python': ['pylint'],}
" let g:ale_linters = {'python': ['flake8'],}
let g:ale_echo_msg_format = '[%linter%:%severity%] %code: %%s'
" let g:ale_linters_ignore = {'python': ['pylint'],}
" let g:ale_open_list = 1 "will cause ALE to auto open loclist
" g:ale_lint_on_text_changed=0
" g:ale_lint_on_insert_leave=0
" g:ale_lint_on_enter=0
" g:ale_lint_on_save=0
" g:ale_lint_on_filetype_changed=0
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],}
" let g:ale_update_tagstack = 0 "default: 1; 0 to disable.
"mapping: nnoremap <leader>a :ALEToggleBuffer<CR>

if has('python3')
    packadd! ultisnips
    packadd! snippets
    packadd! arduino-snippets
    " if has('nvim')
    "     " let g:UltiSnipsExpandTrigger='<tab>'
    "     let g:UltiSnipsExpandTrigger ='<C-Space>'
    " endif
    "Unlike windows, Linux is case-sensitive
    let g:UltiSnipsSnippetDirectories=["UltiSnips", "ultisnips"]
    " let g:UltiSnipsEnableSnipMate = 0 " Don't look for SnipMate snippets
    " https://github.com/python-mode/python-mode/issues/922
    silent! python3 1
    let g:ultisnips_python_style = 'google'
    let g:ultisnips_python_quoting_style = 'single'
    let g:ultisnips_python_triple_quoting_style = 'double'

    packadd! mundo                   "undo tree plugin (fork of gundo) REQ's Python
    "let g:mundo_width = 60          "default: 45
    "let g:mundo_preview_height = 40 "default: 15
    "let g:mundo_right = 1           "default: 0 (off, open's on left)
    "mapping: <leader>m mapped to toggle
endif

packadd! indent-guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 0  "set to 1, for vertical lines
let g:indent_guides_color_change_percent = 5
"mapping: <leader>i mapped to ':IndentGuidesToggle'

packadd! nerdtree           "NerdTree File Browser for vim
if has('win32') || has('win64')
    let g:NERDTreeBookmarksFile=$HOME.'/vimfiles/.NERDTreeBookmarks' "set bmark loc
    let g:NERDTreeIgnore=['\c^ntuser\..*'] "don't show ntuser.* files
else
    let g:NERDTreeBookmarksFile=$HOME.'/.vim/.NERDTreeBookmarks'
endif
let g:NERDTreeAutoDeleteBuffer=1 "auto bd on file delete/rename
let g:NERDTreeShowBookmarks=1   "show bookmarks by default
let g:NERDTreeShowHidden=1      "show hidden (i.e., "dot files")
let g:NERDTreeMinimalUI=1        "disable '? for help'
let g:NERDTreeDirArrowExpandable="▸" "instead of '+'
let g:NERDTreeDirArrowCollapsible="▾" "instead of '~'
let g:NERDTreeAutoDeleteBuffer=1 " Auto delete the buffer of deleted file
"mapping: <leader>n mapped to toggle
"mapping: <leader>N mapped to :NERDTree

"COLORSCHEME PLUGINS {{{1
packadd! airline            "fancy status/tabline for vim
" let g:airline_powerline_fonts = 1 "use powerline symbols (only available for some fonts)
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
" let g:airline_symbols.colnr = '' "no column number symbol (it wasn't working)
" use powerline fonts for terminal vim
" let g:airline_powerline_fonts = 1 "use powerline symbols (only available for some fonts)
" let g:airline_symbols_ascii = 1

" airline theme
let g:airline_theme='ravenpower'      "non-distracting grey/blue/orange
" let g:airline_theme='google_dark'     "colorful/understated green/purplish-blue/orange
" # alert colors taken from murmur.vim
" let s:cterm_alert     = 88   " Modified file alert color
" let s:gui_alert       = '#870000'
" let g:airline#themes#ravenpower#palette.normal_modified = {'airline_c': [s:gui_alert, s:N2[1], s:cterm_alert, s:N2[3], ''] ,}
" let g:airline#themes#ravenpower#palette.insert_modified = {'airline_c': [s:gui_alert, s:N2[1], s:cterm_alert, s:N2[3] ''] ,}
" let g:airline#themes#ravenpower#palette.visual_modified = {'airline_c': [s:gui_alert, '', s:cterm_alert, '', ''] ,}
" let g:airline_theme='dark'            "default yellow/blue/orange
" let g:airline_theme='codedark'        "codedark theme blue/yellow/grey
" let g:airline_theme='bubblegum'       "pastel colors green/blue/pink
" let g:airline_theme='fairyfloss'      "similar to codedark blue/green/red
" let g:airline_theme='jellybeans'      "similar to codedark blue/green/red
" let g:airline_theme='murmur'          "like jellybeans w/ colored file blue/green/orange
" let g:airline_theme='ouo'             "like jellybeans w/ colored file blue/green/orange
" let g:airline_theme='onedark'         "pastel colors green/blue/pink
" let g:airline_theme='alduin'          "pastel colors/bar purple/grey/beige
" let g:airline_theme='cool'            "colorful lines blue/green/red bar
" let g:airline_theme='xtermlight'      "light bar-bg blue/green/orange

" don't display encoding if utf-8
call airline#parts#define_condition('ffenc', '&fenc !~? "utf-8"')
" only display SPELL indicator in wide windows
" call airline#parts#define_condition('spell', 'str2nr(&columns) > 100')
" nnoremap <leader>ue :UltiSnipsEdit!<CR>
" nnoremap <leader>ur :call UltiSnips#RefreshSnippets()<CR>
call airline#parts#define_condition('spell', 'getwininfo(win_getid())[0].width > 100')
" let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]' "ignore if utf8 (windows)
" if has('linux')
"     let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' " ignore if uf8 (linux)
" endif
" abbreviate text for each mode
" 'ic' ⇒ i_CTRL-N; 'ix' ⇒ i_CTRL-X; 'ni' ⇒ i_CTRL-O; 'Rv' ⇒ gR
" 'no' ⇒ v_gr CTRL-C;
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'IC',
    \ 'ix'     : 'IX',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'NI',
    \ 'no'     : 'NO',
    \ 'R'      : 'R',
    \ 'Rv'     : 'RV',
    \ 's'      : 'S',
    \ 'S'      : 'SL',
    \ ''     : 'SB',
    \ 't'      : 'TERMINAL',
    \ 'v'      : 'V',
    \ 'V'      : 'VL',
    \ ''     : 'VB',
    \ }
" disable displaying spelling language (saves a little space)
let g:airline_detect_spelllang=0
" show word count for text-based file types
let g:airline#extensions#wordcount#filetypes =
    \ ['asciidoc', 'help', 'mail', 'markdown', 'nroff', 'org', 'plaintex', 'rst', 'tex', 'text']

" call airline#parts#define_function('charcodes', 'AirlineGetCharCodes')
" function! AirlineGetCharCodes()
"     return '"[%3b][0x%02B]"'
" endfunction
" let g:airline_section_y = airline#section#create_right(['ffenc', "charcodes"]) "add charcodes
" let g:airline_section_y = airline#section#create_right(['ffenc', '[%3b|x%02B]']) "add charcodes
" let g:airline_section_x = airline#section#create_right(['tagbar', 'filetype', '[%3b|x%02B]']) "add charcodes

" skip whitespace checks per filetype
" checks:  [ 'indent', 'trailing', 'long', 'mixed-indent-file', " 'conflicts' ]
" let g:airline#extensions#whitespace#skip_indent_check_ft = {'markdown': ['trailing']}
  " Use ['all'] to enable for all filetypes.
"mapping: <leader>_ mapped to toggle Whitespace checking and <leader>- to toggle Airline

"COLORSCHEME PLUGINS
packadd! ScrollColors       "Scroll through color schemes
" usage
"  :SCROLL or :COLOR => colorscheme browser
"  :CN/:CP => Next Color-Scheme / Previous Color-Scheme
packadd! setcolors          "another colorscheme scroller
if has('gui_running')
    let s:reversible = 'gruvbox one solarized8'
    let s:light = 'seagrey-light vanilla-cake spring-night'
    let s:blue = 'atlantis codeschool colorsbox-material lost-shrine mod8 moonlight pink-moon plastic seagrey-dark termschool two-firewatch vrunchbang-dark yellow-moon'
    let s:dark = 'codedark Kafka ayu colorsbox-stbright colorsbox-steighties colorsbox-stnight office-dark slate jellybeans badwolf molokai tender'
    let g:auto_colors = split(s:reversible.' '.s:light.' '.s:blue.' '.s:dark)
else
    let g:auto_colors = split('Kafka atlantis codedark colorsbox-stnight cosmic_latte edge gruvbox gruvbox-material OceanicNext one plastic solarized8 solarized8_flat spring-night tender')
endif

"Color Schemes
packadd! airline-themes "airline-themes
packadd! code-dark      "code-dark colorscheme
packadd! darkest        "darkest color schemes
packadd! lightest       "lightest color schemes
packadd! midrange       "midrange color schemes

"GENERAL MAPPINGS {{{1
"=======================================================
"Leader settings (<leader>, <localleader>)
:let mapleader = ','
:let maplocalleader = '\'
nnoremap <BS> ,

"jk as alternate to <C-C> or <ESC> (ignore if typing alphabet)
inoremap jk <ESC>
inoremap ijk ijk

"use visual rather than linewise up/down (except with counts)
noremap <expr> j (v:count ? 'j' : 'gj')
noremap <expr> k (v:count ? 'k' : 'gk')

"move tab pages with Shift-Left and Shift-Right
nnoremap <silent><S-Left> :<C-U> execute 'silent! tabm-'..v:count1<CR>
nnoremap <silent><S-Right> :<C-U>execute 'silent! tabm+'..v:count1<CR>

"Ctrl-A/Ctrl-E to move to beginning/end of command-line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"Make Ctrl-Backspace behave like Ctrl-W
inoremap <C-BS> <C-w>
cnoremap <C-BS> <C-w>

"Launch Explorer
if has('win32') || has('win64')
    noremap <silent> <leader>EE :set noshellslash<CR>:silent !start explorer %:p:h:8<CR>:set shellslash<CR><ESC>
elseif !has('gui_running')
    noremap <silent> <leader>EE :!setsid nautilus %:h<CR><ESC>
endif

"Toggle line wrap
nnoremap <silent> <leader>w :let &wrap = (&wrap) ? 0 : 1<CR>:set wrap?<CR>

"Toggle Paste Mode
set pastetoggle=<Insert>
if !has('gui_running')
    map <silent><leader>p :set invpaste paste?<CR>
endif

"Toggle Search Highlighting
noremap <silent> <leader><leader> :let v:hlsearch = (v:hlsearch) ? 0 : 1<CR>

" Vimcast Shortcut to rapidly toggle 'set list'
nnoremap <silent> <leader>L :set list!<CR>:set list?<CR>

" Vimcast Shortcut to rapidly toggle 'spelling'
nnoremap <silent> <leader><C-S> :set invspell spell?<CR>

"Toggle fold columns
nnoremap <silent> <leader>\| :let &l:foldcolumn = (&l:foldcolumn) ? 0 : 3<CR>

" Vimrc Mappings
noremap <leader>ve :split $MYVIMRC<CR>
noremap <leader>vs :source $MYVIMRC<CR>

"Alternate Buffer Split
noremap <leader># :sb#<CR>

"UPPERCASE/lowercase/Capitalize-toggles
inoremap <S-Up> <ESC>gUiwgi
inoremap <S-Down> <ESC>guiwgi
inoremap <C-Up> <ESC>guiw~gi
inoremap <C-Down> <ESC>guiw~gi

"   COLOR SCHEME MAPPINGS
nnoremap <F5> :colorscheme gruvbox\|redraw\|echo g:colors_name<CR>
nnoremap <F6> :colorscheme one\|redraw\|echo g:colors_name<CR>
" nnoremap <F7> :colorscheme Kafka\|redraw\|echo g:colors_name<CR>
nnoremap <F7> :colorscheme codedark\|redraw\|echo g:colors_name<CR>
"<F8> mappet to setcolors function NextColor (cycles subset of colorschemes)
" NextColor(0) chooses a random color scheme
nnoremap <F8> :call NextColor(1)<CR>
nnoremap <S-F8> :call NextColor(-1)<CR>
nnoremap <A-F8> :call NextColor(0)<CR>

"   FONT MAPPINGS
if has('gui_running')
    nnoremap <F9> :set guifont=Hack:h9\|redraw\|echo &gfn<CR>
    nnoremap <S-F9> :set guifont=Iosevka:h10\|redraw\|echo &gfn<CR>
    nnoremap <F10> :set guifont=Fira_Code:h9\|redraw\|echo &gfn<CR>
    nnoremap <S-F10> :set guifont=mononoki:h10\|redraw\|echo &gfn<CR>
    nnoremap <F11> :set guifont=JetBrains_Mono:h9\|redraw\|echo &gfn<CR>
    nnoremap <S-F11> :set guifont=InputMono:h9\|redraw\|echo &gfn<CR>
    " nnoremap <F11> :set guifont=Monoid:h9\|redraw\|echo &gfn<CR>
    " nnoremap <F11> :set guifont=Sudo:h12\|redraw\|echo &gfn<CR>
    " nnoremap <F11> :set guifont=Source_Code_Pro:h9\|redraw\|echo &gfn<CR>
endif

" Select previously changed or yanked text
noremap gV `[v`]

" Vimcast :Bubbling Text
" (NOTE if need to bubble through folds get/use upAndDown.vim plugin)
" Bubble single lines (NOTE: requires unimpaired.vim)
map <C-UP> [e
map <C-DOWN> ]e
" Bubble multiple lines (NOTE: requires unimpaired.vim)
vmap <C-Up> [egv
vmap <C-DOWN> ]egv

" Tmux Mappings
if has_key(environ(), 'TMUX')
    nnoremap <leader>tt :silent !tmux split-window -vl 10 -c %:h<CR>
    nnoremap <leader>tw :silent !tmux split-window -fvl 10 -c %:h<CR>
endif

" Vimcast :Edit mapping to allow tab completion for current file's directory
" http://vimcasts.org/episodes/the-edit-command/
" note: %% now allows expansion of the current file directory
"   ew (edit in window); es/ev (edit in split/vertical-split); et (edit in tab)
cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<CR>
" nnoremap <leader>ew :e <C-R>=fnameescape(expand('%:h')).'/'<CR>
" nnoremap <leader>es :sp <C-R>=fnameescape(expand('%:h')).'/'<CR>
" nnoremap <leader>ev :vsp <C-R>=fnameescape(expand('%:h')).'/'<CR>
" nnoremap <leader>et :tabe <C-R>=fnameescape(expand('%:h')).'/'<CR>

"PLUGIN MAPPINGS {{{1
"=======================================================
if has('python3')
    "UltiSnips Mappings
    nnoremap <leader>ue :UltiSnipsEdit!<CR>
    nnoremap <leader>uE :UltiSnipsEdit<CR>
    nnoremap <leader>ur :call UltiSnips#RefreshSnippets()<CR>

    "Mundo Toggle
    nnoremap <leader>m :MundoToggle<CR>
endif

"ALE Mappings
nnoremap <silent><leader>AA :ALEToggleBuffer<CR>:echo b:ale_enabled ? "ALE On" : "ALE Off"<CR>
nnoremap <silent><leader>At :ALEToggle<CR>:echo g:ale_enabled ? "ALE Enabled" : "ALE Disabled"<CR>
nnoremap <silent><leader>Ad :ALEDetail<CR>
nnoremap <silent><leader>Ai :ALEInfo<CR>
nnoremap <silent><leader>Af :ALEFix<CR>
nnoremap <silent><leader>AF :let g:ale_fix_on_save = (g:ale_fix_on_save) ? 0 : 1<CR>:echo g:ale_fix_on_save ? "ALE fix on save: ON" : "ALE fix on save: OFF"<CR>

"Indent-Guides Mappings
nnoremap <leader>i :IndentGuidesToggle<CR>

"Colorizer Mappings
nnoremap <leader>c :ColorToggle<CR>

"Scratch Mappings
nnoremap <leader>s :Scratch<CR>
nnoremap <leader>S :ScratchPreview<CR>

"FZF Mappings
if executable('fzf') == 1   "executable() returns '-1' for 'not implemented...'
    nnoremap <C-F> :FZF<CR>

    "FZF-vim Mappings
    nnoremap <space><space> :History<CR>
    nnoremap <leader>f :Files<CR>
    nnoremap <leader>Ff :GFiles<CR>
    nnoremap <leader>FF :GFiles?<CR>
    nnoremap <leader>Fg :BCommits<CR>
    nnoremap <leader>FG :Commits<CR>
    nnoremap <leader>Fb :Buffers<CR>
    nnoremap <leader>Fc :Colors<CR>
    nnoremap <leader>FC :Commands<CR>
    nnoremap <leader>Fl :BLines<CR>
    nnoremap <leader>FL :Lines<CR>
    nnoremap <leader>Ft :BTags<CR>
    nnoremap <leader>FT :Tags<CR>
    nnoremap <leader>Fe :Filetypes<CR>
    nnoremap <leader>Fm :Marks<CR>
    nnoremap <leader>FM :Maps<CR>
    nnoremap <leader>Fw :Windows<CR>
    nnoremap <leader>F: :History:<CR>
    nnoremap <leader>F/ :History/<CR>
    nnoremap <leader>Fs :Snippets<CR>
    nnoremap <leader>Fh :Helptags<CR>

    "FZF-vim Mapping for selecting mappings
    nnoremap <leader><tab> <plug>(fzf-maps-n)
    xnoremap <leader><tab> <plug>(fzf-maps-x)
    onoremap <leader><tab> <plug>(fzf-maps-o)
endif

"NERDTree Mappings
" nnoremap <leader>N :NERDTree<CR>
nnoremap <silent> <expr> <leader>N g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : "\:NERDTree<CR>"
"Create shortcut combining :NERDTreeFind and :NERDTreeToggle functionality
nnoremap <silent> <expr> <leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

"Airline Mappings
nnoremap <leader>- :AirlineToggle<CR>
nnoremap <leader>_ :AirlineToggleWhitespace<CR>

"EXPERIMENTAL MAPPINGS {{{1
"=======================================================
cabbrev pandoc! !pandoc %:p:S -o "%:p:h/%:t:r.html" -s --toc -c notes.css
cabbrev pandocT! !pandoc %:p:S -o "%:p:h/%:t:r.html" -s --toc -c notes.css -M title="%:t:r"

iabbrev ->;; →
iabbrev =>;; ⇒

abbrev <expr> d;; strftime("%Y-%m-%d")
abbrev <expr> D;; '['.strftime("%Y-%m-%d").']'
abbrev <expr> pwd;; fnameescape(expand('%:p:h'))
abbrev <expr> PWD;; fnameescape(getcwd())
abbrev <expr> ls;; fnameescape(expand('%:p:h')) . "/"

digraph ## 9552 "═ digraph (Box drawings double horizontal)
digraph zw 8204 " digraph of a zero width non joiner character (U+200C)

"Quickfix and Location List movement based on cursor position
nnoremap [gl :lbefore<CR>
" nnoremap [<A-L> :labove<CR>
nnoremap ]gl :lafter<CR>
" nnoremap ]<A-L> :lbelow<CR>

nnoremap [gq :cbefore<CR>
" nnoremap [<A-C> :cabove<CR>
nnoremap ]gq :cafter<CR>
" nnoremap ]<A-C> :cbelow<CR>
"FKeys Mapping

nnoremap <silent> <leader>W :2match Error /\v\s+$/<CR>
nnoremap <silent> <leader>WW :2match none<CR>

" if executable('par') == 1   "executable() returns '-1' for 'not implemented...'
"     set formatprg=par\ -w79
" endif

" " Vimcast :Wrap command (:set wrap linebreak nolist)
" command! -nargs=* Wrap set wrap linebreak nolist

"" https://vim.fandom.com/wiki/Use_cygwin_shell
"" Credit: Siddhant
""open explorer in the current file's directory
"noremap <leader>e :!start explorer %:p:h:8<cr>
""open windows command prompt in the current file's directory
"noremap <leader>c :!start cmd /k cd %:p:h:8<cr>
""open cygwin bash in the current file's directory
"noremap <leader>b :!start bash --login -i -c 'cd `cygpath "%:p:h:8"`;bash'<cr>

" Mapped Functions {{{2
"-------------------------------------------------------
nnoremap <silent> <leader>T :call <SID>TransparencyToggle()<CR>
function! s:TransparencyToggle()
    if !has('nvim')
        if has_key(hlget('Normal', v:true)[0], 'ctermbg') ||
        \ has_key(hlget('EndOfBuffer', v:true)[0], 'ctermbg')
            if has_key(hlget('Normal', v:true)[0], 'ctermbg')
                let g:prev_normal_ctermbg = hlget('Normal', v:true)[0]['ctermbg']
                highlight! Normal ctermbg=NONE
                call hlset([{name: 'Normal', ctermbg: 'NONE'}])
            endif
            if has_key(hlget('EndOfBuffer', v:true)[0], 'ctermbg')
                let g:prev_eob_ctermbg = hlget('EndOfBuffer', v:true)[0]['ctermbg']
                call hlset([{name: 'EndOfBuffer', ctermbg: 'NONE'}])
            endif
        elseif exists("g:prev_normal_ctermbg") || exists("g:prev_eob_ctermbg")
            if exists("g:prev_normal_ctermbg")
                if hlset([{name: 'Normal', ctermbg: g:prev_normal_ctermbg}])
                    unlet g:prev_normal_ctermbg
                endif
            endif
            if exists("g:prev_eob_ctermbg")
                if hlset([{name: 'EndOfBuffer', ctermbg: g:prev_eob_ctermbg}])
                    unlet g:prev_eob_ctermbg
                endif
            endif
        endif
    " Simplified Neovim version (does not store previous bkg)
    else
        if exists("g:has_transparent_bkg") && g:has_transparent_bkg
            " if bkg is transparent, make it black (does not restore old bkg)
            highlight Normal ctermbg=0
            let g:has_transparent_bkg = v:false
        else
            highlight Normal ctermbg=NONE
            let g:has_transparent_bkg = v:true
        endif
    endif
endfunction

" toggle quickfix window
nnoremap <silent> <leader>q :call <SID>QuickfixToggle()<CR>
function! s:QuickfixToggle()
    let quickfixtoggle_previous_window_id = win_getid()
    let win_info = getwininfo()
    cclose
    "
    " copen if cclose did nothing
    if win_info ==# getwininfo()
        let g:quickfixtoggle_copen_window_id = win_getid()
        copen
    " go to correct window if cclose worked
    else
        " try to restore to previous window location
        " if previous window was quickfix go to window when toggle opened
        if !win_gotoid(quickfixtoggle_previous_window_id)
            if exists("g:quickfixtoggle_copen_window_id")
                call win_gotoid(g:quickfixtoggle_copen_window_id)
            endif
        endif
    endif
endfunction

" toggle location list window
nnoremap <silent> <leader>ll :call <SID>LocationListToggle()<CR>
function! s:LocationListToggle()
    let loclist_toggle_previous_window_id = win_getid()
    let win_info = getwininfo()
    lclose
    "
    " lopen if lclose did nothing
    if win_info ==# getwininfo()
        let g:loclist_toggle_copen_window_id = win_getid()
        lopen
    " go to correct window if lclose worked
    else
        " try to restore to previous window location
        " if previous window was loclist go to window when toggle opened
        if !win_gotoid(loclist_toggle_previous_window_id)
            if exists("g:loclist_toggle_copen_window_id")
                call win_gotoid(g:loclist_toggle_copen_window_id)
            endif
        endif
    endif
endfunction

" toggle `help` and `text` filetypes for current buffer
nnoremap <silent> <leader><F1> :call <SID>HelpToTextToggle()<CR>
function! s:HelpToTextToggle()
    if &filetype =~# '\vhelp|text' || &filetype ==# ''
        let &filetype = !(&filetype ==# 'help') ? 'help' : 'text'
    endif
endfunction

" create an Ex-command to quickly browse a filtered list of oldfiles
command -nargs=? -bang BFilterOldfiles call <SID>BrowseFilterOldfiles(<q-args>, !empty('<bang>'), '<mods>')
function! s:BrowseFilterOldfiles(filter_pattern, is_split, mods)
    let bname = bufname()
    execute 'browse filter /\c' . a:filter_pattern . '/ oldfiles'
    "if ! used and buffer changed, split buffer and use <mods>
    if a:is_split && bname != bufname()
        execute "normal! \<C-^>"
        silent execute "normal! :" . a:mods . " sbuffer #\<CR>"
    endif
endfunction

" DEREK WYATT: The following beast is something i didn't write... it will
" return the syntax highlighting group that the current "thing" under the
" cursor belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
"   'lo' uses 'synIDtrans()' which follows links to base highlight group.
nnoremap <silent> <leader>H :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
     \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
     \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
     \ . ">"<CR>

" " Show syntax highlighting groups for word under cursor
" http://vimcasts.org/episodes/creating-colorschemes-for-vim/
"   groups are ordered from outermost to innermost.
nnoremap <leader><C-H> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

"PORTABILITY {{{1
"=======================================================
if !has('nvim')
    set hidden            "(hid) allow hiding unsaved buffers
    " nvim does not utilize `:hardcopy` and uses `[range]:TOhtml` instead and
    " print the resulting html file (NOTE: folds are not expanded)
    " let &printfont = &guifont "print using the same font as guifont
    set printoptions+=number:y  "default is (number:n ⇒ no line numbers)
    set printoptions+=left:5pc  "default is (left:10pc,right:5pc,top:5pc,bottom:5pc)
    set background=dark    "(bg) dark background (terminal defaults to light)
    set fillchars=""       "(fcs)get rid of characters in window separators
    set showcmd            "(sc) show commands as typed (default off for Unix)
    set laststatus=2       "(ls) status line always on (0 never; 1 split)
    set display=lastline   "(dy) don't display @ with long paragraphs
    set formatoptions+=j   "(fo) sensibly join comments
    set nojoinspaces       "(nojs) don't add extra space after .?! with join commands
    set hlsearch           "(hls)highlight all search results
    set incsearch          "(is)increment search (show matches as type)
    set shortmess-=S       "(shm)do show search count message when searching!
    set noundofile         "(udf) ** no undofile if not on `nvim` **
    "ex mode isn't very useful, make Q repeat last macro
    nnoremap Q @@
    "make Y behave similar to C and D rather than just being yy
    nnoremap Y y$
endif
if has('win32') || has('win32unix')
    set pythonthreedll=python39.dll "was defaulting to python37.dll
    set shellslash        "(ssl) force forward slash for expanded filenames
    set path+=$HOME,$HOME/Desktop                      "set path to search for find commands
    set viewdir=$HOME/vimfiles/views//                 "sets directory to save views
    set directory=$HOME/AppData/Roaming/Vim//          "sets directory (used for swap files)
    set backupdir=$HOME/AppData/Roaming/Vim//          "sets directory for write backups
    set undodir=$HOME/AppData/Roaming/Vim//            "sets directory for undo files
    set viminfofile=$HOME/AppData/Roaming/Vim/_viminfo "sets file name for viminfo
    " set shell=pwsh.exe shellcmdflag=-NoProfile\ -NoLogo\ -NonInteractive\ -Command
    " set shellquote=\" shellpipe=> shellredir=> shellxquote=
    " Make terminal Campbell blue
    highlight Terminal guibg=#012456
    if executable('grep') == 1   "executable() returns '-1' for 'not implemented...'
        let &g:grepprg='grep -n' "use grep (and prefix line #), instead of findstr
    endif
    if has('win32unix') && !has('nvim')                      "cygwin settings
        set packpath^=$HOME/vimfiles//                       "sets directory to save views
        set packpath+=/c/Program\ Files\ (x86)/Vim/vim82//
        let $VIMRUNTIME = '/c/Program Files (x86)/Vim/vim82' "for syntax.vim
        let $VIM = '/c/Program Files (x86)/Vim'
        set runtimepath^=/c/Program\ Files\ (x86)/Vim/vim82
    endif
"   TERMINAL MAPPINGS
    nnoremap <F2> :set shell=cmd.exe<CR>:set shellcmdflag&<CR>:set shellquote&<CR>:set shellxquote&<CR>:set shellpipe&<CR>:set shellredir&<CR>:echo "[Shell: CMD]"<CR>
    "see https://robindouglas.uk/powershell/vim/2018/04/05/PowerShell-with-Vim.html
    " use pwsh.exe for powershell 6 and above
    nnoremap <F3> :set shell=pwsh.exe<CR>:set shellcmdflag=-NoProfile\ -NoLogo\ -NonInteractive\ -Command<CR>:set shellquote=\"<CR>:set shellxquote=<CR>:set shellpipe=><CR>:set shellredir=><CR>:echo "[Shell: Powershell]"<CR>

    cabbrev pandoc! !pandoc %:p:S -o %:p:h:8/%:t:r.html -s --toc -c notes.css
    cabbrev pandocT! !pandoc %:p:S -o %:p:h:8/%:t:r.html -s --toc -c notes.css -M title="%:t:r"
endif
if has('gui_running')
    set lines=50 columns=100
    "set guioptions=egmrLt "(go) settings w/ menu (default: 'egmrLtT')
    set guioptions-=m      "get rid of menu
    set guioptions-=t      "get rid of tear-off menu items
    set guioptions-=T      "get rid of toolbar
    set guioptions+=e      "use GUI tab bar (causes Airline issues)
    set guioptions+=c      "use console dialogs instead of GUI ones
    set guioptions+=!      "execute  external commands in a terminal window
    set guitablabel=[%N]   "define tab text: tab number [#]
    set guitablabel+=%h    "define tab text: help buffer is [help]
    set guitablabel+=%t    "define tab text: show just filename (tail)
    if has('win32') || has('win64')
        try|set guifont=Hack:h9|catch|endtry    "good programming font with decent utf support
    elseif has('linux')
        try|set guifont=Hack Nerd Font 10|catch|endtry    "format for Linux
    endif
endif
" Reset cursor at startup
"   terminals not using block cursor may cause problems because
"   vim only resets the cursor AFTER exiting insert mode
" <https://github.com/g6ai/dotfiles/wiki/vimrc#cursor-setting>
if !has('nvim') && !has('gui_running')
    augroup reset_cursor_shape
        au!
        autocmd VimEnter * normal! :startinsert :stopinsert
        autocmd VimEnter * redraw!

        "<https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html>
        " `2` Block,  `[4 Underline, `[6` Beam; (subtract 1 for blinking)
        autocmd VimLeave * silent !echo -ne "\e[6 q"
    augroup END
endif
if has('browse')
    abbrev <expr> f;; fnamemodify(browse(0, 'File Path', '%:p:h', ''), ":p")
    abbrev <expr> F;; fnamemodify(browse(0, 'File Path', '.', ''), ":p")
    " abbrev <expr> F;; '"' . fnamemodify(browse(0, 'File Path', '%:p:h', ''), ':p') . '"'
endif
"END }}}
" vim: foldmethod=marker
