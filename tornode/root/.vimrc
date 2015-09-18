" surman config
" Tue Nov 25 21:28:40 CET 2014

set nocompatible
set nofoldenable
set number
set title
set ruler
set expandtab
set shiftwidth=4
set softtabstop=4
set modeline

"  mouse
" --------
" n  Normal mode
" v  Visual mode
" i  Insert mode
" c  Command-line mode
" h  all previous modes when editing a help file
" a  all previous modes
" r  for |hit-enter| and |more-prompt| prompt

"set mouse=c
"set mouse=a
"set mouse=i
set mouse=

syntax on
filetype on
filetype plugin indent on

" F3 paste mode
nnoremap <F3> :set invpaste paste?<Enter>
imap <F3> <C-O><F3>
set pastetoggle=<F3>

" open from last edited position
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

colorscheme molokai
