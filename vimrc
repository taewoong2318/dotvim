" Author: Taewoong Han <mail@taewoong.me>

" options {{{1
set encoding=utf-8
scriptencoding utf-8
set fileencodings+=cp932,enc-jp

if &compatible
  set nocompatible
endif

augroup vimrc
  autocmd!
augroup END

set ambiwidth=double
set autoindent
set autoread
set backspace=indent,eol,start
set completeopt=menuone,noinsert
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set display=lastline
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=0
set modeline
set nocursorline
set nonumber
set noshowcmd
set omnifunc=syntaxcomplete#Complete
set pumheight=10
set ruler
set shiftwidth=4
set signcolumn=no
set smartcase
set softtabstop=4
set splitbelow
set tabstop=4
set title
set wildmode=longest,list

if has('unix')
  set viminfo+=n~/.vim/viminfo
  set directory=~/.vim/swap
  call mkdir(&directory, 'p')

  let s:zsh = '/bin/zsh'
  let s:bash = '/bin/bash'
  if executable(s:zsh)
    let &shell = s:zsh
  elseif executable(s:bash)
    let &shell = s:bash
  endif
elseif has('win32')
  set viminfo+=n~/vimfiles/viminfo
  set directory=~/vimfiles/swap
  call mkdir(&directory, 'p')

  let s:pwsh = 'pwsh'
  let s:powershell = 'powershell'
  if executable(s:pwsh)
    let &shell = s:pwsh
  elseif executable(s:powershell)
    let &shell = s:powershell
  endif
endif

syntax enable

filetype plugin indent on

autocmd vimrc FileType c         setlocal sts=4 sw=4 ts=4
autocmd vimrc FileType json      setlocal sts=2 sw=2 ts=2
autocmd vimrc FileType sshconfig setlocal sts=2 sw=2 ts=2
autocmd vimrc FileType yaml      setlocal sts=2 sw=2 ts=2

autocmd vimrc FileType * setlocal formatoptions-=ro indentkeys-=0#

let g:mapleader = "\<Space>"

let g:loaded_2html_plugin      = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_manpager_plugin   = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrw             = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1

let g:markdown_fenced_languages = ['bash=sh', 'c', 'cpp', 'cs', 'css', 'html', 'go', 'java', 'javascript', 'json', 'php', 'python', 'ruby', 'rust', 'typescript', 'vim', 'yaml']

" shortcuts {{{1
command! CdHere :cd %:h
command! Reload :source $MYVIMRC
command! Vimrc  :edit $MYVIMRC

" mappings {{{1
nnoremap <C-J> <Cmd>bnext<CR>
nnoremap <C-K> <Cmd>bprevious<CR>

" plugins {{{1
call plug#begin()

Plug 'andymass/vim-matchup'
Plug 'chrisbra/Recover.vim'
Plug 'cohama/lexima.vim'
Plug 'dstein64/vim-startuptime'
Plug 'godlygeek/tabular'
Plug 'junegunn/gv.vim'
Plug 'kana/vim-smartword'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/vim-protocol'
Plug 'machakann/vim-sandwich'
Plug 'markonm/traces.vim'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'simeji/winresizer'
Plug 'svermeulen/vim-subversive'
Plug 'thinca/vim-partedit'
Plug 'thinca/vim-qfreplace'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-scripts/mips.vim'

call plug#end()

for k in keys(g:plugs)
  if !isdirectory(g:plugs[k]['dir'])
    finish
  endif
endfor

" cohama/lexima.vim {{{2
let g:lexima_ctrlh_as_backspace = 1
let g:lexima_disable_on_nofile = 1

autocmd vimrc FileType text let b:lexima_disabled = 1

call lexima#add_rule({'char': '"', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': "'", 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': '(', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': ')', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': '[', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': ']', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': '`', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': '{', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': '}', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': '<BS>', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': '<CR>', 'syntax': ['Comment', 'String']})
call lexima#add_rule({'char': '<Space>', 'syntax': ['Comment', 'String']})

" kana/vim-smartword {{{2
map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
map ge <Plug>(smartword-ge)

" lambdalisue/fern.vim {{{2
nnoremap <Leader>f <Cmd>Fern . -drawer -toggle -stay<CR>

let g:fern_disable_startup_warnings = 1

" ntpeters/vim-better-whitespace {{{2
highlight! link ExtraWhitespace Error

" simeji/winresizer {{{2
let g:winresizer_start_key = '<Leader>e'

" svermeulen/vim-subversive {{{2
nmap s <Plug>(SubversiveSubstitute)
nmap ss <Plug>(SubversiveSubstituteLine)
nmap S <Plug>(SubversiveSubstituteToEndOfLine)

" vim: fdm=marker
