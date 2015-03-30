"---------------------------------------------------------------------------
" For UNIX:
"
set shell=bash

if has('gui_running')
  finish
endif

"---------------------------------------------------------------------------
" For CLI:
"

" Enable 256 color terminal.
set t_Co=256

if has('gui')
  " Use CSApprox.vim
  NeoBundleSource csapprox

  if !exists('g:colors_name')
    execute 'colorscheme' globpath(&runtimepath,
          \ 'colors/candy.vim') != '' ? 'candy' : 'desert'
  endif
else
  " Use guicolorscheme.vim
  NeoBundleSource vim-guicolorscheme

  " Disable error messages.
  let g:CSApprox_verbose_level = 0
endif
