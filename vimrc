" Vim configuration with portability in mind, for Linux, macOS, and Windows
"
" Author: Taewoong Han <mail@taewoong.me>

" ----------------------------------------------------------------------------

" Restrict version for the <Cmd> mappings
if !has('patch-8.2.1978')
  echo 'Error: Version 8.2.1978 or later is required.'
  cquit
endif

" ----------------------------------------------------------------------------

" Reset the autocommands defined in vimrc to avoid duplicate triggers
augroup vimrc
  autocmd!
augroup END

" ----------------------------------------------------------------------------

set ambiwidth=double
set autoindent
set autoread
set completeopt=menuone,noinsert
set display=lastline
set encoding=utf-8
set expandtab
set formatoptions+=j
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
set pumwidth=40
set ruler
set showcmd
set signcolumn=no
set smartcase
set spelloptions=camel
set splitbelow
set tabstop=4
set title

" NOTE: Give priority to Shift_JIS (sjis) over CP932 (cp932) to avoid saving
" the Shift_JIS file in CP932
" (See https://qiita.com/ke-suke-Soft/items/978365a9e63ba118fffc)
set fileencodings=ucs-bom,utf-8,sjis,cp932,default,latin1

" Mirror the value of 'tabstop'
set shiftwidth=0
set softtabstop=-1

" Make <ESC> faster (See https://vi.stackexchange.com/a/24938)
set ttimeout
set ttimeoutlen=100

" Perform Bash-like completion
set wildmode=longest,list

if has('patch-8.2.3780')
  set cdhome
endif

if has('patch-9.1.1243')
  set diffopt=algorithm:histogram,closeoff,filler,indent-heuristic,
        \inline:word,internal,vertical
else
  set diffopt=algorithm:histogram,closeoff,filler,indent-heuristic,internal,
        \vertical
endif

if has('patch-9.1.1250')
  set pummaxwidth=40
endif

" ----------------------------------------------------------------------------

" Use the keyword completion on Unix
let s:unix_words_file = '/usr/share/dict/words'
if has('unix') && filereadable(s:unix_words_file)
  let &dictionary = s:unix_words_file
endif

" ----------------------------------------------------------------------------

" Store state files respecting the XDG Base Directory specification, just like
" Neovim (See https://neovim.io/doc/user/starting.html#_standard-paths)
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

" ----------------------------------------------------------------------------

let g:mapleader = "\<Space>"

" Switch buffers quickly
nnoremap <C-J> <Cmd>bnext<CR>
nnoremap <C-K> <Cmd>bprevious<CR>

" Clear highlighting and redraw
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

" Make a new undo chunk before CTRL-U and CTRL-W
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" ----------------------------------------------------------------------------

" Open the QuickFix window automatically
autocmd vimrc QuickFixCmdPost [^l]* copen
autocmd vimrc QuickFixCmdPost l*    lopen

" ----------------------------------------------------------------------------

syntax enable

" Enable the syntax highlighting of fenced code blocks in Markdown
let g:markdown_fenced_languages = [
      \ 'c', 'cpp', 'c++=cpp', 'cs', 'c#=cs', 'css', 'html', 'go',
      \ 'golang=go', 'javascript', 'js=javascript', 'json', 'php', 'python',
      \ 'ruby', 'rb=ruby', 'rust', 'rs=rust', 'sh', 'bash=sh', 'shell=sh',
      \ 'zsh=sh', 'typescript', 'ts=typescript', 'vim', 'viml=vim',
      \ 'vimscript=vim', 'yaml', 'yml=yaml'
      \ ]

" ----------------------------------------------------------------------------

filetype plugin indent on

" Disable the automatic insertion of comment leaders on every file type
" NOTE: Must be placed after `filetype plugin indent on`
autocmd vimrc FileType *
      \ setlocal formatoptions-=r |
      \ setlocal formatoptions-=o

" Load the man filetype plugin to use :Man
runtime! ftplugin/man.vim

" ----------------------------------------------------------------------------

" Disable unnecessary built-in plugins (under $VIMRUNTIME/plugin)
let g:loaded_2html_plugin      = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_manpager_plugin   = 1
let g:loaded_matchparen        = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
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

" Load the plugin manually to call the autoload functions on start-up
if !has('patch-8.2.4275')
  packadd lexima
endif

" Disable the auto closing when the cursor is at the front of a word
call lexima#add_rule({'at': '\%#\w', 'char': "'", 'input': "'"})
call lexima#add_rule({'at': '\%#\w', 'char': '"', 'input': '"'})
call lexima#add_rule({'at': '\%#\w', 'char': '(', 'input': '('})
call lexima#add_rule({'at': '\%#\w', 'char': '[', 'input': '['})
call lexima#add_rule({'at': '\%#\w', 'char': '`', 'input': '`'})
call lexima#add_rule({'at': '\%#\w', 'char': '{', 'input': '{'})

" ----------------------------------------------------------------------------

" suda
" Perform like sudo.vim (https://github.com/vim-scripts/sudo.vim)
command! -nargs=? -complete=file SudoRead   SudaRead <args>
command! -nargs=? -complete=file SudoWrite  SudaWrite <args>

" ----------------------------------------------------------------------------

" traces
let g:traces_abolish_integration = 1

" ----------------------------------------------------------------------------

" winresizer
let g:winresizer_start_key = '<Leader>e'

" ----------------------------------------------------------------------------

" vim: et:ts=2:tw=78
