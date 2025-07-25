" Taewoong's Vim configuration
"
" Author: Taewoong Han <mail@taewoong.me>

" ============================================================================

" Quit immediately if there is no support for the <Cmd> mappings
if !has('patch-8.2.1978')
  echo 'Error: Version 8.2.1978 or later is required.'
  cquit
endif

" ============================================================================

" Clear all the autocommands defined in vimrc to avoid duplicate triggers
augroup vimrc
  autocmd!
augroup END

" ============================================================================

set ambiwidth=double
set autoindent
set autoread
set completeopt=menuone,noinsert,popup
set completepopup=height:20,width:80,align:menu,border:off
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
set keywordprg=:Man
set laststatus=0
set nojoinspaces
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
set splitright
set tabstop=4
set title
set wildmenu

" NOTE: We have to give priority to Shift_JIS (sjis) over CP932 (cp932) to
" avoid overwriting the Shift_JIS file with CP932 (See
" https://qiita.com/ke-suke-Soft/items/978365a9e63ba118fffc).
set fileencodings=ucs-bom,utf-8,sjis,cp932,default,latin1

" Mirror the value of 'tabstop'
set shiftwidth=0
set softtabstop=-1

" Make <Esc> faster (See https://vi.stackexchange.com/a/24938)
set ttimeout
set ttimeoutlen=100

if has('patch-8.2.3780')
  set cdhome
endif

if has('patch-8.2.4325')
  set wildoptions=pum
endif

if has('patch-9.0.640')
  set smoothscroll
endif

if has('patch-9.1.537')
  set nrformats+=blank
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

if has('patch-9.1.1283')
  set chistory=100
  set lhistory=100
endif

" ============================================================================

" Enable keyword completion on Unix
let s:unix_words_file = '/usr/share/dict/words'
if has('unix') && filereadable(s:unix_words_file)
  let &dictionary = s:unix_words_file
endif

" ============================================================================

" Respect the XDG Base Directory specification and Neovim's standard paths
" (See https://neovim.io/doc/user/starting.html#_standard-paths)

let s:xdg_data_home = ''
let s:xdg_state_home = ''
let s:vim_state_dir = ''

if has('unix')
  let s:xdg_data_home = !empty($XDG_DATA_HOME)
        \ ? $XDG_DATA_HOME : expand('~/.local/share')
  let s:xdg_state_home = !empty($XDG_STATE_HOME)
        \ ? $XDG_STATE_HOME : expand('~/.local/state')
  let s:vim_state_dir = expand(s:xdg_state_home . '/vim')
elseif has('win32')
  let s:xdg_data_home = expand('~/AppData/Local')
  let s:xdg_state_home = expand('~/AppData/Local')
  let s:vim_state_dir = expand(s:xdg_state_home . '/vim-data')
endif

if !empty(s:vim_state_dir)
  if !isdirectory(s:vim_state_dir)
    call mkdir(s:vim_state_dir, 'p', 0o700)
  endif

  let &viminfofile = s:vim_state_dir . '/viminfo'

  let s:swap_dir = s:vim_state_dir . '/swap'
  if !isdirectory(s:swap_dir)
    call mkdir(s:swap_dir, 'p', 0o700)
  endif

  let &directory = s:swap_dir . '//'
endif

" ============================================================================

let g:mapleader = "\<Space>"

" Clear highlighting simultaneously with redrawing
nnoremap <C-L> <Cmd>nohlsearch<CR><C-L>

" Move upward or downward by display line
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Paste adjusting the indent to the current line
nnoremap p ]p
nnoremap P ]P
nnoremap ]p p
nnoremap ]P P

" Delete a character without yanking
nnoremap x "_x
xnoremap x "_x

" Yank from the cursor to the end of the line
nnoremap Y y$

" Select without surrounding white spaces
xnoremap a" 2i"
xnoremap a' 2i'
xnoremap a` 2i`
onoremap a" 2i"
onoremap a' 2i'
onoremap a` 2i`

" Make a new undo chunk before a lot of deletion
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

nnoremap <Leader>bn <Cmd>bnext<CR>
nnoremap <Leader>bp <Cmd>bprevious<CR>
nnoremap <Leader>e. <Cmd>edit .<CR>
nnoremap <Leader>e, <Cmd>edit %:h<CR>

" ============================================================================

" Open the QuickFix window automatically
autocmd vimrc QuickFixCmdPost [^l]* copen
autocmd vimrc QuickFixCmdPost l*    lopen

" ============================================================================

syntax enable

" Enable the syntax highlighting of fenced code blocks in Markdown
let g:markdown_fenced_languages = [
      \ 'c', 'cpp', 'c++=cpp', 'cs', 'c#=cs', 'css', 'html', 'go',
      \ 'golang=go', 'javascript', 'js=javascript', 'json', 'php', 'python',
      \ 'ruby', 'rb=ruby', 'rust', 'rs=rust', 'sh', 'bash=sh', 'shell=sh',
      \ 'zsh=sh', 'typescript', 'ts=typescript', 'vim', 'viml=vim',
      \ 'vimscript=vim', 'yaml', 'yml=yaml'
      \ ]

" ============================================================================

filetype plugin indent on

" Disable the automatic insertion of comment leaders on every file type
"
" NOTE: This must be placed after `filetype plugin indent on`.
autocmd vimrc FileType *
      \ setlocal formatoptions-=r | setlocal formatoptions-=o

" Load the man filetype plugin to use :Man
runtime! ftplugin/man.vim

" ============================================================================

" Disable unnecessary built-in plugins (under $VIMRUNTIME/plugin)
let g:loaded_2html_plugin      = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1

" ============================================================================

" bbye

nnoremap <Leader>bd <Cmd>Bdelete<CR>

" ============================================================================

" better-whitespace

highlight! link ExtraWhitespace Error

" ============================================================================

" comment (built-in) or commentary (third-party)

if has('patch-9.1.375')
  packadd comment
else
  packadd commentary
endif

" ============================================================================

" dim

colorscheme dim

" ============================================================================

" fugitive

" NOTE: :GBrowse needs :Browse, which would be defined in netrw.
command! -nargs=1 Browse URLOpen <args>

" ============================================================================

" lsp

if v:version >= 900
  packadd lsp

  call g:LspOptionsSet(#{
        \ autoComplete: v:false,
        \ autoHighlightDiags: v:false,
        \ completionMatcher: 'icase',
        \ ignoreMissingServer: v:true,
        \ showSignature: v:false
        \ })

  function! s:onLspAttached()
    setlocal formatexpr=lsp#lsp#FormatExpr()
    setlocal keywordprg=:LspHover
    setlocal tagfunc=lsp#lsp#TagFunc

    nnoremap <buffer> gD <Cmd>LspGotoDeclaration<CR>
    nnoremap <buffer> gd <Cmd>LspGotoDefinition<CR>
    nnoremap <buffer> gi <Cmd>LspGotoImpl<CR>
    nnoremap <buffer> gl <Cmd>LspDiag show<CR>
    nnoremap <buffer> gr <Cmd>LspShowReferences<CR>
    nnoremap <buffer> gy <Cmd>LspGotoTypeDef<CR>
  endfunction

  autocmd vimrc User LspAttached call s:onLspAttached()

  " Register some language servers (See https://github.com/yegappan/lsp/wiki)

  call g:LspAddServer([#{
        \   name: 'clangd',
        \   filetype: [ 'c', 'cpp' ],
        \   path: 'clangd',
        \   args: [ '--background-index', '--clang-tidy' ]
        \ }])

  call g:LspAddServer([#{
        \   name: 'gopls',
        \   filetype: 'go',
        \   path: 'gopls',
        \   args: [ 'serve' ]
        \ }])

  let s:lombok = !empty(s:xdg_data_home)
        \ ? expand(s:xdg_data_home . '/jdtls/lombok.jar') : ''
  let s:jdtlsArgs = !empty(s:lombok) && filereadable(s:lombok)
        \ ? [ '--jvm-arg=-javaagent:' . s:lombok ] : []
  call g:LspAddServer([#{
        \   name: 'jdtls',
        \   filetype: 'java',
        \   path: 'jdtls',
        \   args: s:jdtlsArgs,
        \   initializationOptions: #{
        \     settings: #{
        \       java: #{
        \         completion: #{
        \           filteredTypes: [
        \             "com.sun.*", "java.awt.*", "jdk.*",
        \             "org.graalvm.*", "sun.*", "javax.awt.*",
        \             "javax.swing.*"
        \           ]
        \         }
        \       }
        \     }
        \   }
        \ }])

  call g:LspAddServer([#{
        \   name: 'tsserver',
        \   filetype: [ 'javascript', 'typescript' ],
        \   path: 'typescript-language-server',
        \   args: [ '--stdio' ]
        \ }])

  " NOTE:
  " - In venv, python-lsp-server needs to be installed inside it.
  " - Some other pip packages (e.g. autopep8) are needed for extra
  "   functionalities (See https://github.com/python-lsp/python-lsp-server)
  call g:LspAddServer([#{
        \   name: 'pylsp',
        \   filetype: 'python',
        \   path: 'pylsp',
        \   args: []
        \ }])
endif

" ============================================================================

" sandwich

" Load the plugin manually to call the autoload functions on start-up
if !has('patch-8.2.4275')
  packadd sandwich
endif

call operator#sandwich#set('all', 'all', 'highlight', 0)

" ============================================================================

" suda

" Perform like sudo.vim (https://github.com/vim-scripts/sudo.vim)
command! -nargs=? -complete=file SudoRead  SudaRead  <args>
command! -nargs=? -complete=file SudoWrite SudaWrite <args>

" ============================================================================

" traces

let g:traces_abolish_integration = 1

" ============================================================================

" vim: et:ts=2:tw=78
