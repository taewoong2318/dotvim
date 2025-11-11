hi clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'taewoong'

if &background ==# 'dark'
  " Use only the following ANSI 4-bit colors:
  "
  " Black(0), DarkRed(1), DarkGreen(2), DarkYellow(3), DarkBlue(4),
  " DarkMagenta(5), DarkCyan(6), DarkGray(8), White(15)

  hi ColorColumn       ctermfg=NONE ctermbg=1    cterm=NONE
  hi Conceal           ctermfg=15   ctermbg=8    cterm=NONE
  hi CursorColumn      ctermfg=NONE ctermbg=8    cterm=NONE
  hi CursorLine        ctermfg=NONE ctermbg=NONE cterm=underline
  hi Directory         ctermfg=4    ctermbg=NONE cterm=NONE
  hi DiffAdd           ctermfg=15   ctermbg=2    cterm=NONE
  hi DiffChange        ctermfg=15   ctermbg=3    cterm=NONE
  hi DiffDelete        ctermfg=15   ctermbg=1    cterm=NONE
  hi DiffText          ctermfg=15   ctermbg=6    cterm=NONE
  hi ErrorMsg          ctermfg=15   ctermbg=1    cterm=NONE
  hi VertSplit         ctermfg=8    ctermbg=NONE cterm=NONE
  hi Folded            ctermfg=15   ctermbg=8    cterm=NONE
  hi FoldColumn        ctermfg=8    ctermbg=NONE cterm=NONE
  hi SignColumn        ctermfg=8    ctermbg=NONE cterm=NONE
  hi IncSearch         ctermfg=15   ctermbg=6    cterm=NONE
  hi LineNr            ctermfg=8    ctermbg=NONE cterm=NONE
  hi CursorLineNr      ctermfg=15   ctermbg=NONE cterm=NONE
  hi CursorLineFold    ctermfg=8    ctermbg=NONE cterm=NONE
  hi CursorLineSign    ctermfg=8    ctermbg=NONE cterm=NONE
  hi MatchParen        ctermfg=NONE ctermbg=8    cterm=NONE
  hi ModeMsg           ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg           ctermfg=2    ctermbg=NONE cterm=NONE
  hi NonText           ctermfg=8    ctermbg=NONE cterm=NONE
  hi Pmenu             ctermfg=15   ctermbg=8    cterm=NONE
  hi PmenuSel          ctermfg=0    ctermbg=15   cterm=NONE
  hi PmenuSbar         ctermfg=NONE ctermbg=8    cterm=NONE
  hi PmenuThumb        ctermfg=NONE ctermbg=15   cterm=NONE
  hi Question          ctermfg=2    ctermbg=NONE cterm=NONE
  hi Search            ctermfg=15   ctermbg=3    cterm=NONE
  hi SpecialKey        ctermfg=6    ctermbg=NONE cterm=NONE
  hi SpellBad          ctermfg=NONE ctermbg=1    cterm=NONE
  hi SpellCap          ctermfg=NONE ctermbg=4    cterm=NONE
  hi SpellLocal        ctermfg=NONE ctermbg=6    cterm=NONE
  hi SpellRare         ctermfg=NONE ctermbg=5    cterm=NONE
  hi StatusLine        ctermfg=15   ctermbg=8    cterm=bold
  hi StatusLineNC      ctermfg=15   ctermbg=8    cterm=NONE
  hi StatusLineTerm    ctermfg=15   ctermbg=8    cterm=bold
  hi StatusLineTermNC  ctermfg=15   ctermbg=8    cterm=NONE
  hi Title             ctermfg=5    ctermbg=NONE cterm=NONE
  hi Visual            ctermfg=15   ctermbg=8    cterm=NONE
  hi WarningMsg        ctermfg=1    ctermbg=NONE cterm=NONE
  hi WildMenu          ctermfg=15   ctermbg=3    cterm=NONE

  hi Comment           ctermfg=8    ctermbg=NONE cterm=NONE
  hi Constant          ctermfg=3    ctermbg=NONE cterm=NONE
  hi Special           ctermfg=5    ctermbg=NONE cterm=NONE
  hi Identifier        ctermfg=2    ctermbg=NONE cterm=NONE
  hi Statement         ctermfg=5    ctermbg=NONE cterm=NONE
  hi PreProc           ctermfg=6    ctermbg=NONE cterm=NONE
  hi Type              ctermfg=4    ctermbg=NONE cterm=NONE
  hi Underlined        ctermfg=NONE ctermbg=NONE cterm=underline
  hi Ignore            ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Added             ctermfg=2    ctermbg=NONE cterm=NONE
  hi Changed           ctermfg=3    ctermbg=NONE cterm=NONE
  hi Removed           ctermfg=1    ctermbg=NONE cterm=NONE
  hi Error             ctermfg=15   ctermbg=1    cterm=NONE
  hi Todo              ctermfg=15   ctermbg=3    cterm=bold
  hi Bold              ctermfg=NONE ctermbg=NONE cterm=bold
  hi Italic            ctermfg=NONE ctermbg=NONE cterm=italic
  hi BoldItalic        ctermfg=NONE ctermbg=NONE cterm=bold,italic

  hi CopilotSuggestion ctermfg=8    ctermbg=NONE cterm=italic
  hi ExtraWhitespace   ctermfg=NONE ctermbg=1    cterm=NONE
endif

" vim: et:ts=2:tw=78
