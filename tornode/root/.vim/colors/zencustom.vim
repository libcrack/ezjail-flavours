" zenburn custom

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="zencustom"

hi Boolean         ctermfg=181
hi Character       ctermfg=181                   cterm=bold
hi Comment         ctermfg=108
hi Conditional     ctermfg=223                   cterm=bold
hi Constant        ctermfg=149                   cterm=bold
hi Cursor          ctermfg=233   ctermbg=109     cterm=bold
hi Debug           ctermfg=181                   cterm=bold
hi Define          ctermfg=223                   cterm=bold
hi Delimiter       ctermfg=245
hi DiffAdd         ctermfg=66    ctermbg=237     cterm=bold
hi DiffChange      ctermbg=236
hi DiffDelete      ctermfg=236   ctermbg=238
hi DiffText        ctermfg=217   ctermbg=237     cterm=bold
hi Directory       ctermfg=188                   cterm=bold
hi ErrorMsg        ctermfg=9     ctermbg=none    cterm=bold
hi Exception       ctermfg=249                   cterm=bold
hi Float           ctermfg=251
hi FoldColumn      ctermfg=109   ctermbg=238
hi Folded          ctermfg=109   ctermbg=234
hi Function        ctermfg=228
hi Identifier      ctermfg=230
hi IncSearch       ctermfg=215   ctermbg=234
hi Keyword         ctermfg=222                  cterm=bold
hi Label           ctermfg=187                  cterm=underline
hi LineNr          ctermfg=238
hi Macro           ctermfg=196                  cterm=bold
hi ModeMsg         ctermfg=230
hi MoreMsg         ctermfg=15                   cterm=bold
hi Normal          ctermfg=188   ctermbg=none
hi Number          ctermfg=157
hi Operator        ctermfg=230
hi PreCondit       ctermfg=180                  cterm=bold
hi PreProc         ctermfg=222                  cterm=bold
hi Question        ctermfg=15                   cterm=bold
hi Repeat          ctermfg=223                  cterm=bold
hi Search          ctermfg=167   ctermbg=234
hi SpecialChar     ctermfg=181                  cterm=bold
hi SpecialComment  ctermfg=108                  cterm=bold
hi Special         ctermfg=181
hi SpecialKey      ctermfg=151
hi Statement       ctermfg=186
hi StatusLine      ctermfg=232   ctermbg=241
hi StatusLineNC    ctermfg=235   ctermbg=208
hi StorageClass    ctermfg=249                  cterm=bold
hi String          ctermfg=174
hi Structure       ctermfg=229                  cterm=bold
hi Tag             ctermfg=181                  cterm=bold
hi TabLine         ctermfg=100   ctermbg=none   cterm=none
hi TabLineFill     ctermfg=100   ctermbg=none   cterm=none
hi TabLineSel      ctermfg=220                  cterm=none
hi Title           ctermfg=7     ctermbg=234    cterm=bold
hi Todo            ctermfg=108   ctermbg=234    cterm=bold
hi Typedef         ctermfg=253                  cterm=bold
hi Type            ctermfg=187                  cterm=bold
hi Underlined      ctermfg=188   ctermbg=234    cterm=bold
hi VertSplit       ctermfg=236   ctermbg=65
hi Visual          ctermfg=210   ctermbg=236    cterm=bold
hi WarningMsg      ctermfg=15    ctermbg=none   cterm=bold
hi WildMenu        ctermbg=236   ctermfg=194    cterm=bold
hi CursorLine      ctermbg=236

" spellchecking, always "bright" background
hi SpellLocal      ctermfg=14    ctermbg=236
hi SpellBad        ctermfg=9     ctermbg=236
hi SpellCap        ctermfg=12    ctermbg=236
hi SpellRare       ctermfg=13    ctermbg=236

" pmenu
hi PMenu           ctermfg=248   ctermbg=0
hi PMenuSel        ctermfg=222   ctermbg=236

" end
