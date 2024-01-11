" Configure general options {{{1
set encoding=utf-8
scriptencoding utf-8
set fileencodings+=cp932,enc-jp

if &compatible
    set nocompatible
endif

set ambiwidth=double
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set completeopt=menu,menuone
set cursorline
set diffopt+=vertical,algorithm:histogram,indent-heuristic
set directory=/tmp
set display=lastline
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=0
set modeline
set nonumber
set noshowcmd
set omnifunc=syntaxcomplete#Complete
set pumheight=10
set ruler
set shell=/bin/bash
set shiftwidth=4
set signcolumn=no
set smartcase
set softtabstop=4
set splitbelow
set tabstop=4
set title
set viminfofile=NONE
set wildmode=longest,list

if has('termguicolors')
    set termguicolors
endif

syntax enable

filetype plugin indent on

augroup VimrcFileTypeIndent
    autocmd!
    autocmd FileType c setlocal sts=4 sw=4 ts=4
    autocmd FileType json setlocal sts=2 sw=2 ts=2
    autocmd FileType sshconfig setlocal sts=2 sw=2 ts=2
    autocmd FileType yaml setlocal sts=2 sw=2 ts=2
augroup END

augroup VimrcFormatOptions
    autocmd!
    autocmd FileType * setlocal formatoptions-=ro indentkeys-=0#
augroup END

let g:loaded_2html_plugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_netrw = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

" Define utils {{{1
command! CdHere :cd %:h
command! Reload :source $MYVIMRC
command! Vimrc :edit $MYVIMRC

" Configure plugins {{{1
call plug#begin()

Plug 'andymass/vim-matchup'
Plug 'cohama/lexima.vim'
Plug 'easymotion/vim-easymotion'
Plug 'github/copilot.vim'
Plug 'godlygeek/tabular'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-smartword'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/vim-protocol'
Plug 'machakann/vim-sandwich'
Plug 'moll/vim-bbye'
Plug 'nordtheme/vim'
Plug 'rhysd/clever-f.vim'
Plug 'simeji/winresizer'
Plug 'svermeulen/vim-subversive'
Plug 'thinca/vim-qfreplace'
Plug 'thinca/vim-quickrun'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'yegappan/lsp'

call plug#end()

" github/copilot.vim {{{2
imap <C-l> <Plug>(copilot-accept-word)

" hrsh7th/vim-vsnip {{{2
imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

" junegunn/fzf.vim {{{2
nnoremap <C-p> <Cmd>Buffers<CR>

" kana/vim-smartword {{{2
map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
map ge <Plug>(smartword-ge)

" lambdalisue/fern.vim {{{2
nnoremap <Leader>f <Cmd>Fern . -drawer -toggle -stay<CR>

" nordtheme/vim {{{2
colorscheme nord

" simeji/winresizer {{{2
let g:winresizer_start_key = '<Leader>e'

" svermeulen/vim-subversive {{{2
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" thinca/vim-quickrun {{{2
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
            \   'outputter': 'error',
            \   'outputter/error/success': 'buffer',
            \   'outputter/error/error': 'quickfix',
            \   'outputter/buffer/opener': 'new',
            \   'outputter/buffer/close_on_empty': 1,
            \   }
let g:quickrun_config.python = {'command': 'python3'}

nnoremap <Leader>r <Cmd>QuickRun<CR>

" yegappan/lsp {{{2
function! s:onLspAttached()
    setlocal tagfunc=lsp#lsp#TagFunc
    setlocal formatexpr=lsp#lsp#FormatExpr()

    nnoremap <buffer> gd <Cmd>LspGotoDefinition<CR>
    nnoremap <buffer> gD <Cmd>LspGotoDeclaration<CR>
    nnoremap <buffer> gr <Cmd>LspShowReferences<CR>
    nnoremap <buffer> K <Cmd>LspHover<CR>
    nnoremap <buffer> <C-k> <Cmd>LspDiag current<CR>
    nnoremap <buffer> gR <Cmd>LspRename<CR>
    nnoremap <buffer> gA <Cmd>LspCodeAction<CR>
    nnoremap <buffer> gG <Cmd>LspDiagShow<CR>
endfunction

let s:lspOptions = #{
            \   autoComplete: v:false,
            \   completionMatcher: 'fuzzy',
            \   omniComplete: v:true,
            \   semanticHighlight: v:true,
            \   showSignature: v:false,
            \   snippetSupport: v:true,
            \   vsnipSupport: v:true,
            \   }

let s:lspServers = [
            \   #{
            \       name: 'clangd',
            \       filetype: ['c', 'cpp'],
            \       path: '/usr/bin/clangd',
            \       args: ['--background-index']
            \   },
            \   #{
            \       name: 'gopls',
            \       filetype: 'go',
            \       path: $HOME . '/go/bin/gopls',
            \       args: ['serve']
            \   },
            \   #{
            \       name: 'jdtls',
            \       filetype: 'java',
            \       path: '/usr/local/jdtls/bin/jdtls',
            \       args: ['--jvm-arg=-javaagent:/usr/local/jdtls/lombok.jar', '--jvm-arg=-Xbootclasspath/a:/usr/local/jdtls/lombok.jar'],
			\       initializationOptions: #{
			\   	    settings: #{
            \               java: #{
			\                   completion: #{
			\                       filteredTypes: ["com.sun.*", "java.awt.*", "jdk.*", "org.graalvm.*", "sun.*", "javax.awt.*", "javax.swing.*"],
			\                   },
			\               },
			\           },
			\       },
			\	}
            \   ]

augroup VimrcLsp
    autocmd!
    autocmd User LspAttached call s:onLspAttached()
    autocmd VimEnter * call LspOptionsSet(s:lspOptions)
    autocmd VimEnter * call LspAddServer(s:lspServers)
augroup END

" vim:fdm=marker
