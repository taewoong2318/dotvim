" Vim configuration with portability in mind, for Linux, macOS, and Windows
"
" Author: Taewoong Han <mail@taewoong.me>

if v:version < 900
  echo 'Error: Version 9.0 or later is required.'
  cquit
endif

" Remove all the autocommands in vimrc to avoid multiple registration
augroup vimrc
  autocmd!
augroup END

" Options {{{1
set ambiwidth=double
set autoindent
set autoread
set cdhome
set completeopt=menuone,noinsert
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
set shiftwidth=0    " Use the value of 'tabstop'
set showcmd
set signcolumn=no
set smartcase
set softtabstop=-1  " Use the value of 'tabstop'
set spelloptions=camel
set splitbelow
set tabstop=4
set title
set ttimeout
set ttimeoutlen=100       " See https://vi.stackexchange.com/a/24938
set virtualedit=block
set wildmode=longest,list " Complete like Bash
set wildoptions=pum

" Use keyword completion on Unix
let s:unix_words_file = '/usr/share/dict/words'
if has('unix') && filereadable(s:unix_words_file)
  let &dictionary = s:unix_words_file
endif

" Store state files following the XDG Base Directory specification, like
" Neovim (see https://neovim.io/doc/user/starting.html#_standard-paths)
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

" Commands {{{1
" Define some shortcuts
command! -nargs=0 -bar CdHere   cd %:h
command! -nargs=0 -bar Reload   source $MYVIMRC
command! -nargs=0 -bar Vimrc    edit $MYVIMRC

" Mappings {{{1
let g:mapleader = "\<Space>"

" Switch buffers quickly
nnoremap <C-J> <Cmd>bnext<CR>
nnoremap <C-K> <Cmd>bprevious<CR>

" Use CTRL-L to stop highlighting and redraw
nnoremap <C-L> <Cmd>nohlsearch<CR><C-L>

" Start new undoable edit before CTRL-U
inoremap <C-U> <C-G>u<C-U>

" Yank from the cursor to the end of the line
inoremap Y y$

" Automations {{{1
autocmd vimrc QuickFixCmdPost [^l]* copen
autocmd vimrc QuickFixCmdPost l*    lopen

" Syntax {{{1
syntax enable

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

" Filetype {{{1
filetype plugin indent on

" Disable the automatic insertion of a comment leader on every file type
autocmd vimrc FileType *
      \ setlocal formatoptions-=r |
      \ setlocal formatoptions-=o

" Load the man filetype plugin
runtime! ftplugin/man.vim

" Plugin {{{1
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

" Packages {{{1
" bbye {{{2
" Define an alias so that you do not have to press the Shift key (':Bclose' can
" be typed by ':bc<Tab>'.)
command! -nargs=? -complete=buffer -bang Bclose Bdelete<bang> <args>

" better-whitespace {{{2
highlight! link ExtraWhitespace Error

" cfilter {{{2
packadd cfilter

" comment or commentary {{{2
if has('patch-9.1.375')
  packadd comment
else
  packadd commentary
endif

" editexisting {{{2
packadd editexisting

" fern {{{2
nnoremap <Leader>f <Cmd>Fern . -drawer -toggle -stay<CR>

" fugitive {{{2
" Define :Browse for :GBrowse because Netrw will not be loaded
" Use :Open from $VIMRUNTIME/plugin/openPlugin.vim if exists
if has('patch-9.1.1054')
  command! -nargs=1 Browse Open <args>
endif

" helptoc {{{2
if has('patch-9.1.831')
  packadd helptoc

  nnoremap <Leader>h <Cmd>HelpToc<CR>
endif

" lexima {{{2
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

" suda {{{2
" Define aliases to use in the same way as sudo.vim
" (https://github.com/vim-scripts/sudo.vim)
command! -nargs=? -complete=file SudoRead   SudaRead <args>
command! -nargs=? -complete=file SudoWrite  SudaWrite <args>

" winresizer {{{2
let g:winresizer_start_key = '<Leader>e'

" vim: fdm=marker:et:ts=2:tw=78
