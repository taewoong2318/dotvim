" Taewoong's Vim configuration
"
" Author: Taewoong Han <taewoong@taewoong.me>

" ============================================================================

" Quit if there is no support for <Cmd>
if !has('patch-8.2.1978')
  echo 'Error: Version 8.2.1978 or later is required.'
  cquit
endif

" ============================================================================

" Initialize the autocmd group for this vimrc
augroup vimrc
  autocmd!
augroup END

" ============================================================================

set autoindent
set autoread
set completeopt=menuone,noinsert,popup
set completepopup=height:20,width:80,align:menu,border:off
set diffopt+=algorithm:histogram,indent-heuristic,vertical
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
set wildmode=longest:full,full

" NOTE: Give priority to Shift_JIS over CP932
" (See https://qiita.com/ke-suke-Soft/items/978365a9e63ba118fffc)
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
  set diffopt-=inline:simple
  set diffopt+=inline:char
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

" Place state files respecting Neovim's Standard Paths (See
" https://neovim.io/doc/user/starting.html#_standard-paths)

let s:xdg_data_home = ''
let s:xdg_state_home = ''
let s:vim_state_dir = ''

if has('unix')
  let s:xdg_data_home = !empty($XDG_DATA_HOME)
        \ ? $XDG_DATA_HOME : expand('~/.local/share')
  let s:xdg_state_home = !empty($XDG_STATE_HOME)
        \ ? $XDG_STATE_HOME : expand('~/.local/state')
  let s:vim_state_dir = expand(s:xdg_state_home .. '/vim')
elseif has('win32')
  let s:xdg_data_home = expand('~/AppData/Local')
  let s:xdg_state_home = expand('~/AppData/Local')
  let s:vim_state_dir = expand(s:xdg_state_home .. '/vim-data')
endif

if !empty(s:vim_state_dir)
  if !isdirectory(s:vim_state_dir)
    call mkdir(s:vim_state_dir, 'p', 0o700)
  endif

  let &viminfofile = s:vim_state_dir .. '/viminfo'

  let s:swap_dir = s:vim_state_dir .. '/swap'
  if !isdirectory(s:swap_dir)
    call mkdir(s:swap_dir, 'p', 0o700)
  endif

  let &directory = s:swap_dir .. '//'
endif

" ============================================================================

" Do nothing but is used for the recursive mappings below (See
" https://zenn.dev/mattn/articles/83c2d4c7645faa)
nmap <SID>g <Nop>
nmap <SID><C-W> <Nop>

" Do gjgjgj... with gjjj...
nmap gj gj<SID>g
nnoremap <script> <SID>gj gj<SID>g

" Do gkgkgk... with gkkk...
nmap gk gk<SID>g
nnoremap <script> <SID>gk gk<SID>g

" Do <C-W>+<C-W>+<C-W>+... with <C-W>+++...
nmap <C-W>+ <C-W>+<SID><C-W>
nnoremap <script> <SID><C-W>+ <C-W>+<SID><C-W>

" Do <C-W>-<C-W>-<C-W>-... with <C-W>---...
nmap <C-W>- <C-W>-<SID><C-W>
nnoremap <script> <SID><C-W>- <C-W>-<SID><C-W>

" Do <C-W><<C-W><<C-W><... with <C-W><<<...
nmap <C-W>< <C-W><<SID><C-W>
nnoremap <script> <SID><C-W>< <C-W><<SID><C-W>

" Do <C-W>><C-W>><C-W>>... with <C-W>>>>...
nmap <C-W>> <C-W>><SID><C-W>
nnoremap <script> <SID><C-W>> <C-W>><SID><C-W>

" Delete a character without yanking
nnoremap x "_x

" Yank from the cursor to the end of the line
nnoremap Y y$

" Select without surrounding white spaces
xnoremap a" 2i"
xnoremap a' 2i'
xnoremap a` 2i`
onoremap a" 2i"
onoremap a' 2i'
onoremap a` 2i`

" Make a new undo chunk before deleting a lot
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Search on DuckDuckGo
if has('patch-9.1.1669')
  nnoremap gz <Cmd>execute 'URLOpen https://duckduckgo.com/?q='
        \ .. uri_encode(expand('<cword>'))<CR>
  xnoremap gz <Cmd>execute 'URLOpen https://duckduckgo.com/?q='
        \ .. getregion(getpos('v'), getpos('.'), #{ type: mode() })
        \     ->join(' ')
        \     ->uri_encode()<CR>
endif

" Switch buffers quickly
nnoremap <C-N> <Cmd>bnext<CR>
nnoremap <C-P> <Cmd>bprevious<CR>

" Clear search highlighting
nnoremap <C-L> <Cmd>nohlsearch<CR>

" ============================================================================

function! s:DefineCmdShort(short, cmd) abort
  execute printf('cabbrev <expr> %s
        \ (getcmdtype() ==# ":" && getcmdline() ==# "%s")
        \ ? "%s" : "%s"', a:short, a:short, a:cmd, a:short)
endfunction

" Open the directory of the current file
call s:DefineCmdShort('e,', 'edit %:h')

" Change the current directory to the directory of the current file
call s:DefineCmdShort('cd,', 'cd %:h')

" ============================================================================

syntax enable

filetype plugin indent on

" Disable automatic insertion of comment leaders on every file type
autocmd vimrc FileType *
      \   setlocal formatoptions-=r
      \ | setlocal formatoptions-=o

" Load the man filetype plugin for :Man
runtime! ftplugin/man.vim

" ============================================================================

" Set my colorscheme for terminal Vim
if !has('gui_running')
  colorscheme taewoong
endif

" ============================================================================

" Disable unnecessary built-in plugins (in $VIMRUNTIME/plugin)
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

" cfilter

packadd cfilter

" ============================================================================

" comment (built-in) or commentary (third-party)

if has('patch-9.1.375')
  packadd comment
else
  packadd commentary
endif

" ============================================================================

" copilot

if has('patch-9.0.185') && executable('node')
  packadd copilot

  let g:copilot_filetypes = #{
        \   csv: v:false,
        \   json: v:false,
        \   markdown: v:false,
        \   text: v:false,
        \   toml: v:false,
        \   typst: v:false,
        \   yaml: v:false
        \ }

  imap <C-L> <Plug>(copilot-accept-line)
endif

" ============================================================================

" fugitive

" Make :Browse available for :GBrowse even if netrw is disabled
command! -nargs=1 Browse URLOpen <args>

" ============================================================================

" lsp

if v:version >= 900
  packadd lsp

  call g:LspOptionsSet(#{
        \   completionMatcher: 'icase',
        \   diagVirtualTextAlign: 'after',
        \   ignoreMissingServer: v:true,
        \   showDiagWithVirtualText: has('patch-9.0.1157')
        \ })

  autocmd vimrc User LspAttached
        \   setlocal formatexpr=lsp#lsp#FormatExpr()
        \ | setlocal keywordprg=:LspHover
        \ | setlocal tagfunc=lsp#lsp#TagFunc

  function! s:getJdtlsArgs() abort
    let l:lombokPath = !empty(s:xdg_data_home)
          \ ? expand(s:xdg_data_home .. '/jdtls/lombok.jar') : ''
    return !empty(l:lombokPath) && filereadable(l:lombokPath)
          \ ? [ '--jvm-arg=-javaagent:' .. l:lombokPath ] : []
  endfunction

  " Register language servers (See https://github.com/yegappan/lsp/wiki)
  call g:LspAddServer([
        \   #{
        \     name: 'bashls',
        \     filetype: 'sh',
        \     path: 'bash-language-server',
        \     args: [ 'start' ]
        \   },
        \   #{
        \     name: 'clangd',
        \     filetype: [ 'c', 'cpp' ],
        \     path: 'clangd',
        \     args: [ '--background-index', '--clang-tidy' ]
        \   },
        \   #{
        \     name: 'gopls',
        \     filetype: 'go',
        \     path: 'gopls',
        \     args: [ 'serve' ]
        \   },
        \   #{
        \     name: 'jdtls',
        \     filetype: 'java',
        \     path: has('win32') ? 'jdtls.bat' : 'jdtls',
        \     args: s:getJdtlsArgs(),
        \     initializationOptions: #{
        \       settings: #{
        \         java: #{
        \           completion: #{
        \             filteredTypes: [
        \               'com.sun.*', 'java.awt.*', 'jdk.*', 'org.graalvm.*',
        \               'sun.*', 'javax.awt.*', 'javax.swing.*'
        \             ]
        \           },
        \           signatureHelp: #{
        \             enabled: v:true,
        \             description: #{ enabled: v:true }
        \           },
        \           sources: #{
        \             organizeImports: #{
        \               starThreshold: 9999,
        \               staticStarThreshold: 9999
        \             }
        \           }
        \         }
        \       }
        \     }
        \   },
        \   #{
        \     name: 'omnisharp',
        \     filetype: 'cs',
        \     path: 'OmniSharp',
        \     args: [ '-z', '--languageserver', '--encoding', 'utf-8' ]
        \   },
        \   #{
        \     name: 'tinymist',
        \     filetype: 'typst',
        \     path: 'tinymist',
        \     args: [],
        \     initializationOptions: #{
        \       tinymist: #{
        \         preview: #{
        \           background: #{
        \             enabled: v:true
        \           }
        \         }
        \       }
        \     }
        \   },
        \   #{
        \     name: 'tsserver',
        \     filetype: [ 'javascript', 'typescript' ],
        \     path: 'typescript-language-server',
        \     args: [ '--stdio' ]
        \   },
        \   #{
        \     name: 'pylsp',
        \     filetype: 'python',
        \     path: 'pylsp',
        \     args: []
        \   }
        \ ])
endif

" ============================================================================

" sandwich

if !has('patch-8.2.4275')
  " Load manually to make the autoload functions available
  packadd sandwich
endif

" Disable all the highlighting
call operator#sandwich#set('all', 'all', 'highlight', 0)

" ============================================================================

" vim: et:ts=2:tw=78
