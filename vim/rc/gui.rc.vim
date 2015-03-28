" GUI:
"

"---------------------------------------------------------------------------
" Fonts: "{{{
set ambiwidth=double

if has('win32') || has('win64')
  " For Windows.

  "set guifontwide=VL\ Gothic:h11
  "set guifontwide=MigMix\ 1M:h11

  set guifontwide=Consolas:h13:cANSI
  set guifont=Consolas:h11:cANSI
  set guifontwide=DejaVu\ Sans\ Mono:h12

  "set guifont=Anonymous\ Pro:h11
  "set guifont=Courier\ New:h11
  "set guifont=MS\ Gothic:h11
  "set guifont=VL\ Gothic:h11
  "set guifont=Consolas:h12
  "set guifont=Bitstream\ Vera\ Sans\ Mono:h11
  "set guifont=Inconsolata:h12
  "set guifont=Terminal:h10:cSHIFTJIS

  " Number of pixel lines inserted between characters.
  set linespace=1

  if has('patch-7.4.394')
    " Use DirectWrite
    set renderoptions=type:directx,gammma:2.2,mode:3
  endif

  " Toggle font setting.
  function! FontToggle()
    if &guifont=~ '^VL Gothic:'
      set guifont=Courier\ New:h11
      set guifontwide=VL\ Gothic:h11

      " Width of window.
      set columns=155
      " Height of window.
      set lines=50
    else
      set guifont=VL\ Gothic:h11.5
      set guifontwide=

      " Width of window.
      set columns=200
      " Height of window.
      set lines=43
    endif
  endfunction

  nnoremap TF     :<C-u>call FontToggle()<CR>

elseif has('mac')
  " For Mac.
  set guifont=Osaka－等幅:h14
else
  " For Linux.
  " set guifontwide=VL\ Gothic\ 11
  set guifont=Monospace\ 8
  set guifont=Inconsolata\ Medium\ 11
  set linespace=0
endif"}}}

"---------------------------------------------------------------------------
" Window:"{{{
"
if has('win32') || has('win64')
  " Width of window.
  set columns=230
  " Height of window.
  set lines=55

  " Set transparency.
  "autocmd GuiEnter * set transparency=221
  " Toggle font setting.
  command! TransparencyToggle let &transparency =
        \ (&transparency != 255 && &transparency != 0)? 255 : 221
  nnoremap TT     :<C-u>TransparencyToggle<CR>
else
  " Width of window.
  set columns=151
  " Height of window.
  set lines=41
endif

" Don't override colorscheme.
if !exists('g:colors_name')
  " execute 'colorscheme' globpath(&runtimepath,
  "       \ 'colors/candy.vim') != '' ? 'candy' : 'desert'
  execute 'colorscheme' globpath(&runtimepath,
        \ 'colors/peskcolor.vim') != '' ? 'peskcolor' : 'desert'
endif
"}}}

"---------------------------------------------------------------------------
" Mouse:"{{{
"
set mousemodel=extend

" Don't focus the window when the mouse pointer is moved.
set nomousefocus
" Hide mouse pointer on insert mode.
set mousehide
"}}}

"---------------------------------------------------------------------------
" Menu:"{{{
"

" Hide toolbar and menus.
set guioptions-=Tt
set guioptions-=m
" Scrollbar is always off.
set guioptions-=rL
" Not guitablabel.
set guioptions-=e

" Confirm without window.
set guioptions+=c
"}}}

"---------------------------------------------------------------------------
" Views:"{{{
"
" Don't highlight search result.
set nohlsearch

" Don't flick cursor.
set guicursor&
set guicursor+=a:blinkon0
"}}}

" vim: foldmethod=marker
