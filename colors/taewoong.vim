hi clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'taewoong'

if &background ==# 'dark'
  hi ColorColumn       ctermfg=NONE ctermbg=1    cterm=NONE
  hi Conceal           ctermfg=7    ctermbg=8    cterm=NONE
  hi CursorColumn      ctermfg=NONE ctermbg=8    cterm=NONE
  hi CursorLine        ctermfg=NONE ctermbg=NONE cterm=underline
  hi Directory         ctermfg=4    ctermbg=NONE cterm=NONE
  hi DiffAdd           ctermfg=NONE ctermbg=2    cterm=NONE
  hi DiffChange        ctermfg=NONE ctermbg=3    cterm=NONE
  hi DiffDelete        ctermfg=NONE ctermbg=1    cterm=NONE
  hi DiffText          ctermfg=NONE ctermbg=11   cterm=bold
  hi ErrorMsg          ctermfg=15   ctermbg=1    cterm=NONE
  hi VertSplit         ctermfg=8    ctermbg=NONE cterm=NONE
  hi Folded            ctermfg=7    ctermbg=8    cterm=NONE
  hi FoldColumn        ctermfg=NONE ctermbg=7    cterm=NONE
  hi SignColumn        ctermfg=NONE ctermbg=7    cterm=NONE
  hi IncSearch         ctermfg=NONE ctermbg=NONE cterm=reverse
  hi LineNr            ctermfg=7    ctermbg=NONE cterm=NONE
  hi CursorLineNr      ctermfg=7    ctermbg=NONE cterm=underline
  hi CursorLineFold    ctermfg=NONE ctermbg=7    cterm=NONE
  hi CursorLineSign    ctermfg=NONE ctermbg=7    cterm=NONE
  hi MatchParen        ctermfg=NONE ctermbg=8    cterm=NONE
  hi ModeMsg           ctermfg=NONE ctermbg=NONE cterm=bold
  hi MoreMsg           ctermfg=10   ctermbg=NONE cterm=NONE
  hi NonText           ctermfg=8    ctermbg=NONE cterm=NONE
  hi Pmenu             ctermfg=0    ctermbg=7    cterm=NONE
  hi PmenuSel          ctermfg=7    ctermbg=8    cterm=NONE
  hi PmenuSbar         ctermfg=NONE ctermbg=7    cterm=NONE
  hi PmenuThumb        ctermfg=NONE ctermbg=15   cterm=NONE
  hi Question          ctermfg=10   ctermbg=NONE cterm=NONE
  hi Search            ctermfg=0    ctermbg=11   cterm=NONE
  hi SpecialKey        ctermfg=14   ctermbg=NONE cterm=NONE
  hi SpellBad          ctermfg=NONE ctermbg=9    cterm=NONE
  hi SpellCap          ctermfg=NONE ctermbg=12   cterm=NONE
  hi SpellLocal        ctermfg=NONE ctermbg=14   cterm=NONE
  hi SpellRare         ctermfg=NONE ctermbg=13   cterm=NONE
  hi StatusLine        ctermfg=0    ctermbg=7    cterm=bold
  hi StatusLineNC      ctermfg=8    ctermbg=7    cterm=NONE
  hi StatusLineTerm    ctermfg=0    ctermbg=7    cterm=bold
  hi StatusLineTermNC  ctermfg=8    ctermbg=7    cterm=NONE
  hi Title             ctermfg=5    ctermbg=NONE cterm=NONE
  hi Visual            ctermfg=NONE ctermbg=8    cterm=NONE
  hi WarningMsg        ctermfg=1    ctermbg=NONE cterm=NONE
  hi WildMenu          ctermfg=0    ctermbg=11   cterm=NONE

  hi Comment           ctermfg=7    ctermbg=NONE cterm=NONE
  hi Constant          ctermfg=11   ctermbg=NONE cterm=NONE
  hi Special           ctermfg=5    ctermbg=NONE cterm=NONE
  hi Identifier        ctermfg=10   ctermbg=NONE cterm=NONE
  hi Statement         ctermfg=13   ctermbg=NONE cterm=NONE
  hi PreProc           ctermfg=14   ctermbg=NONE cterm=NONE
  hi Type              ctermfg=10   ctermbg=NONE cterm=NONE
  hi Underlined        ctermfg=NONE ctermbg=NONE cterm=underline
  hi Ignore            ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Added             ctermfg=10   ctermbg=NONE cterm=NONE
  hi Changed           ctermfg=11   ctermbg=NONE cterm=NONE
  hi Removed           ctermfg=9    ctermbg=NONE cterm=NONE
  hi Error             ctermfg=15   ctermbg=9    cterm=NONE
  hi Todo              ctermfg=0    ctermbg=11   cterm=bold
  hi Bold              ctermfg=NONE ctermbg=NONE cterm=bold
  hi Italic            ctermfg=NONE ctermbg=NONE cterm=italic
  hi BoldItalic        ctermfg=NONE ctermbg=NONE cterm=bold,italic

  hi CopilotSuggestion ctermfg=8    ctermbg=NONE cterm=italic
  hi ExtraWhitespace   ctermfg=NONE ctermbg=9    cterm=NONE
endif
