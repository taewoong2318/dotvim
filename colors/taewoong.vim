highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'taewoong'

highlight SpecialKey   ctermfg=4    ctermbg=NONE cterm=NONE
highlight NonText      ctermfg=12   ctermbg=NONE cterm=NONE
highlight Directory    ctermfg=4    ctermbg=NONE cterm=NONE
highlight ErrorMsg     ctermfg=15   ctermbg=1    cterm=NONE
highlight IncSearch    ctermfg=NONE ctermbg=NONE cterm=reverse
highlight MoreMsg      ctermfg=2    ctermbg=NONE cterm=NONE
highlight ModeMsg      ctermfg=NONE ctermbg=NONE cterm=bold
highlight Question     ctermfg=2    ctermbg=NONE cterm=NONE
highlight VertSplit    ctermfg=8    ctermbg=NONE cterm=NONE
highlight Title        ctermfg=5    ctermbg=NONE cterm=NONE
highlight Visual       ctermfg=0    ctermbg=7    cterm=NONE
highlight WarningMsg   ctermfg=1    ctermbg=NONE cterm=NONE
highlight WildMenu     ctermfg=0    ctermbg=11   cterm=NONE
highlight DiffAdd      ctermfg=0    ctermbg=2    cterm=NONE
highlight DiffChange   ctermfg=0    ctermbg=3    cterm=NONE
highlight DiffDelete   ctermfg=0    ctermbg=1    cterm=NONE
highlight DiffText     ctermfg=0    ctermbg=11   cterm=bold
highlight SignColumn   ctermfg=NONE ctermbg=NONE cterm=NONE
highlight Conceal      ctermfg=7    ctermbg=7    cterm=NONE
highlight SpellBad     ctermfg=NONE ctermbg=9    cterm=NONE
highlight SpellRare    ctermfg=NONE ctermbg=13   cterm=NONE
highlight SpellLocal   ctermfg=NONE ctermbg=14   cterm=NONE
highlight PmenuSbar    ctermfg=NONE ctermbg=8    cterm=NONE
highlight PmenuThumb   ctermfg=NONE ctermbg=0    cterm=NONE
highlight TabLine      ctermfg=0    ctermbg=7    cterm=underline
highlight TabLineSel   ctermfg=NONE ctermbg=NONE cterm=bold
highlight TabLineFill  ctermfg=NONE ctermbg=NONE cterm=reverse
highlight CursorColumn ctermfg=NONE ctermbg=7    cterm=NONE
highlight CursorLine   ctermfg=NONE ctermbg=NONE cterm=underline
highlight MatchParen   ctermfg=NONE ctermbg=14   cterm=NONE
highlight Constant     ctermfg=1    ctermbg=NONE cterm=NONE
highlight Special      ctermfg=5    ctermbg=NONE cterm=NONE
highlight Identifier   ctermfg=6    ctermbg=NONE cterm=NONE
highlight Statement    ctermfg=3    ctermbg=NONE cterm=NONE
highlight PreProc      ctermfg=5    ctermbg=NONE cterm=NONE
highlight Type         ctermfg=2    ctermbg=NONE cterm=NONE
highlight Underlined   ctermfg=5    ctermbg=NONE cterm=underline
highlight Ignore       ctermfg=15   ctermbg=NONE cterm=NONE
highlight Error        ctermfg=15   ctermbg=9    cterm=NONE
highlight Todo         ctermfg=0    ctermbg=11   cterm=NONE

if &background ==# 'dark'
  highlight LineNr        ctermfg=8    ctermbg=NONE cterm=NONE
  highlight CursorLineNr  ctermfg=7    ctermbg=NONE cterm=NONE
  highlight StatusLine    ctermfg=15   ctermbg=8    cterm=bold
  highlight StatusLineNC  ctermfg=7    ctermbg=8    cterm=NONE
  highlight Folded        ctermfg=7    ctermbg=8    cterm=NONE
  highlight FoldColumn    ctermfg=7    ctermbg=8    cterm=NONE
  highlight SpellCap      ctermfg=7    ctermbg=8    cterm=NONE
  highlight Pmenu         ctermfg=15   ctermbg=8    cterm=NONE
  highlight PmenuSel      ctermfg=8    ctermbg=15   cterm=NONE
  highlight PmenuMatch    ctermfg=15   ctermbg=8    cterm=bold
  highlight PmenuMatchSel ctermfg=8    ctermbg=15   cterm=bold
  highlight ColorColumn   ctermfg=7    ctermbg=8    cterm=NONE
  highlight Comment       ctermfg=8    ctermbg=NONE cterm=NONE
else
  highlight LineNr        ctermfg=7    ctermbg=NONE cterm=NONE
  highlight CursorLineNr  ctermfg=8    ctermbg=NONE cterm=NONE
  highlight StatusLine    ctermfg=0    ctermbg=7    cterm=bold
  highlight StatusLineNC  ctermfg=8    ctermbg=7    cterm=NONE
  highlight Folded        ctermfg=8    ctermbg=7    cterm=NONE
  highlight FoldColumn    ctermfg=8    ctermbg=7    cterm=NONE
  highlight SpellCap      ctermfg=8    ctermbg=7    cterm=NONE
  highlight Pmenu         ctermfg=0    ctermbg=7    cterm=NONE
  highlight PmenuSel      ctermfg=7    ctermbg=0    cterm=NONE
  highlight PmenuMatch    ctermfg=0    ctermbg=7    cterm=bold
  highlight PmenuMatchSel ctermfg=7    ctermbg=0    cterm=bold
  highlight ColorColumn   ctermfg=8    ctermbg=7    cterm=NONE
  highlight Comment       ctermfg=7    ctermbg=NONE cterm=NONE
endif
