set background=dark
highlight clear

if exists('syntax_on')
  syntax reset
endif

let colors_name = 'peskcolor'

highlight Normal       guifg=#dfdfdf guibg=#101010

" Popup color.
hi Pmenu ctermbg=8
hi PmenuSel ctermbg=1
hi PmenuSbar ctermbg=0

" Search
highlight IncSearch    gui=UNDERLINE guifg=#80ffff guibg=#0060c0
highlight Search       gui=NONE guifg=#f0f0f8 guibg=#0060c0 
                                                     
" Messages                                           
highlight ErrorMsg     gui=BOLD guifg=#ffa0ff guibg=#101010
highlight WarningMsg   gui=BOLD guifg=#ffa0ff guibg=#101010
highlight ModeMsg      gui=BOLD guifg=#40f0d0 guibg=#101010
highlight MoreMsg      gui=BOLD guifg=#00ffff guibg=#101010
highlight Question     gui=BOLD guifg=#e8e800 guibg=#101010

let statuslineFG="#DEFDDD"
let statuslineBG="#4B4B4B"
" Split area
exe 'hi StatusLine gui=NONE guibg=#300000 guifg=' . statuslineFG
highlight StatusLineNC gui=NONE guifg=#DDDDDD guibg=#1A1A1A ctermbg=8
exe 'highlight VertSplit    gui=NONE guifg=' . statuslineFG
highlight WildMenu     gui=NONE guifg=#252525 guibg=#a0a0ff

" Diff
highlight DiffText     gui=NONE guifg=#ff78f0 guibg=#802860
highlight DiffChange   gui=NONE guifg=#e03870 guibg=#401830
highlight DiffDelete   gui=NONE guifg=#a0d0ff guibg=#0020a0
highlight DiffAdd      gui=NONE guifg=#a0d0ff guibg=#0020a0

" Cursor
highlight Cursor       gui=NONE guifg=#00ffff guibg=#008070
highlight CursorLine   gui=NONE guifg=NONE    guibg=#555555
highlight lCursor      gui=NONE guifg=NONE guibg=#80403f
highlight CursorIM     gui=NONE guifg=NONE guibg=#bb00aa

" Fold
highlight Folded       gui=NONE guifg=#40f0f0 guibg=#106090
highlight FoldColumn   gui=NONE guifg=#40c0ff guibg=#10406c

" Other
highlight Directory    gui=NONE guifg=#40f0d0 guibg=#101010
highlight LineNr       gui=NONE guifg=#c0c0c0 guibg=#101010
highlight NonText      gui=BOLD guifg=#4080ff guibg=#101010
highlight SpecialKey   gui=BOLD guifg=#8000fd guibg=#101010
highlight Title        gui=BOLD guifg=#f0f0f8 guibg=#101010
highlight Visual       gui=NONE guifg=#e0e0f0 guibg=#714080

" Syntax group
highlight Comment      gui=NONE guifg=#c7c7f9 guibg=#101010
highlight Constant     gui=NONE guifg=#90d0ff guibg=#101010
highlight Error        gui=BOLD guifg=#ffa0af guibg=#101010
highlight Identifier   gui=NONE guifg=#40f0f0 guibg=#101010
highlight Ignore       gui=NONE guifg=#101010 guibg=#101010
highlight PreProc      gui=NONE guifg=#40f0a0 guibg=#101010
highlight Special      gui=NONE guifg=#e0e080 guibg=#101010
highlight Statement    gui=NONE guifg=#ffa0ff guibg=#101010
highlight Todo         gui=BOLD,UNDERLINE guifg=#ffa0a0 guibg=#101010
highlight Type         gui=NONE guifg=#ffc864 guibg=#101010
highlight Underlined   gui=UNDERLINE guifg=#f0f0f8 guibg=#101010
highlight ColorColumn  gui=NONE guifg=NONE guibg=#1A1A1A

" HTML
highlight htmlLink                 gui=UNDERLINE
highlight htmlBold                 gui=BOLD
highlight htmlBoldItalic           gui=BOLD,ITALIC
highlight htmlBoldUnderline        gui=BOLD,UNDERLINE
highlight htmlBoldUnderlineItalic  gui=BOLD,UNDERLINE,ITALIC
highlight htmlItalic               gui=ITALIC
highlight htmlUnderline            gui=UNDERLINE
highlight htmlUnderlineItalic      gui=UNDERLINE,ITALIC

" Menu
highlight Pmenu                    guibg=#606060
highlight PmenuSel                 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar                guibg=#d6d6d6
highlight PmenuThumb               guifg=#3cac3c

" Tab
highlight TablineSel               gui=NONE guifg=#f0f0f8 guibg=#0060c0
highlight Tabline                  gui=NONE guifg=#252525 guibg=#c8c8d8
highlight TablineFill              gui=NONE guifg=#252525 guibg=#c8c8d8


highlight TablineSel               gui=NONE guifg=#f0f0f8 guibg=#411111
hi TabLineFill guibg=#101010 gui=NONE
hi TabLine guibg=#101010 guifg=#FFFFFF gui=NONE

exe 'highlight SignColumn gui=NONE guibg=#111111'


hi clear Conceal
