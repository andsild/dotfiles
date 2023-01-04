set termencoding=utf-8

set background=dark
let g:mapleader = ','

let g:default_colorscheme = 'koehler'
if has('vim_starting')
  set encoding=utf-8
  scriptencoding utf8

  filetype plugin indent on
  exe 'silent! colorscheme ' . g:default_colorscheme
endif

augroup DefaultAuGroup
    autocmd!

    autocmd FileType javascript,css,java,nix nmap <silent> ;; <Plug>(cosco-commaOrSemiColon)
    autocmd FileType javascript,css,java,nix imap <silent> ;; <c-o><Plug>(cosco-commaOrSemiColon)<C-\><C-n>
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd BufWritePost,FileWritePost *.vim    if &autoread | source <afile> | echo 'source ' . bufname('%') | endif
    autocmd BufWritePost,FileWritePost *.lvimrc if &autoread | source <afile> | echo 'source ' . bufname('%') | endif
    autocmd BufWritePre * call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
    autocmd FileType gitcommit,qfreplace setlocal nofoldenable
    autocmd FileType pdf Pdf '%'
    autocmd TermOpen term://* setlocal norelativenumber

    autocmd BufWritePost *
    \ if &l:filetype ==# '' || exists('b:ftdetect')
    \ |   unlet! b:ftdetect
    \ |   filetype detect
    \ | endif

augroup END

call plug#begin()
Plug '907th/vim-auto-save'
Plug 'andsild/missing-spellfiles-neovim'
Plug 'andsild/suckless.vim'
Plug 'andsild/vim-choosewin'
Plug 'andsild/vim-unimpaired'
Plug 'embear/vim-localvimrc'
Plug 'habamax/vim-godot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-niceblock/'
Plug 'kana/vim-textobj-user'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/committia.vim'
Plug 't9md/vim-smalls'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tyru/caw.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

call plug#end()

filetype on
set autoindent
set autoread " Auto reload if file is changed.
set autowriteall
set backspace=indent,eol,start
set backupdir-=.
set breakat=\ \ ;:,!?
set cmdheight=2
set cmdwinheight=5
" set complete=.
" set completeopt=menu
"set conceallevel=2 concealcursor=iv
set cpoptions-=m " Highlight when CursorMoved.
set directory-=. " Set swap directory.
set display=lastline
set expandtab " Exchange tab to spaces.
set fileignorecase
set fillchars=vert:\|
set foldcolumn=0 " Show folding level.
set foldenable " Enable folding.
set foldlevel=99 " Auto unfold all
set foldmethod=indent
set grepprg=grep\ -inH " Use grep.
set helpheight=12
set hidden " Display another buffer when current buffer isn't saved.
set history=1000
set hlsearch
set ignorecase " Ignore the case of normal letters.
set incsearch " Enable incremental search.
set infercase " Ignore case on insert completion.
set isfname-== " Exclude = from isfilename.
set laststatus=2
set lazyredraw
set linebreak
set matchpairs+=<:> " Highlight <>.
set matchtime=3
set modeline " Enable modeline.
set nobackup
set noequalalways
set nonumber
set noshowcmd
set noshowmode
set nosmartcase " not good with dragon naturally speaking
set nostartofline
set noswapfile
set novisualbell
set nowildmenu
set nowritebackup
set previewheight=5
set pumheight=0
set report=0
set secure
set sessionoptions="blank,curdir,folds,help,winsize"
set shiftround
set shiftwidth=2 " Round indent by shiftwidth.
set shortmess=aTIc
set showbreak=>\
set showfulltag
set showmatch " Highlight parenthesis.
set showtabline=2
set smartindent
set smarttab " Smart insert tab setting.
set softtabstop=2 " Spaces instead <Tab>.
set splitbelow
set splitright
set t_vb=
set tabstop=2 " Substitute <Tab> with blanks.
set tags=./tags,tags,../tags
set timeout timeoutlen=3000 ttimeoutlen=100 " Keymapping timeout.
set title
set titlelen=95
set ttyfast
set undofile
set updatetime=1000 " CursorHold time.
set viewdir=$CACHE/vim_view viewoptions-=options viewoptions+=slash,unix
set virtualedit=block " Enable virtualedit in visual block mode.
set whichwrap+=h,l,<,>,[,],b,s,~
set wildignorecase
set wildmode=list:longest
set wildoptions=tagfile
set winminheight=0
set winminwidth=0
set winwidth=1
set wrapscan " Searches wrap around the end of the file.

if !&verbose
  set spelllang=en_us
endif
if has('clipboard')
  xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
  set clipboard& clipboard+=unnamed
endif

if has('nvim')
  " set completeopt+=noinsert,noselect,menu
  set inccommand=split
  tnoremap <ESC><ESC> <C-\><C-n>
  tnoremap <C-6> <C-\><C-n><C-6>zz
  tnoremap <Esc><Esc> <C-\><C-n>
  tnoremap jj <C-\><C-n>
  tnoremap kk <C-\><C-n>

  highlight TermCursorNC ctermbg=15
  tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif

tmap <c-r> <c-u>`cat ~/.bash_history \| fzf`<CR>
cmap w!! w !sudo tee > /dev/null %
cnoremap <C-a>          <Home>
cnoremap <C-b>          <Left>
cnoremap <C-d>          <Del>
cnoremap <C-e>          <End>
cnoremap <C-f>          <Right>
cnoremap <C-n>          <Down>
cnoremap <C-p>          <Up>
cnoremap <C-y>          <C-r>*
imap <F1> <Esc>
imap <expr><c-s> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap jj <Esc>
imap kk <Esc>
inoremap <C-6> <Esc><C-6>zz
inoremap <C-d>  <Del>
inoremap <C-u>  <C-g>u<C-u>
inoremap <C-w>  <C-g>u<C-w>
inoremap <c-b> <Esc>i
nmap <C-a> <SID>(increment)
nmap <C-w>  <Plug>(choosewin)
nmap <C-x> <SID>(decrement)
nmap <F8> :TagbarToggle<CR>
nmap <Space>   [Space]
nmap <silent> <F6> :silent NextWordy<CR>
nmap <silent> <F7> :call ToggleSpell()<CR>
nmap <silent>sa <Plug>(operator-surround-append)a
nmap <silent>sc <Plug>(operator-surround-replace)a
nmap <silent>sd <Plug>(operator-surround-delete)a
nmap <silent>sr <Plug>(operator-surround-replace)a
nmap S <Plug>(smalls)
nmap gc <Plug>(caw:prefix)
nmap gcc <Plug>(caw:hatpos:toggle)
nmap j gj
nmap k gk
nnoremap  [Space]   <Nop>
nnoremap * :silent set hlsearch<CR>*<C-o>
nnoremap ,  <Nop>
nnoremap 99 :Make!<CR>
nnoremap ;  <Nop>
nnoremap ;d :bdelete<CR>
nnoremap ;s :split<CR>
nnoremap ;t :tabe<CR>
nnoremap ;v :vsplit<CR>
nnoremap <C-o> <C-o>zz
nnoremap <Down> :res -5<CR>
nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap <F1> <Esc>
nnoremap <F9> :silent make! <bar> redraw!<CR>
nnoremap <Leader>ar :<C-u>setlocal autoread<CR>
nnoremap <Leader>w :<C-u>call ToggleOption('wrap')<CR>
nnoremap <Left> :10winc<<CR>
nnoremap <Right> :10winc><CR>
nnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>
nnoremap <Tab> <Tab>zz
nnoremap <Up> :res +5<CR>
nnoremap <leader>do :diffoff<CR>
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>hs :call <C-u>call ToggleOption('hlsearch')<CR>
nnoremap <leader>t :term<CR>
nnoremap <leader>u :diffupdate<CR>
nnoremap <silent> / :BLines<CR>
nnoremap <silent> <C-l>    :<C-u>redraw!<CR>
nnoremap <silent> <Leader>. :<C-u>call ToggleOption('number')<CR>
nnoremap <silent> <Leader>ss mm:%s/\s\+$//g<CR>`mmmzzmm:set nohlsearch<CR>:echo 'Took away whitespace'<CR>
nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
nnoremap <silent> <SID>(increment)    :AddNumbers 1<CR>
nnoremap <silent> <Space>m :Buffers<CR>
nnoremap <silent> <c-t> :tabe<CR>
nnoremap <silent> [Space]l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> [Space]q :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> [Space]t :FZF<CR>
nnoremap <silent> z/ :Zeavim<CR>
nnoremap > >>
nnoremap Q  q " Disable Ex-mode.
nnoremap [Quickfix]   <Nop> " q: Quickfix
nnoremap [Space]/  :Ag<CR>
nnoremap [Space]O :FZFFavorites<CR>
nnoremap [Space]o :FZFGit<CR>
nnoremap [Space]w :silent Neomake<CR>
nnoremap \  `
nnoremap dh :diffget //3<CR>
nnoremap dl :diffget //2<CR>
nnoremap m! :Make!<CR>
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
silent! nnoremap < <<
vmap gcc <Plug>(caw:hatpos:toggle)
vnoremap ; <Esc>
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>
vnoremap do :'<,'>diffget<CR>:diffupdate<CR>
vnoremap dp :'<,'>diffput<CR>:diffupdate<CR>
xmap  <Space>   [Space]
xmap <Enter> <Plug>(EasyAlign)
xmap A  <Plug>(niceblock-A)
xmap I  <Plug>(niceblock-I)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)
xnoremap  [Space]   <Nop>
xnoremap ,  <Nop>
xnoremap ;  <Nop>
xnoremap < <gv
xnoremap <S-TAB>  <
xnoremap <SID>(command-line-enter) q:
xnoremap <TAB>  >
xnoremap > >gv
xnoremap m  <Nop>
xnoremap r <C-v> " Select rectangle.

if has('clipboard')
  xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
endif
if has('mouse')
  set mouse=a

  nnoremap <RightMouse> "+p
  xnoremap <RightMouse> "+p
  inoremap <RightMouse> <C-r><C-o>+
  cnoremap <RightMouse> <C-r>+
endif

let &undodir=&directory
let g:Gitv_DoNotMapCtrlKey = 1
let g:Gitv_OpenHorizontal = 'auto'
let g:echodoc_enable_at_startup = 0
let g:Gitv_WipeAllOnClose = 1
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:choosewin_blink_on_land = 0
let g:choosewin_overlay_clear_multibyte = 1
let g:localvimrc_whitelist='.*'
let g:localvimrc_sandbox=0
let g:choosewin_overlay_enable = 1
let g:formatters_javascript = ['jscs']
let g:haddock_browser = 'firefox'
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:intero_stack_yaml='stack.yaml'
let g:jsx_ext_required = 0
let g:livepreview_previewer = 'zathura'
let g:maplocalleader = 'm' " Use <LocalLeader> in filetype plugin.
let g:myLang=0
let g:myLangList=['nospell','en_us', 'nb', 'weak']
let g:neosnippet#snippets_directory=expand($XDG_CONFIG_HOME) . '/nvim/snippets'
let g:python_highlight_all = 1
let g:vimsyntax_noerror = 1
let s:my_split = {'is_selectable': 1}

command! -bang -complete=file -nargs=* FZFGit call fzf#run({
  \ 'source':  printf('(cd %s ; git ls-files --no-empty-directory --exclude-standard . | egrep -v "\.zip$|\.gz$|\.jpg$|\.png$|\.jar$" | sed -e s,^,%s/,)',
  \ escape(empty(<q-args>) ? '.' : <q-args>, '"\'), escape(empty(<q-args>) ? '.' : <q-args>, '"\')),
  \ 'sink':    'edit',
  \ 'options': '-m -x +s -e',
  \ 'down':    '40%' })
command! FZFMru call fzf#run({
  \ 'source':  reverse(s:all_files()),
  \ 'sink':    'edit',
  \ 'options': '-m -x +s -e',
  \ 'down':    '40%' })
command! FZFFavorites call fzf#run({
  \ 'source':  'fdfind -H -a --type file --color never . ${HOME}/dotfiles/ ${HOME}/all-things-phd',
  \ 'sink':    'edit',
  \ 'options': '-m -x +s -e',
  \ 'down':    '40%' })
command! -range -nargs=1 AddNumbers
  \ call s:add_numbers((<line2>-<line1>+1) * eval(<args>))
command! FZFLines mksession! /tmp/layout.vim | call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})
command! Wa wa
command! WQa wqa
command! Qa qa
command! Wqa wqa
command! W w
command! GS execute 'Gstatus | res +10'

function! s:mkdir_as_necessary(dir, force)
  if !isdirectory(a:dir) && &l:buftype ==? '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! ToggleSpell()
  let g:myLang=g:myLang+1
  if g:myLang==len(g:myLangList)
    let g:myLang=0
  endif
  if g:myLang==0
    setlocal nospell
  else
    execute 'setlocal spell spelllang=' . get(g:myLangList, g:myLang)
  endif
  echo 'spell checking language:' g:myLangList[g:myLang]
endfunction

function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! GetBufferList()
  redir => l:buflist
  silent! ls
  redir END
  return l:buflist
endfunction

function! ToggleList(bufname, pfx)
  let l:buflist = GetBufferList()
  for l:bufnum in map(filter(split(l:buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(l:bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx ==# 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo 'Location List is Empty.'
      return
  endif
  let l:winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != l:winnr
    wincmd p
  endif
endfunction

function! s:toggle_quickfix_window()
  let l:_ = winnr('$')
  cclose
  if l:_ == winnr('$')
    copen
    setlocal nowrap
    setlocal whichwrap=b,s
  endif
endfunction

function! s:add_numbers(num)
  let l:prev_line = getline('.')[: col('.')-1]
  let l:next_line = getline('.')[col('.') :]
  let l:prev_num = matchstr(l:prev_line, '\d\+$')
  if l:prev_num !=? ''
    let l:next_num = matchstr(l:next_line, '^\d\+')
    let l:new_line = l:prev_line[: -len(l:prev_num)-1] .
          \ printf('%0'.len(l:prev_num . l:next_num).'d',
          \    max([0, l:prev_num . l:next_num + a:num])) . l:next_line[len(l:next_num):]
  else
    let l:new_line = l:prev_line . substitute(l:next_line, '\d\+',
          \ "\\=printf('%0'.len(submatch(0)).'d',
          \         max([0, submatch(0) + a:num]))", '')
  endif

  if getline('.') !=# l:new_line
    call setline('.', l:new_line)
  endif
endfunction

function! ToggleOption(option_name)
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction

function! ToggleVariable(variable_name)
  if eval(a:variable_name)
    execute 'let' a:variable_name.' = 0'
  else
    execute 'let' a:variable_name.' = 1'
  endif
endfunction

if executable('pdftotext')
  command! -complete=file -nargs=1 Pdf call s:read_pdf(<q-args>)
  function! s:read_pdf(file)
    enew
    execute 'read !pdftotext -nopgbrk -layout' a:file '-'
    setlocal nomodifiable
    setlocal nomodified
  endfunction
endif

function! s:strwidthpart(str, width)
  if a:width <= 0
    return ''
  endif
  let l:ret = a:str
  let l:width = s:wcswidth(a:str)
  while l:width > a:width
    let l:char = matchstr(l:ret, '.$')
    let l:ret = l:ret[: -1 - len(l:char)]
    let l:width -= s:wcswidth(l:char)
  endwhile

  return l:ret
endfunction

" Use builtin function.
function! s:wcswidth(str)
    return strwidth(a:str)
endfunction

function! s:all_files()
  let l:oldfilesFiltered = filter(copy(v:oldfiles),
    \        "v:val !~# 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/|.REMOTE.*'")
  let l:indexedFileList = extend(l:oldfilesFiltered,
    \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))


  return l:indexedFileList
endfunction

function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:line_handler(l)
  let l:keys = split(a:l, ':\t')
  exec 'buf' l:keys[0]
  exec l:keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let l:res = []
  for l:b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(l:res, map(getbufline(l:b,0,'$'), 'l:b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return l:res
endfunction

function! s:ag_to_qf(line)
  let l:parts = split(a:line, ':')
  return {'filename': l:parts[0], 'lnum': l:parts[1], 'col': l:parts[2],
        \ 'text': join(l:parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  " I want to keep the window layout (the fzf popup moves everything around)
  " Therefore I make a vim session and restore it
  " However, if a terminal is open,
  " I get a bug related to: https://github.com/neovim/neovim/issues/4895
  let l:openWindows=[]
  windo call add(l:openWindows, winnr())
  let l:terminalIsOpen=0
  for l:winnr in l:openWindows
    if bufname(winbufnr(l:winnr)) =~# 'term://'
        let l:terminalIsOpen=1
    endif
  endfor
  if l:terminalIsOpen == 0
    source /tmp/layout.vim " keep windows the way they were!
  else
    wincmd p " go back to previous window before switching to search result
  endif

  let l:cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let l:list = map(a:lines[1:], 's:ag_to_qf(v:val)')
  let l:chosen_result = l:list[0]

  execute l:cmd escape(l:chosen_result.filename, ' %#\')
  execute l:chosen_result.lnum
  execute 'normal!' l:chosen_result.col.'|zz'

  if len(l:list) > 1
    call setqflist(l:list)
    copen
    wincmd p
  endif
endfunction

function! s:buflist()
  redir => l:ls
  silent ls
  redir END
  return split(l:ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

command! -complete=file -nargs=* Ag mksession! /tmp/layout.vim | call fzf#run({
\ 'source':  printf('ag --nogroup --column --nocolor "^(?=.)" "%s"',
\                   escape(empty(<q-args>) ? '.' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

function! s:tags_sink(line)
  let l:parts = split(a:line, '\t\zs')
  let l:excmd = matchstr(l:parts[2:], '^.*\ze;"\t')
  execute 'silent e' l:parts[1][:-2]
  let [l:magic, &magic] = [&magic, 0]
  execute l:excmd
  let &magic = l:magic
endfunction

let &titlestring="
  \ %{expand('%:p:.:~')}%(%m%r%w%)
  \ %<\(%{".s:SID_PREFIX()."strwidthpart(fnamemodify(getcwd(), ':~'),
  \ &columns-len(expand('%:p:.:~')))}\) - VIM"
let &statusline=' '
  \ . "%{(&previewwindow?'[preview] ':'').expand('%')}"
  \ . "%=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
  \ . "%{printf(' %4d/%d',line('.'),line('$'))} %c"

" ctrl-v
vnoremap <C-C> "+y
map <C-v> p
cmap <C-v> <C-R>+
imap <C-v> <C-r>"
noremap <c-Q> <C-V>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : pumvisible() ? "<c-n>" : "<TAB>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)


" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)


" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
