set encoding=utf-8
scriptencoding utf-8
set fileencodings+=cp932,enc-jp

if &compatible
    set nocompatible
endif

set title
set ruler
set noshowcmd
set display=lastline
set splitbelow
set nonumber
set signcolumn=auto
set cursorline
set pumheight=10
set laststatus=0
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set hlsearch
set ignorecase
set smartcase
set incsearch
set backspace=indent,eol,start
set wildmode=longest,list
set autoread
set omnifunc=syntaxcomplete#Complete
set hidden
set modeline
set completeopt=menu,menuone
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set ambiwidth=double
set background=dark

let g:VimHome = expand('<sfile>:p:h')

let &viminfo .= ',n' . g:VimHome . '/viminfo'
let &directory = g:VimHome . '/swap'

if has('unix')
    set shell=bash
elseif has('win32')
    set shell=pwsh
endif

if has('termguicolors')
    set termguicolors
endif

syntax enable

filetype plugin indent on

augroup VimrcFormatOptions
    autocmd!
    autocmd FileType * setlocal formatoptions-=ro indentkeys-=0#
augroup END
