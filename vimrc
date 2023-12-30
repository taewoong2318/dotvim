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
set viminfo+=n~/.vim/viminfo
set directory=~/.vim/swap
set shell=/bin/bash

if has('termguicolors')
    set termguicolors
endif

syntax enable

filetype plugin indent on

augroup VimrcIndent
    autocmd!
    autocmd FileType json setlocal ts=2 sts=2 sw=2
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2
    autocmd FileType sshconfig setlocal ts=2 sts=2 sw=2
    autocmd FileType c setlocal ts=4 sts=4 sw=4
augroup END

augroup VimrcFormatOptions
    autocmd!
    autocmd FileType * setlocal formatoptions-=ro indentkeys-=0#
augroup END

command! Vimrc :edit $MYVIMRC <args>

packadd nord
colorscheme nord

packadd auto-pairs

packadd lsp

function! s:onLspAttached()
    setlocal tagfunc=lsp#lsp#TagFunc
    setlocal formatexpr=lsp#lsp#FormatExpr()

    nnoremap <buffer> gd <cmd>:LspGotoDefinition<CR>
    nnoremap <buffer> gD <cmd>:LspGotoDeclaration<CR>
    nnoremap <buffer> gr <cmd>:LspShowReferences<CR>
    nnoremap <buffer> K <cmd>:LspHover<CR>
    nnoremap <buffer> <C-k> <cmd>:LspDiag current<CR>
endfunction

augroup VimrcLsp
    autocmd!
    autocmd User LspAttached call s:onLspAttached()
augroup END

call LspOptionsSet(#{
    \    autoComplete: v:false,
    \    omniComplete: v:true,
    \    showSignature: v:false
    \  })

call LspAddServer([#{
    \    name: 'clangd',
    \    filetype: ['c', 'cpp'],
    \    path: $HOME . '/.vim/language-servers/clangd_17.0.3/bin/clangd',
    \    args: ['--background-index']
    \  }])
