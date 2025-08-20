set guioptions-=m
set guioptions-=r
set guioptions-=L
set guioptions-=T

if has('win32')
  set guifont=Consolas:h10
  set guifontwide=MS_Gothic:h10
  set renderoptions=type:directx
endif

if has('gui_macvim')
  " Save and switch the input source between normal and insert mode (See
  " gui_mac.txt in MacVim)
  set noimdisable
endif

" vim: et:ts=2:tw=78
