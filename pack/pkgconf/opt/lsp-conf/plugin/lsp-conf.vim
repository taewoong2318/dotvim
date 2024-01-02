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
            \   completionMatcher: 'fuzzy',
            \   omniComplete: v:true,
            \   semanticHighlight: v:true,
            \   showSignature: v:false
            \   })

call LspAddServer([#{
            \   name: 'clangd',
            \   filetype: ['c', 'cpp'],
            \   path: '/usr/bin/clangd',
            \   args: ['--background-index']
            \   }])

call LspAddServer([#{
            \   name: 'gopls',
            \   filetype: 'go',
            \   path: $HOME . '/go/bin/gopls',
            \   args: ['serve']
            \   }])

call LspAddServer([#{
            \   name: 'jdtls',
            \   filetype: 'java',
            \   path: '/usr/local/jdtls/bin/jdtls',
            \   args: ['--jvm-arg=-javaagent:/usr/local/jdtls/lombok.jar', '--jvm-arg=-Xbootclasspath/a:/usr/local/jdtls/lombok.jar'],
			\   initializationOptions: #{
			\   	settings: #{
            \           java: #{
			\               completion: #{
			\                   filteredTypes: ["com.sun.*", "java.awt.*", "jdk.*", "org.graalvm.*", "sun.*", "javax.awt.*", "javax.swing.*"],
			\               },
			\           },
			\       },
			\   },
			\	}])
