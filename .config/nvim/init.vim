  set termencoding=utf-8


function! s:IsMac()
  let l:sysout=system('uname')
  return has('unix') && match(l:sysout, '\cDarwin') == 0
endfunction

if s:IsMac()
    nnoremap <silent> ± ~
    cnoremap ± ~
    inoremap ± ~
    inoremap § `
    nnoremap ± ~
    nnoremap § `
    cnoremap ± ~
    cnoremap § `
    vnoremap ± ~
    vnoremap § `
endif

let g:default_colorscheme = 'koehler'
set background=dark
let g:mapleader = ','

if &compatible
  " vint: -ProhibitSetNoCompatible
  set nocompatible
endif

if has('vim_starting')
  set encoding=utf-8
  scriptencoding utf8

  filetype plugin indent on
  exe 'silent! colorscheme ' . g:default_colorscheme
endif

" Disable netrw.vim
let g:loaded_netrwPlugin = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1
let t:cwd = getcwd()

augroup my_git_rebase
  autocmd!
  autocmd FileType gitrebase nnoremap <buffer> <Leader>cy :Cycle<cr>
  autocmd FileType gitrebase nnoremap <buffer> <Leader>ed :Edit<cr>
  autocmd FileType gitrebase nnoremap <buffer> <Leader>fi :Fixup<cr>
  autocmd FileType gitrebase nnoremap <buffer> <Leader>pi :Pick<cr>
  autocmd FileType gitrebase nnoremap <buffer> <Leader>sq :Squash<cr>
  autocmd FileType gitrebase nnoremap <buffer> <Leader>re :Reword<cr>
augroup END

augroup DefaultAuGroup
    autocmd!

    autocmd FileType javascript,css,java,nix nmap <silent> ;; <Plug>(cosco-commaOrSemiColon)
    autocmd FileType javascript,css,java,nix imap <silent> ;; <c-o><Plug>(cosco-commaOrSemiColon)<C-\><C-n>
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd BufWritePost,FileWritePost *.vim    if &autoread | source <afile> | echo 'source ' . bufname('%') | endif
    autocmd BufWritePost,FileWritePost *.lvimrc if &autoread | source <afile> | echo 'source ' . bufname('%') | endif
    autocmd BufWritePre * call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
    autocmd FileType c,cpp set formatprg=astyle
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType gitcommit,qfreplace setlocal nofoldenable
    autocmd FileType go highlight default link goErr WarningMsg | match goErr /\<err\>/
    autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=./;/
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd CursorHold *.java silent call CocActionAsync('highlight')
    autocmd FileType javascript,javascript.jsx nmap <buffer> <s-k> :TernDoc<CR>
    autocmd FileType pdf Pdf '%'
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType python setlocal formatprg=autopep8\ --aggressive\ --ignore=E309\ -
    autocmd FileType qf nnoremap <buffer> r :<C-u>Qfreplace<CR>
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd InsertLeave * if &l:diff | diffupdate | endif " Update diff.
    autocmd InsertLeave * if &paste | set nopaste mouse=a | echo 'nopaste' | endif | if &l:diff | diffupdate | endif
    autocmd WinEnter * checktime " Check timestamp more for 'autoread'.
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc  | setlocal formatprg=stylish-haskell
    autocmd FileType haskell nnoremap <silent><buffer>K :GhcModInfoPreview<CR>
    autocmd TermOpen term://* setlocal norelativenumber

    if has('python3')
        autocmd FileType python setlocal omnifunc=python3complete#Complete
    else
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    endif
    autocmd BufWritePost *
    \ if &l:filetype ==# '' || exists('b:ftdetect')
    \ |   unlet! b:ftdetect
    \ |   filetype detect
    \ | endif

augroup END

augroup syntax-highlight-extends
  autocmd!
  autocmd Syntax vim
        \ call s:set_syntax_of_user_defined_commands()
augroup END

filetype on
set autoindent
set autoread " Auto reload if file is changed.
set autowriteall
set backspace=indent,eol,start
set backupdir-=.
set breakat=\ \ ;:,!?
set cmdheight=2
set cmdwinheight=5
set commentstring=%s
set complete=.
set completeopt=menu
set conceallevel=2 concealcursor=iv
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
set hlsearch " Don't highlight search result.
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
set shell=bash
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

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif
if $GOROOT !=? ''
  set runtimepath+=$GOROOT/misc/vim
endif
if !&verbose
  set spelllang=en_us
endif
if has('clipboard')
  xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
  set clipboard& clipboard+=unnamed
endif

if has('nvim')
  set completeopt+=noinsert,noselect,menu
  set inccommand=split
  tnoremap <ESC><ESC> <C-\><C-n>
  tnoremap <C-6> <C-\><C-n><C-6>zz
  tnoremap <Esc><Esc> <C-\><C-n>
  tnoremap jj <C-\><C-n>
  tnoremap kk <C-\><C-n>

  highlight TermCursorNC ctermbg=15
  tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif

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
map 0 ^
map <F1> <Esc>
nmap <Space>   [Space]
nmap <C-6> <C-6>zz
nmap <C-a> <SID>(increment)
nmap <C-w>  <Plug>(choosewin)
nmap <C-x> <SID>(decrement)
nmap <F1> <nop>
nmap <F8> :TagbarToggle<CR>
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
nnoremap <silent> <Space>m :Buffers<CR> 
nnoremap  [Space]   <Nop>
nnoremap * :silent set hlsearch<CR>*<C-o>
nnoremap ,  <Nop>
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
nnoremap <Leader>w :<C-u>call ToggleOption('wrap')<CR>
nnoremap <Left> :10winc<<CR>
nnoremap <Right> :10winc><CR>
nnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>
nnoremap <Tab> <Tab>zz
nnoremap <Up> :res +5<CR>
nnoremap <leader>hi :call <SID>SynStack()<CR>
nnoremap <leader>hs :call <C-u>call ToggleOption('hlsearch')<CR>
nnoremap <leader>lc :call <SID>ToggleShowListChars()<CR>
nnoremap <leader>sp :<C-u>call ToggleOption('spell')<CR>
nnoremap <leader>t :term<CR>
nnoremap <leader>u :diffupdate<CR>
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff<CR>
nnoremap <silent> / :BLines<CR>
nnoremap <silent> ;o  :<C-u>only<CR>
nnoremap <silent> <C-b> <C-b>
nnoremap <silent> <C-f> <C-f>
nnoremap <silent> <C-l>    :<C-u>redraw!<CR>
nnoremap <silent> <Leader>. :<C-u>call ToggleOption('number')<CR>
nnoremap <silent> <Leader><C-m> mmHmt:<C-u>%s/\r$//ge<CR>'tzt'm:echo 'Took away c-m'<CR>
nnoremap <silent> <Leader>au :Autoformat<CR>
nnoremap <silent> <Leader>cl :<C-u>call ToggleOption('cursorline')<CR>
nnoremap <silent> <Leader>cs :call ToggleColorScheme()<CR>
nnoremap <silent> <Leader>ss mm:%s/\s\+$//g<CR>`mmmzzmm:set nohlsearch<CR>:echo 'Took away whitespace'<CR>
nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
nnoremap <silent> <SID>(increment)    :AddNumbers 1<CR>
nnoremap <silent> <c-t> :tabe<CR>
nnoremap <silent> [Quickfix]<Space> :<C-u>call <SID>toggle_quickfix_window()<CR>
" nnoremap <silent> [Space]t :FZFTags<CR>
nnoremap <silent> [Space]t :FZF<CR>
nnoremap <silent> [Space]l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> [Space]q :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> z/ :Zeavim<CR>
nnoremap <silent> } :<C-u>call ForwardParagraph()<CR>
nnoremap > >>
nnoremap M  m
nnoremap Q  q " Disable Ex-mode.
nnoremap [Quickfix]   <Nop> " q: Quickfix
nnoremap [Space]/  :Ag<CR>
nnoremap [Space]O :FZFFavorites<CR>
nnoremap <Leader>ar :<C-u>setlocal autoread<CR>
nnoremap [Space]o :FZFGit<CR>
nnoremap [Space]w :silent Neomake<CR>
nnoremap <c-p> :FZFTags<CR>
nnoremap \  `
nnoremap dh :diffget //3<CR>
nnoremap dl :diffget //2<CR>
nnoremap vaw viw
noremap <F12> <NOP>
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
onoremap <silent> } :<C-u>call ForwardParagraph()<CR>
silent! nnoremap < <<
" tmap <c-r> <c-u>`cat ~/.bash_history \| fzf`<CR>
vmap gcc <Plug>(caw:hatpos:toggle)
vnoremap ; <Esc>
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>
vnoremap vaw viw
vnoremap dp :'<,'>diffput<CR>:diffupdate<CR>
vnoremap do :'<,'>diffget<CR>:diffupdate<CR>
xmap  <Space>   [Space]
xmap <Enter> <Plug>(EasyAlign)
xmap A  <Plug>(niceblock-A)
xmap I  <Plug>(niceblock-I)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)
xmap p <Plug>(operator-replace)
xnoremap  [Space]   <Nop>
xnoremap ,  <Nop>
xnoremap ;  <Nop>
xnoremap < <gv
xnoremap <S-TAB>  <
xnoremap <SID>(command-line-enter) q:
xnoremap <TAB>  >
xnoremap <silent> } <Esc>:<C-u>call ForwardParagraph()<CR>mzgv`z
xnoremap > >gv
xnoremap m  <Nop>
xnoremap r <C-v> " Select rectangle.
xnoremap v $h

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
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:choosewin_blink_on_land = 0
let g:choosewin_overlay_clear_multibyte = 1
let g:localvimrc_whitelist='.*'
let g:localvimrc_sandbox=0
let g:choosewin_overlay_enable = 1
let g:formatters_javascript = ['jscs']
let g:haddock_browser = 'qutebrowser'
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:intero_stack_yaml='stack.yaml'
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:jsx_ext_required = 0
let g:livepreview_previewer = 'zathura'
let g:maplocalleader = 'm' " Use <LocalLeader> in filetype plugin.
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'vim']
let g:myLang=0
let g:myLangList=['nospell','en_us', 'nb', 'weak']
let g:neomake_haskell_enabled_makers = ['hlint']
let g:neomake_javascript_enabled_makers=['eslint', 'jscs']
let g:neomake_list_height = 5
let g:neomake_open_list = 2
let g:neomake_python_enabled_makers=['pylint']
let g:neomake_tex_enabled_makers = ['chktex']
let g:neosnippet#snippets_directory=expand($XDG_CONFIG_HOME) . '/nvim/snippets'
let g:python_highlight_all = 1
let g:vimsyntax_noerror = 1
let s:my_split = {'is_selectable': 1}

command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Utf16 edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? Utf16be edit<bang> ++enc=ucs-2 <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>

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
  \ 'source':  'fd -H -a --type file --color never . ${HOME}/dotfiles/ ${HOME}/all-things-phd',
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

function! s:check_back_space() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~? '\s'
endfunction

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

function! s:set_syntax_of_user_defined_commands()
  redir => l:commandout
  silent! command
  redir END

  let l:command_names = join(map(split(l:commandout, '\n')[1:],
        \ "matchstr(v:val, '[!\"b]*\\s\\+\\zs\\u\\w*\\ze')"))

  if l:command_names ==? '' | return | endif

  execute 'syntax keyword vimCommand ' . l:command_names
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

function! ToggleColorScheme()
  if exists('g:syntax_on')
    syntax off
  else
    syntax enable

    call s:ApplyCustomColorScheme()
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

function! ForwardParagraph()
  let l:cnt = v:count ? v:count : 1
  let l:i = 0
  while l:i < l:cnt
    if !search('^\s*\n.*\S','W')
      normal! G$
      return
    endif
    let l:i = l:i + 1
  endwhile
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

function! s:smart_search_expr(expr1, expr2)
  return line('$') > 5000 ?  a:expr1 : a:expr2
endfunction

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

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R --force-language=java')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, '':S'')')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index ' .
  \            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all ',
  \ 'down':    '30%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! FZFTags call s:tags()

" Show which highlight group is active under cursor (doesn't work with SpecialKey)
" (see also :so $VIMRUNTIME/syntax/hitest.vim)
function! <SID>SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, ''name'')')
endfunc

function! <SID>ToggleShowListChars()
  redir => l:listchars
  silent set listchars
  redir end
  if l:listchars =~# '.*trail.*'
    set listchars=tab:▸\ ,extends:»,precedes:«,nbsp:%
  else
    setlocal listchars+=trail:»,space:␣,eol:┌
  endif
endfunc

function! s:ApplyCustomColorScheme()
  if g:default_colorscheme ==# 'mayansmoke'
    highlight Comment ctermfg=27
    highlight Conceal ctermfg=019 ctermbg=255
    highlight SpecialKey ctermfg=247 ctermbg=255
    highlight Search term=bold ctermfg=015 ctermbg=134
  endif
endfunction

let &titlestring="
  \ %{expand('%:p:.:~')}%(%m%r%w%)
  \ %<\(%{".s:SID_PREFIX()."strwidthpart(fnamemodify(getcwd(), ':~'),
  \ &columns-len(expand('%:p:.:~')))}\) - VIM"
let &statusline=' '
  \ . "%{(&previewwindow?'[preview] ':'').expand('%')}"
  \ . " [%{gitbranch#name()}]\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
  \ . "%{printf(' %4d/%d',line('.'),line('$'))} %c"

call s:ApplyCustomColorScheme()

" ctrl-v
vnoremap <C-C> "+y
map <C-v> p
cmap <C-v> <C-R>+
imap <C-v> <C-r>"
noremap <c-Q> <C-V>

set runtimepath+=/opt/coc.nvim         
                                       
inoremap <silent><expr> <TAB>          
      \ pumvisible() ? "\<C-n>" :      
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()                  
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

nmap <silent> <F3> <Plug>(coc-definition)
nmap <silent> <F4> <Plug>(coc-type-definition)
nmap <silent> <c-G> <Plug>(coc-implementation)
nmap <silent> <c-H> <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype ==? 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <a-r> <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <F2>  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
