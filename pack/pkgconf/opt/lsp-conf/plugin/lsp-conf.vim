function! s:onLspAttached()
    setlocal tagfunc=lsp#lsp#TagFunc
    setlocal formatexpr=lsp#lsp#FormatExpr()

    nnoremap <buffer> gd <cmd>LspGotoDefinition<CR>
    nnoremap <buffer> gD <cmd>LspGotoDeclaration<CR>
    nnoremap <buffer> gr <cmd>LspShowReferences<CR>
    nnoremap <buffer> K <cmd>LspHover<CR>
    nnoremap <buffer> <C-k> <cmd>LspDiag current<CR>
    nnoremap <buffer> <F2> <cmd>LspRename<CR>
    nnoremap <buffer> gA <cmd>LspCodeAction<CR>
endfunction

augroup VimrcLsp
    autocmd!
    autocmd User LspAttached call s:onLspAttached()
augroup END

call LspOptionsSet(#{
            \   autoComplete: v:false,
            \   omniComplete: v:true,
            \   showSignature: v:false
            \   })

call LspAddServer([#{
            \   name: 'clangd',
            \   filetype: ['c', 'cpp'],
            \   path: g:VimHome . '/language-servers/clangd_17.0.3/bin/clangd',
            \   args: ['--background-index']
            \   }])

call LspAddServer([#{
            \   name: 'gopls',
            \   filetype: 'go',
            \   path: $HOME . '/go/bin/gopls',
            \   args: ['serve']
            \   }])
