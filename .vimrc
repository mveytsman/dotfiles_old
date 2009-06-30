" Max's branch
set nocompatible               " VIM extensions, not very VI compatible;
                               "   this setting must be set because when vim
                               "   finds a .vimrc on startup, it will set
                               "   itself as "compatible" with vi

if has("syntax")
	syntax on
endif

map  BdW
imap  BdWi 

if has('cmdline_info')
    set ruler                  " show the ruler
    " a ruler on steroids
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd                " show partial commands in status line and
                               " selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=1           " show statusline only if there are > 1 windows
    " a statusline, also on steroids
    set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P
endif

filetype on                    " enable filetype detection
filetype plugin indent on
set wrap                       " wrap long lines
set autoindent                 " indent at the same level of the previous line
set smartindent                " Do smart indenting...
set shiftwidth=4               " use indents of 4 spaces
set smarttab                   " Smart tabbing, makes backspace be nice.
set comments=sO:*-,mO:*,exO:*/,s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:-
set formatoptions+=tcq         " basic formatting of text and comments
set matchpairs+=<:>            " match, to be used with % 
set softtabstop=4
set textwidth=79

auto BufNewFile,BufRead *.[CcHh] set cindent expandtab si ai tabstop=4 shiftwidth=4 
"auto BufNewFile,BufRead *.java set expandtab si ai tabstop=4 shiftwidth=4 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:- fo-=ro
auto BufNewFile,BufRead *.java,*.jsp set expandtab si ai tabstop=4 shiftwidth=4 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:- sts=4
auto BufNewFile,BufRead *.php set expandtab si ai tabstop=4 shiftwidth=4 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:-  sts=4
auto BufNewFile,BufRead *.pl,*.py set expandtab si ai tabstop=8 shiftwidth=4 comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:-  sts=4
auto BufNewFile,BufRead *.pyt set filetype=xml
auto BufNewFile,BufRead Scons* set filetype=python
auto BufNewFile,BufRead *.hs set expandtab si ai tabstop=4 shiftwidth=4 sts=4
auto FileType mail set tw=74

set showmatch
set autowrite

"if has('statusline')
 "   set laststatus=1           " show statusline only if there are > 1 windows
        " a statusline, also on steroids
  "  set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P
"endif
set number
set backspace=2
colorscheme morning
hi clear Constant
hi Constant term=underline ctermfg=4 guifg=Magenta
set background=light
vmap <C-c> "+y<esc>i
vmap <C-x> "+x<esc>i
imap <C-v> <esc>l"+gPi
map <C-v> <esc>"+gPi
map <C-a> <c>ggVG
imap <C-a> <esc>ggVG
set hlsearch



"For miniBufferExplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

"Mouse in visual mode
set mouse=a

"Omni completion in python
autocmd FileType python set omnifunc=pythoncomplete#Complete

let g:tex_flavor='latex'
