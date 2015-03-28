" Vim color file: crutux
" Maintainer:   Anders Sildnes
" Last Change:  2001 Jul 23
" http://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg

hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "default"

" show what line the cursor is on
set cursorline
"set cursorcolumn
highlight CursorLine cterm=NONE ctermbg=235
"highlight CursorColumn ctermbg=233
hi CursorLineNr  term=bold ctermfg=Yellow 

hi TabLine gui=NONE guibg=#2C2C2C guifg=NONE
hi TabLineFill gui=NONE guibg=#2C2C2C guifg=NONE gui=NONE
hi StatusLine gui=NONE guifg=#FFFFFF guibg=#008000



" 16 = black
" TabLineFill = part of tabbar that is unused
highlight TabLineFill ctermfg=16
" TabLine = tabs that are in tabbar, but not focused
highlight TabLine ctermfg=White ctermbg=16
" TabLineSel = currently open tab
highlight TabLineSel ctermfg=White ctermbg=Blue

" color of the sidebar (occurs, i.e. when syntastic shows an error)
highlight SignColumn ctermbg=16

highlight SpellBad ctermbg=Black ctermfg=Red
highlight SpellCap ctermbg=023 " Also syntastic warning
highlight SyntasticError ctermbg=161

highlight Search ctermbg=Black ctermfg=Yellow
highlight Search ctermbg=Black ctermfg=Yellow

highlight VertSplit cterm=none

highlight DiffAdd ctermbg=88 ctermfg=white
highlight DiffChange cterm=none ctermfg=none ctermbg=235
highlight DiffDelete ctermbg=23 ctermfg=183

highlight Folded ctermbg=52 ctermfg=169
highlight Visual cterm=NONE ctermbg=238 ctermfg=255


highlight VertSplit cterm=none

" Add a line in vim to indicate the suggested 80 charwidth treshold
if exists('+colorcolumn')
    highlight ColorColumn ctermbg=darkgrey
    highlight ColorColumn ctermbg=233
    " highlight ColorColumn ctermbg=White
    set colorcolumn=81
    " call matchadd('ColorColumn', '\%81v', 100)
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


highlight  StatusLine cterm = none ctermbg = 16

highlight FoldColumn cterm = none ctermbg = 16 ctermfg = 4 

" green = 2
highlight Comment ctermfg = green


highlight SpellBad ctermbg=Black ctermfg=Red
highlight Search ctermbg=Black ctermfg=Yellow

" Nc = not current (when using splits)
highlight StatusLine cterm=bold term=bold ctermbg=Blue ctermfg=White
highlight StatusLineNc ctermfg=017 ctermbg=15


" vim: sw=2
