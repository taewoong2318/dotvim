" Taewoong's Vim configuration
"
" Author: Taewoong Han <taewoong@taewoong.me>

" ============================================================================

" Quit Vim if the version is lower than 9.0
if v:version < 900
  echo 'Error: Version 9.0 or later is required.'
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
set cdhome
set completeopt=fuzzy,menuone,noinsert,popup
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
set signcolumn=no
set smartcase
set spelloptions=camel
set splitbelow
set splitright
set tabstop=4
set title

" NOTE: Try Shift_JIS first then CP932 (superset of Shift_JIS) so that:
" - Shift_JIS files are detected as Shift_JIS
" - CP932 files with extended characters are detected as CP932
" - CP932 files without extended characters are detected as Shift_JIS (no
"   compatibility issue in this case)
set fileencodings=ucs-bom,utf-8,sjis,cp932,default,latin1

" NOTE: Enabled by default since patch 9.1.1761
set ruler

" Mirror the value of 'tabstop'
set shiftwidth=0
set softtabstop=-1

" NOTE: Enabled by default since patch 9.1.1550
set showcmd

" Make <Esc> faster (See https://vi.stackexchange.com/a/24938)
set ttimeout
set ttimeoutlen=100

" Reset to the default in case the system vimrc changed them
set scrolloff&
set viminfo&

" NOTE: Enabled by default since patch 9.1.862
set wildmenu

if has('patch-9.0.640')
  set smoothscroll
endif

if has('patch-9.0.1921')
  set jumpoptions=stack
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

let s:stdpath_data = ''
let s:stdpath_state = ''
let s:stdpath_state_vim = ''

if has('unix')
  let s:stdpath_data = !empty($XDG_DATA_HOME)
        \ ? $XDG_DATA_HOME : expand('~/.local/share')
  let s:stdpath_state = !empty($XDG_STATE_HOME)
        \ ? $XDG_STATE_HOME : expand('~/.local/state')
  let s:stdpath_state_vim = expand(s:stdpath_state .. '/vim')
elseif has('win32')
  let s:stdpath_data = expand('~/AppData/Local')
  let s:stdpath_state = expand('~/AppData/Local')
  let s:stdpath_state_vim = expand(s:stdpath_state .. '/vim-data')
endif

if !empty(s:stdpath_state_vim)
  if !isdirectory(s:stdpath_state_vim)
    call mkdir(s:stdpath_state_vim, 'p', 0o700)
  endif

  let &viminfofile = s:stdpath_state_vim .. '/viminfo'

  let s:swap_dir = s:stdpath_state_vim .. '/swap'
  if !isdirectory(s:swap_dir)
    call mkdir(s:swap_dir, 'p', 0o700)
  endif

  let &directory = s:swap_dir .. '//'
endif

" ============================================================================

let g:mapleader = "\<Space>"

" Act as recursive keymapping units (See
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

" Reselect visual selection after indenting
xnoremap < <gv
xnoremap > >gv

" Navigate buffers quickly
nnoremap <C-N> <Cmd>bnext<CR>
nnoremap <C-P> <Cmd>bprevious<CR>

" Navigate quickfix list quickly
nnoremap <C-J> <Cmd>cnext<CR>
nnoremap <C-K> <Cmd>cprevious<CR>

" ============================================================================

" Enable command-line auto-completion (See |cmdline-autocompletion|)

autocmd vimrc CmdlineChanged : call wildtrigger()

set wildmode=noselect:lastused,full
set wildoptions=fuzzy,pum

" Make :find a fuzzy file picker (See |fuzzy-file-picker|)

let s:files_cache = []

autocmd vimrc CmdlineEnter : let s:files_cache = []

function! Find(arg, _) abort
  if empty(s:files_cache)
    let s:files_cache = globpath('.', '**', 1, 1)
          \ ->filter({ _, v -> !isdirectory(v) })
          \ ->map({ _, v -> fnamemodify(v, ':.') })
  endif
  return a:arg == '' ? s:files_cache : matchfuzzy(s:files_cache, a:arg)
endfunc

set findfunc=Find

" ============================================================================

syntax enable

filetype plugin indent on

" Disable auto-insertion of comment leaders on every file type
autocmd vimrc FileType *
      \   setlocal formatoptions-=r
      \ | setlocal formatoptions-=o

" Load the man filetype plugin to enable :Man
runtime! ftplugin/man.vim

" NOTE: Add the following to .bashrc to use Vim as a manpager:
"
" export MANPAGER="vim +MANPAGER --not-a-term -"

" ============================================================================

" Load colorscheme for terminal Vim
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
endif

" ============================================================================

" fugitive

nnoremap <Leader>l <Cmd>Git log --oneline --graph --decorate<CR>
nnoremap <Leader>d <Cmd>Gdiffsplit<CR>
nnoremap <Leader>b <Cmd>Git blame<CR>

" ============================================================================

" lsp

packadd lsp

call g:LspOptionsSet(#{
      \   completionMatcher: 'fuzzy',
      \   diagVirtualTextAlign: 'after',
      \   ignoreMissingServer: v:true,
      \   showDiagWithVirtualText: has('patch-9.0.1157')
      \ })

function! OnLspAttached() abort
  setlocal formatexpr=lsp#lsp#FormatExpr()
  setlocal keywordprg=:LspHover
  setlocal tagfunc=lsp#lsp#TagFunc

  nnoremap <buffer> gd <Cmd>LspGotoDefinition<CR>
  nnoremap <buffer> gD <Cmd>LspGotoDeclaration<CR>
  nnoremap <buffer> gi <Cmd>LspGotoImpl<CR>
  nnoremap <buffer> gy <Cmd>LspGotoTypeDef<CR>
  nnoremap <buffer> gr <Cmd>LspShowReferences<CR>
  nnoremap <buffer> <Leader>r <Cmd>LspRename<CR>
  nnoremap <buffer> <Leader>c <Cmd>LspCodeAction<CR>
  nnoremap <buffer> <Leader>f <Cmd>LspFormat<CR>
endfunction

autocmd vimrc User LspAttached call OnLspAttached()

function! s:getJdtlsArgs() abort
  " NOTE: The Lombok JAR file is expected to be placed at either of:
  " - ~/.local/share/jdtls/lombok.jar (Unix)
  " - ~/AppData/Local/jdtls/lombok.jar (Windows)
  let l:lombok_path = !empty(s:stdpath_data)
        \ ? expand(s:stdpath_data .. '/jdtls/lombok.jar') : ''
  return !empty(l:lombok_path) && filereadable(l:lombok_path)
        \ ? [ '--jvm-arg=-javaagent:' .. l:lombok_path ] : []
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
      \     args: [
      \       '--background-index', '--clang-tidy',
      \       '--fallback-style=Microsoft'
      \     ]
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
      \             description: #{
      \               enabled: v:true
      \             }
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

" ============================================================================

" molder

" Hop up to the directory listing from any buffer, inspired by vinegar.vim
" (See https://github.com/tpope/vim-vinegar)
nnoremap - <Cmd>edit %:p:h<CR>

" ============================================================================

" vim: et:ts=2:tw=78
