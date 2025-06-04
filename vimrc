" Vim configuration with portability in mind, for Linux, macOS, and Windows
"
" Author: Taewoong Han <mail@taewoong.me>

" Remove all the autocommands in vimrc to avoid multiple registration
augroup vimrc
  autocmd!
augroup END

" options {{{1
set ambiwidth=double
set autoindent
set autoread
set completeopt=menuone,noinsert
set diffopt+=algorithm:histogram,indent-heuristic,vertical
set display=lastline
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,default,latin1
set fileformats=unix,dos,mac
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set infercase
set laststatus=0
set nostartofline
set nrformats-=octal
set omnifunc=syntaxcomplete#Complete
set pumheight=10
set ruler
set shiftwidth=0    " Use the value of 'tabstop'
set showcmd
set signcolumn=no
set smartcase
set softtabstop=-1  " Use the value of 'tabstop'
set splitbelow
set tabstop=4
set title
set ttimeout
set ttimeoutlen=100       " See https://vi.stackexchange.com/a/24938
set virtualedit=block
set wildmode=longest,list " Complete like Bash

" Store *.swp and viminfo under ~/.vim/.cache (~\vimfiles\.cache on Windows)
let s:cache_dir = expand('<sfile>:p:h') . '/.cache'

let s:swap_dir = s:cache_dir . '/swap'
if !isdirectory(s:swap_dir)
  call mkdir(s:swap_dir, 'p')
endif
let &directory = s:swap_dir . '//'

let &viminfo .= ',n' . s:cache_dir . '/viminfo'

" Use keyword completion on Unix
let s:unix_words_file = '/usr/share/dict/words'
if has('unix') && filereadable(s:unix_words_file)
  let &dictionary = s:unix_words_file
endif

syntax enable

filetype plugin indent on

" Disable the automatic insertion of a comment leader on every file type
autocmd vimrc FileType *
      \ setlocal formatoptions-=r |
      \ setlocal formatoptions-=o

" variables {{{1
let g:mapleader = "\<Space>"

" Disable unnecessary built-in plugins (under $VIMRUNTIME/plugin)
let g:loaded_2html_plugin      = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_manpager_plugin   = 1
let g:loaded_matchparen        = 1
let g:loaded_netrw             = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1

" Enable fenced code block syntax highlighting
" Some aliases are picked up from:
" https://github.com/github-linguist/linguist/blob/main/lib/linguist/languages.yml
let g:markdown_fenced_languages = [
      \ 'c', 'cpp', 'c++=cpp', 'cs', 'c#=cs', 'css', 'html', 'go', 'golang=go',
      \ 'javascript', 'js=javascript', 'json', 'php', 'python', 'ruby',
      \ 'rb=ruby', 'rust', 'rs=rust', 'sh', 'bash=sh', 'shell=sh', 'zsh=sh',
      \ 'typescript', 'ts=typescript', 'vim', 'viml=vim', 'vimscript=vim',
      \ 'yaml', 'yml=yaml'
      \ ]

" commands {{{1
" Define some shortcuts
command! -nargs=0 -bar CdHere   cd %:h
command! -nargs=0 -bar Reload   source $MYVIMRC
command! -nargs=0 -bar Vimrc    edit $MYVIMRC

" mappings {{{1
" Switch buffers quickly
nnoremap <C-J> <Cmd>bnext<CR>
nnoremap <C-K> <Cmd>bprevious<CR>

" Use CTRL-L to stop highlighting and redraw
nnoremap <C-L> <Cmd>nohlsearch<CR><C-L>

" Start new undoable edit before CTRL-U
inoremap <C-U> <C-G>u<C-U>

" Yank from the cursor to the end of the line
inoremap Y y$

" plugins {{{1
call plug#begin()

" Use full URLs instead of '<user>/<repository>' because you have to simply
" paste URLs to add plugins and can open the web page by typing 'gx' as well
Plug 'https://github.com/andymass/vim-matchup'
Plug 'https://github.com/chrisbra/Recover.vim'
Plug 'https://github.com/cohama/lexima.vim'
Plug 'https://github.com/dstein64/vim-startuptime'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/junegunn/goyo.vim'
Plug 'https://github.com/junegunn/gv.vim'
Plug 'https://github.com/junegunn/vim-plug'
Plug 'https://github.com/kana/vim-smartword'
Plug 'https://github.com/lambdalisue/vim-protocol'
Plug 'https://github.com/lambdalisue/vim-suda'
Plug 'https://github.com/machakann/vim-sandwich'
Plug 'https://github.com/markonm/traces.vim'
Plug 'https://github.com/moll/vim-bbye'
Plug 'https://github.com/ntpeters/vim-better-whitespace'
Plug 'https://github.com/psliwka/vim-smoothie'
Plug 'https://github.com/rhysd/vim-healthcheck'
Plug 'https://github.com/simeji/winresizer'
Plug 'https://github.com/thinca/vim-partedit'
Plug 'https://github.com/thinca/vim-qfreplace'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-rhubarb'
Plug 'https://github.com/tpope/vim-sleuth'
Plug 'https://github.com/vim-jp/vimdoc-ja'
Plug 'https://github.com/vim-scripts/mips.vim'

if has('patch-8.1.0311')
  packadd cfilter
endif

if has('patch-8.2.5136')
  Plug 'https://github.com/lambdalisue/vim-fern'
  Plug 'https://github.com/lambdalisue/vim-fern-hijack'
endif

if has('patch-9.1.0375')
  packadd comment
elseif
  Plug 'https://github.com/tpope/vim-commentary'
endif

call plug#end()

" Exit vimrc immediately if there are plugins that are not yet installed
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) != 0
  if isdirectory(g:plug_home)
    echohl WarningMsg
    echo 'Warning: There are plugins that are not yet installed.'
    echohl None
  endif

  finish
endif

" https://github.com/cohama/lexima.vim {{{2
let g:lexima_ctrlh_as_backspace = 1
let g:lexima_disable_on_nofile = 1

autocmd vimrc FileType markdown,text let b:lexima_disabled = 1

" Disable the default rules when the cursor is in a comment
call lexima#add_rule({'char': '"', 'input': '"', 'syntax': 'Comment'})
call lexima#add_rule({'char': "'", 'input': "'", 'syntax': 'Comment'})
call lexima#add_rule({'char': '(', 'input': '(', 'syntax': 'Comment'})
call lexima#add_rule({'char': ')', 'input': ')', 'syntax': 'Comment'})
call lexima#add_rule({'char': '[', 'input': '[', 'syntax': 'Comment'})
call lexima#add_rule({'char': ']', 'input': ']', 'syntax': 'Comment'})
call lexima#add_rule({'char': '`', 'input': '`', 'syntax': 'Comment'})
call lexima#add_rule({'char': '{', 'input': '{', 'syntax': 'Comment'})
call lexima#add_rule({'char': '}', 'input': '}', 'syntax': 'Comment'})
call lexima#add_rule({'char': '<BS>', 'input': '<BS>', 'syntax': 'Comment'})
call lexima#add_rule({'char': '<CR>', 'input': '<CR>', 'syntax': 'Comment'})
call lexima#add_rule({'char': '<Space>', 'input': '<Space>', 'syntax': 'Comment'})

" Disable the default rules when the cursor is at the front of a word
call lexima#add_rule({'at': '\%#\w', 'char': "'", 'input': "'"})
call lexima#add_rule({'at': '\%#\w', 'char': '"', 'input': '"'})
call lexima#add_rule({'at': '\%#\w', 'char': '(', 'input': '('})
call lexima#add_rule({'at': '\%#\w', 'char': '[', 'input': '['})
call lexima#add_rule({'at': '\%#\w', 'char': '`', 'input': '`'})
call lexima#add_rule({'at': '\%#\w', 'char': '{', 'input': '{'})

" https://github.com/kana/vim-smartword {{{2
map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
map ge <Plug>(smartword-ge)

" https://github.com/lambdalisue/fern.vim {{{2
if has('patch-8.2.5136')
  nnoremap <Leader>f <Cmd>Fern . -drawer -toggle -stay<CR>
endif

" https://github.com/lambdalisue/vim-suda {{{2
" Define aliases to use in the same way as sudo.vim
" (https://github.com/vim-scripts/sudo.vim)
command! -nargs=? -complete=file SudoRead   SudaRead <args>
command! -nargs=? -complete=file SudoWrite  SudaWrite <args>

" https://github.com/moll/vim-bbye {{{2
" Define an alias so that you do not have to press the Shift key (':Bclose' can
" be typed by ':bc<Tab>'.)
command! -nargs=? -complete=buffer -bang Bclose Bdelete<bang> <args>

" https://github.com/ntpeters/vim-better-whitespace {{{2
highlight! link ExtraWhitespace Error

" https://github.com/simeji/winresizer {{{2
let g:winresizer_start_key = '<Leader>e'

" https://github.com/tpope/vim-rhubarb {{{2
" Define :Browse for :GBrowse because Netrw will not be loaded
" Use :Open from $VIMRUNTIME/plugin/openPlugin.vim
if has('patch-9.1.1054')
  command! -nargs=1 Browse Open <args>
endif

" vim: fdm=marker:ts=2:tw=78
