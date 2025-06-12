" Vim configuration with portability in mind, for Linux, macOS, and Windows
"
" Author: Taewoong Han <mail@taewoong.me>

" ---------------------------------------------------------------------------

if v:version < 900
  echo 'Error: Version 9.0 or later is required.'
  cquit
endif

" ---------------------------------------------------------------------------

" Remove all the autocommands in vimrc to avoid multiple registration
augroup vimrc
  autocmd!
augroup END

" ---------------------------------------------------------------------------

set ambiwidth=double
set autoindent
set autoread
set cdhome
set completeopt=menuone,noinsert,popup
set diffopt+=algorithm:histogram,indent-heuristic,vertical
set display=lastline
set encoding=utf-8
set expandtab
set fileencoding=utf-8
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
set shiftwidth=0            " Mirror the value of 'tabstop'
set showcmd
set signcolumn=no
set smartcase
set softtabstop=-1          " Mirror the value of 'tabstop'
set spelloptions=camel
set splitbelow
set tabstop=4
set title
set ttimeout
set ttimeoutlen=100         " See https://vi.stackexchange.com/a/24938
set wildmode=longest,list   " Complete like Bash
set wildoptions=pum

" ---------------------------------------------------------------------------

" Use the keyword completion on Unix
let s:unix_words_file = '/usr/share/dict/words'
if has('unix') && filereadable(s:unix_words_file)
  let &dictionary = s:unix_words_file
endif

" ---------------------------------------------------------------------------

" Store state files as Neovim does
" See https://neovim.io/doc/user/starting.html#_standard-paths
let s:state_dir = ''
if has('unix')
  let s:state_dir = !empty($XDG_STATE_HOME) ?
        \ $XDG_STATE_HOME . '/vim' : expand('~/.local/state/vim')
elseif has('win32')
  let s:state_dir = expand('~/AppData/Local/vim-data')
endif

if !empty(s:state_dir)
  if !isdirectory(s:state_dir)
    call mkdir(s:state_dir, 'p', 0o700)
  endif

  let &viminfofile = s:state_dir . '/viminfo'

  let s:swap_dir = s:state_dir . '/swap'
  if !isdirectory(s:swap_dir)
    call mkdir(s:swap_dir, 'p', 0o700)
  endif

  let &directory = s:swap_dir . '//'
endif

" ---------------------------------------------------------------------------

let g:mapleader = "\<Space>"

" Switch buffers quickly
nnoremap <C-J> <Cmd>bnext<CR>
nnoremap <C-K> <Cmd>bprevious<CR>

" Use CTRL-L to stop highlighting and redraw
nnoremap <C-L> <Cmd>nohlsearch<CR><C-L>

" Yank from the cursor to the end of the line
nnoremap Y y$

" Select without surrounding white spaces
xnoremap a" 2i"
xnoremap a' 2i'
xnoremap a` 2i`
onoremap a" 2i"
onoremap a' 2i'
onoremap a` 2i`

" Start new undoable edit before CTRL-U and CTRL-W
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" ---------------------------------------------------------------------------

" Tweak vimrc quickly
command! -nargs=0 -bar CdHere   cd %:h
command! -nargs=0 -bar Reload   source $MYVIMRC
command! -nargs=0 -bar Vimrc    edit $MYVIMRC

" ---------------------------------------------------------------------------

" Open the QuickFix window automatically
autocmd vimrc QuickFixCmdPost [^l]* copen
autocmd vimrc QuickFixCmdPost l*    lopen

" ---------------------------------------------------------------------------

syntax enable

" Enable the syntax highlighting of fenced code blocks in Markdown
let g:markdown_fenced_languages = [
      \ 'c', 'cpp', 'c++=cpp', 'cs', 'c#=cs', 'css', 'html', 'go',
      \ 'golang=go', 'javascript', 'js=javascript', 'json', 'php', 'python',
      \ 'ruby', 'rb=ruby', 'rust', 'rs=rust', 'sh', 'bash=sh', 'shell=sh',
      \ 'zsh=sh', 'typescript', 'ts=typescript', 'vim', 'viml=vim',
      \ 'vimscript=vim', 'yaml', 'yml=yaml'
      \ ]

" ---------------------------------------------------------------------------

filetype plugin indent on

" Disable the automatic insertion of comment leaders on every file type
" NOTE: Must be placed after 'filetype plugin indent on'
autocmd vimrc FileType *
      \ setlocal formatoptions-=r |
      \ setlocal formatoptions-=o

" Load the man filetype plugin
runtime! ftplugin/man.vim

" ---------------------------------------------------------------------------

" Disable unnecessary built-in plugins (under $VIMRUNTIME/plugin)
let g:loaded_2html_plugin      = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_manpager_plugin   = 1
let g:loaded_matchparen        = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1

" ----------------------------------------------------------------------------

" bbye
command! -nargs=? -complete=buffer -bang Bclose Bdelete<bang> <args>

" ----------------------------------------------------------------------------

" better-whitespace
highlight! link ExtraWhitespace Error

" ----------------------------------------------------------------------------

" cfilter
packadd cfilter

" ----------------------------------------------------------------------------

" comment or commentary
if has('patch-9.1.375')
  packadd comment
else
  packadd commentary
endif

" ----------------------------------------------------------------------------

" editexisting
packadd editexisting

" ----------------------------------------------------------------------------

" lexima
let g:lexima_ctrlh_as_backspace = 1

" Disable the auto closing when the cursor is at the front of a word
call lexima#add_rule({'at': '\%#\w', 'char': "'", 'input': "'"})
call lexima#add_rule({'at': '\%#\w', 'char': '"', 'input': '"'})
call lexima#add_rule({'at': '\%#\w', 'char': '(', 'input': '('})
call lexima#add_rule({'at': '\%#\w', 'char': '[', 'input': '['})
call lexima#add_rule({'at': '\%#\w', 'char': '`', 'input': '`'})
call lexima#add_rule({'at': '\%#\w', 'char': '{', 'input': '{'})

" ----------------------------------------------------------------------------

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
if !empty(s:state_dir)
  let g:netrw_home = s:state_dir
endif

" ----------------------------------------------------------------------------

" suda
" Use the same commands as sudo.vim (https://github.com/vim-scripts/sudo.vim)
command! -nargs=? -complete=file SudoRead   SudaRead <args>
command! -nargs=? -complete=file SudoWrite  SudaWrite <args>

" ----------------------------------------------------------------------------

" traces
let g:traces_abolish_integration = 1

" ----------------------------------------------------------------------------

" winresizer
let g:winresizer_start_key = '<Leader>e'

" ---------------------------------------------------------------------------

" vim: et:ts=2:tw=78
