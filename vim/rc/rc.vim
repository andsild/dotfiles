" Shougo's .vimrc
" modified slighly by Anders Sildnes - great respect to Shougo!

" needed for syntax and colorscheme
let g:install_path = '/home/andesil/dotfiles/vim/'
exe 'set runtimepath+=' . expand(g:install_path)

if &compatible
  set nocompatible
endif

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_sudo = $SUDO_USER !=# '' && $USER !=# $SUDO_USER
      \ && $HOME !=# expand('~'.$USER)
      \ && $HOME ==# expand('~'.$SUDO_USER)

function! IsWindows()
  return s:is_windows
endfunction

function! IsMac()
  return !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))
endfunction

"---------------------------------------------------------------------------
" Initialize:
"

if exists('&regexpengine')
  " Use old regexp engine.
  " set regexpengine=1
endif

let g:mapleader = ','
let g:maplocalleader = 'm' " Use <LocalLeader> in filetype plugin.

" Release keymappings for plug-in.
nnoremap ;  <Nop>
xnoremap ;  <Nop>
xnoremap m  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>


if IsWindows()
  " Exchange path separator.
  set shellslash
endif

let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

if has('vim_starting') "{{{
  " Set runtimepath.
  if IsWindows()
    let &runtimepath = join([
          \ expand('$VIM/runtime'),
    ])
  endif

  " Load neobundle.
  let s:neobundle_dir = finddir('neobundle.vim', '.;')
  if s:neobundle_dir != ''
    execute 'set runtimepath^=' .
          \ fnamemodify(s:neobundle_dir, ':p')
  elseif &runtimepath !~ '/neobundle.vim'
    let s:neobundle_dir = expand('$CACHE/neobundle').'/neobundle.vim'

    if !isdirectory(s:neobundle_dir)
      execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
            \ (exists('$http_proxy') ? 'https' : 'git'))
            \ s:neobundle_dir
    endif

    execute 'set runtimepath^=' . s:neobundle_dir
  endif
endif
"}}}

let g:neobundle#default_options = {}
" let g:neobundle#default_options._ = { 'verbose' : 1, 'focus' : 1 }

"---------------------------------------------------------------------------
" Disable GetLatestVimPlugin.vim
if !&verbose
  let g:loaded_getscriptPlugin = 1
endif
" Disable netrw.vim
let g:loaded_netrwPlugin = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1


call neobundle#begin(expand('$CACHE/neobundle'))
if neobundle#load_cache()
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#load_toml(
        \ g:install_path . 'rc/neobundle.toml', {'lazy' : 0})
  NeoBundleSaveCache
endif

let s:vimrc_local = findfile('vimrc_local.vim', '.;')
if s:vimrc_local !=# ''
  " Load develop version.
  call neobundle#local(fnamemodify(s:vimrc_local, ':h'),
        \ {}, ['vim*', 'unite-*', 'neco-*', '*.vim', '*.nvim'])
endif

" NeoBundle configurations.

call neobundle#end()

filetype plugin indent on

" Enable syntax color.
syntax enable

if !has('vim_starting')
  NeoBundleCheck
endif


if has('vim_starting')
  set encoding=utf-8
  " Setting of terminal encoding."
  set termencoding=utf-8
endif


" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
if IsWindows()
    set fileformats=dos
    set fileformat=dos
endif

" Command group opening with a specific character code again."{{{
" In particular effective when I am garbled in a terminal.
" Open in UTF-8 again.
command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
" Open in UTF-16 again.
command! -bang -bar -complete=file -nargs=? Utf16 edit<bang> ++enc=ucs-2le <args>
" Open in UTF-16BE again.
command! -bang -bar -complete=file -nargs=? Utf16be edit<bang> ++enc=ucs-2 <args>

" Aliases.
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>
"}}}

" Tried to make a file note version."{{{
" Don't save it because dangerous.
command! WUtf8 setlocal fenc=utf-8
" Aliases.
command! WUnicode WUtf16
"}}}

" Appoint a line feed."
command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

set ignorecase " Ignore the case of normal letters.
set nosmartcase " not good with dragon naturally speaking
set incsearch " Enable incremental search.
set nohlsearch " Don't highlight search result.
set wrapscan " Searches wrap around the end of the file.

"---------------------------------------------------------------------------
" Edit:
"


set smarttab " Smart insert tab setting.
set expandtab " Exchange tab to spaces.
set tabstop=4 " Substitute <Tab> with blanks.
set softtabstop=4 " Spaces instead <Tab>.
set shiftround
set shiftwidth=4 " Round indent by shiftwidth.
set modeline " Enable modeline.

set clipboard& clipboard+=unnamed

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

set showmatch " Highlight parenthesis.
set cpoptions-=m " Highlight when CursorMoved.
set matchtime=3
set matchpairs+=<:> " Highlight <>.
set hidden " Display another buffer when current buffer isn't saved.
set autoread " Auto reload if file is changed.
set infercase " Ignore case on insert completion.
set foldenable " Enable folding.
set foldmethod=indent
set foldcolumn=0 " Show folding level.
set foldlevel=99 " Auto unfold all
set fillchars=vert:\|
set commentstring=%s

set grepprg=grep\ -inH " Use grep.
set isfname-== " Exclude = from isfilename.
set timeout timeoutlen=3000 ttimeoutlen=100 " Keymapping timeout.
set updatetime=1000 " CursorHold time.
set directory-=. " Set swap directory.
set noswapfile

set undofile
let &undodir=&directory
set virtualedit=block " Enable virtualedit in visual block mode.
set keywordprg=:help " Set keyword help.
autocmd MyAutoCmd WinEnter * checktime " Check timestamp more for 'autoread'.

autocmd MyAutoCmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif


autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif " Update diff.

autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force)
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

let g:myLang=0
let g:myLangList=["nospell","en_us", "nb"]
function! ToggleSpell()
  let b:myLang=g:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
  endif
  echo "spell checking language:" g:myLangList[b:myLang]
endfunction

nmap <silent> <F7> :call ToggleSpell()<CR>


" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:wcswidth(str)
  if a:str =~# '^[\x00-\x7f]*$'
    return strlen(a:str)
  end

  let mx_first = '^\(.\)'
  let str = a:str
  let width = 0
  while 1
    let ucs = char2nr(substitute(str, mx_first, '\1', ''))
    if ucs == 0
      break
    endif
    let width += s:_wcwidth(ucs)
    let str = substitute(str, mx_first, '', '')
  endwhile
  return width
endfunction

" UTF-8 only.
function! s:_wcwidth(ucs)
  let ucs = a:ucs
  if (ucs >= 0x1100
        \  && (ucs <= 0x115f
        \  || ucs == 0x2329
        \  || ucs == 0x232a
        \  || (ucs >= 0x2e80 && ucs <= 0xa4cf
        \      && ucs != 0x303f)
        \  || (ucs >= 0xac00 && ucs <= 0xd7a3)
        \  || (ucs >= 0xf900 && ucs <= 0xfaff)
        \  || (ucs >= 0xfe30 && ucs <= 0xfe6f)
        \  || (ucs >= 0xff00 && ucs <= 0xff60)
        \  || (ucs >= 0xffe0 && ucs <= 0xffe6)
        \  || (ucs >= 0x20000 && ucs <= 0x2fffd)
        \  || (ucs >= 0x30000 && ucs <= 0x3fffd)
        \  ))
    return 2
  endif
  return 1
endfunction
"---------------------------------------------------------------------------
" FileType:
"

" Enable smart indent.
set autoindent smartindent

autocmd FileType c,cpp set formatprg=astyle
augroup MyAutoCmd
  autocmd FileType,Syntax,BufEnter,BufWinEnter * call s:my_on_filetype()

  " Enable gauche syntax.
  autocmd FileType scheme nested let b:is_gauche=1 | setlocal lispwords=define |
        \let b:current_syntax='' | syntax enable

  " Auto reload VimScript.
  autocmd BufWritePost,FileWritePost *.vim if &autoread
        \ | source <afile> | echo 'source ' . bufname('%') | endif

  " Manage long Rakefile easily
  autocmd BufNewfile,BufRead Rakefile set foldmethod=syntax foldnestmax=1

  autocmd FileType gitcommit,qfreplace setlocal nofoldenable

  " autocmd FileType ref nnoremap <buffer> <TAB> <C-w>w

  " Enable omni completion.
  " autocmd FileType ada setlocal omnifunc=adacomplete#Complete
  " autocmd FileType c setlocal omnifunc=ccomplete#Complete
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  if has('python3')
    autocmd FileType python setlocal omnifunc=python3complete#Complete
  else
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  endif
  "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  "autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  autocmd FileType python setlocal foldmethod=indent
  autocmd FileType python setlocal formatprg=autopep8\ --aggressive\ --ignore=E309\ -
  " autocmd FileType vim setlocal foldmethod=syntax

  " Update filetype.
  autocmd BufWritePost *
  \ if &l:filetype ==# '' || exists('b:ftdetect')
  \ |   unlet! b:ftdetect
  \ |   filetype detect
  \ | endif

  " Improved include pattern.
  autocmd FileType html
        \ setlocal includeexpr=substitute(v:fname,'^\\/','','') |
        \ setlocal path+=./;/
  autocmd FileType php setlocal path+=/usr/local/share/pear
  autocmd FileType apache setlocal path+=./;/

  " autocmd FileType c set path=$PWD/**
  " autocmd FileType cpp set path=$PWD/**

  autocmd FileType go highlight default link goErr WarningMsg |
        \ match goErr /\<err\>/

  " autocmd Syntax * syntax sync minlines=100
augroup END

" PHP
let g:php_folding = 0

" Python
let g:python_highlight_all = 1

" XML
let g:xml_syntax_folding = 1

" Vim
let g:vimsyntax_noerror = 1
"let g:vim_indent_cont = 0

" Bash
let g:is_bash = 1

" Java
let g:java_highlight_functions = 'style'
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1
let g:java_highlight_functions=1

" JavaScript
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" Markdown
let g:markdown_fenced_languages = []

" Go
if $GOROOT != ''
  set runtimepath+=$GOROOT/misc/vim
endif

" Vim script
" augroup: a
" function: f
" lua: l
" perl: p
" ruby: r
" python: P
" tcl: t
" mzscheme: m
let g:vimsyn_folding = 'af'

" http://mattn.kaoriya.net/software/vim/20140523124903.htm
let g:markdown_fenced_languages = [
      \  'coffee',
      \  'css',
      \  'erb=eruby',
      \  'javascript',
      \  'js=javascript',
      \  'json=javascript',
      \  'ruby',
      \  'sass',
      \  'xml',
      \  'vim',
      \]

" Syntax highlight for user commands.
augroup syntax-highlight-extends
  autocmd!
  autocmd Syntax vim
        \ call s:set_syntax_of_user_defined_commands()
augroup END

function! s:set_syntax_of_user_defined_commands() "{{{
  redir => _
  silent! command
  redir END

  let command_names = join(map(split(_, '\n')[1:],
        \ "matchstr(v:val, '[!\"b]*\\s\\+\\zs\\u\\w*\\ze')"))

  if command_names == '' | return | endif

  execute 'syntax keyword vimCommand ' . command_names
endfunction"}}}

function! s:my_on_filetype() "{{{
  " Disable automatically insert comment.
  setl formatoptions-=ro | setl formatoptions+=mMBl

  " Disable auto wrap.
  if &l:textwidth != 70 && &filetype !=# 'help'
    setlocal textwidth=0
  endif

  " Use FoldCCtext().
  if &filetype !=# 'help'
    setlocal foldtext=FoldCCtext()
  endif

  if !&l:modifiable
    setlocal nofoldenable
    setlocal foldcolumn=0
    silent! IndentLinesDisable
  endif
endfunction "}}}

autocmd BufReadPost fugitive://* set bufhidden=delete

" Do not display completion messages
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
set noshowmode
try
  set shortmess+=c
catch /^Vim\%((\a\+)\)\=:E539: Illegal character/
  autocmd MyAutoCmd VimEnter *
        \ highlight ModeMsg guifg=bg guibg=bg |
        \ highlight Question guifg=bg guibg=bg
endtry
"---------------------------------------------------------------------------
" Key-mappings:
"

" Use <C-Space>.
nmap <C-Space>  :term<CR>
cmap <C-Space>  :term<CR>

"Visual mode keymappings: "{{{
"<TAB>: indent.
xnoremap <TAB>  >
"<S-TAB>: unindent.
xnoremap <S-TAB>  <

" Indent
nnoremap > >>
silent! nnoremap < <<
xnoremap > >gv
xnoremap < <gv

if has('clipboard')
  xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
endif

" Insert mode keymappings: "{{{
" <C-d>: delete char.
inoremap <C-d>  <Del>
" <C-a>: move to head.
" Enable undo <C-w> and <C-u>.
inoremap <C-w>  <C-g>u<C-w>
inoremap <C-u>  <C-g>u<C-u>

if has('gui_running')
  inoremap <ESC> <ESC>
endif

" H, D: delete camlcasemotion.
" inoremap <expr>H           <SID>camelcase_delete(0)
" inoremap <expr>D           <SID>camelcase_delete(1)
function! s:camelcase_delete(is_reverse)
  let save_ve = &l:virtualedit
  setlocal virtualedit=all
  if a:is_reverse
    let cur_text = getline('.')[virtcol('.')-1 : ]
  else
    let cur_text = getline('.')[: virtcol('.')-2]
  endif
  let &l:virtualedit = save_ve

  let pattern = '\d\+\|\u\+\ze\%(\u\l\|\d\)\|' .
        \'\u\l\+\|\%(\a\|\d\)\+\ze_\|\%(\k\@!\S\)\+' .
        \'\|\%(_\@!\k\)\+\>\|[_]\|\s\+'

  if a:is_reverse
    let cur_cnt = len(matchstr(cur_text, '^\%('.pattern.'\)'))
  else
    let cur_cnt = len(matchstr(cur_text, '\%('.pattern.'\)$'))
  endif

  let del = a:is_reverse ? "\<Del>" : "\<BS>"

  return (pumvisible() ?
        \ neocomplcache#smart_close_popup() : '') . repeat(del, cur_cnt)
endfunction

" Command-line mode keymappings:"{{{
" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>
" <C-k>, K: delete to end.
" cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
"       \ '' : getcmdline()[:getcmdpos()-2]<CR>
" <C-y>: paste.
cnoremap <C-y>          <C-r>*

cmap <C-o>          <Plug>(unite_cmdmatch_complete)
"}}}

"Command line buffer.
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>

"nmap ;;  <SID>(command-line-enter)
"xmap ;;  <SID>(command-line-enter)

autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
autocmd MyAutoCmd CmdwinLeave * let g:neocomplcache_enable_auto_select = 1

function! s:init_cmdwin()
  let g:neocomplcache_enable_auto_select = 0
  let b:neocomplcache_sources_list = ['vim_complete']

  " nnoremap <buffer><silent> q :<C-u>quit<CR>
  " nnoremap <buffer><silent> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> neocomplete#close_popup()."\<CR>"
  inoremap <buffer><expr><C-h> col('.') == 1 ?
        \ "\<ESC>:quit\<CR>" : neocomplete#cancel_popup()."\<C-h>"
  inoremap <buffer><expr><BS> col('.') == 1 ?
        \ "\<ESC>:quit\<CR>" : neocomplete#cancel_popup()."\<C-h>"

  " Completion.
  inoremap <buffer><expr><TAB>  pumvisible() ?
        \ "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-x>\<C-u>\<C-p>"

  " Remove history lines.
  silent execute printf("1,%ddelete _", min([&history - 20, line("$") - 20]))
  call cursor(line('$'), 0)

  startinsert!
endfunction"}}}

" [Space]: Other useful commands "{{{
" Smart space mapping.
" Notice: when starting other <Space> mappings in noremap, disappeared [Space].
nmap  <Space>   [Space]
xmap  <Space>   [Space]
nnoremap  [Space]   <Nop>
xnoremap  [Space]   <Nop>

" Toggle relativenumber.
nnoremap <silent> <Leader>.
      \ :<C-u>call ToggleOption('number')<CR>

nnoremap ;t :tabe<CR>
nnoremap ;v :vsplit<CR>
nnoremap ;s :split<CR>
nnoremap ;n :call SplitVim()<CR>
function! SplitVim()
    let x = getpos('.')
    if IsWindows()
        silent exe ' ! powershell.exe " gvim ' . expand("%:p") . ' +' . x[1] .
                    \ ' -c ''cd ' . getcwd() .
                    \ ' | normal 0 ' . x[2] . 'lzz '' " '
    else
        silent exe ' !setsid gvim ' . expand("%:p") . ' +' . x[1] .
                    \ ' -c "cd ' . getcwd() .
                    \ ' | normal 0 ' . x[2] . 'lzz " '
    endif

endfunction

nnoremap [Space]h
    \ :Unite history/unite <CR>

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nnoremap <silent> [Space]q
      \ :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> [Space]l
      \ :call ToggleList("Location List", 'l')<CR>
" Toggle cursorline.
nnoremap <silent> <Leader>cl
      \ :<C-u>call ToggleOption('cursorline')<CR>

function! ToggleColorScheme()
  if exists("g:syntax_on")
    syntax off
  else
    colorscheme peskcolor
    syntax enable
  endif
endfunction

" Toggle  colorscheme
nnoremap <silent> <Leader>cs
      \ :silent call ToggleColorScheme()<CR>
" Set autoread.
nnoremap [Space]ar
      \ :<C-u>setlocal autoread<CR>
" Output encoding information.
nnoremap <silent> [Space]en
      \ :<C-u>setl]spocal encoding? termencoding? fenc? fencs?<CR>
" Set spell check.
nnoremap ,sp
      \ :<C-u>call ToggleOption('spell')<CR>
nnoremap <Leader>w
      \ :<C-u>call ToggleOption('wrap')<CR>
nnoremap [Space]w :w<CR>

" Delete windows ^M codes.
nnoremap <silent> <Leader><C-m> mmHmt:<C-u>%s/\r$//ge<CR>'tzt'm:echo 'Took away c-m'<CR>

" Delete spaces before newline.
" nnoremap <silent> <Leader>ss mmHmt:<C-u>%s/<Space>$//ge<CR>`tzt`m

"Clear excess whitespace. mm is to center back to original pos
nnoremap <silent> <Leader>ss mm:%s/\s\+$//g<CR>`mmmzzmm


" Easily syntax change.
nnoremap <silent> [Space]ft :<C-u>Unite -start-insert filetype<CR>


" s: Windows and buffers(High priority) "{{{
" The prefix key.
nnoremap    [Window]   <Nop>
nmap    s [Window]
nnoremap <silent> ;o  :<C-u>only<CR>

function! s:smart_close()
  if winnr('$') != 1
    close
  else
    call s:alternate_buffer()
  endif
endfunction

function! s:NextWindow()
  if winnr('$') == 1
    silent! normal! ``z.
  else
    wincmd w
  endif
endfunction

function! s:NextWindowOrTab()
  if tabpagenr('$') == 1 && winnr('$') == 1
    call s:split_nicely()
  elseif winnr() < winnr("$")
    wincmd w
  else
    tabnext
    1wincmd w
  endif
endfunction

function! s:PreviousWindowOrTab()
  if winnr() > 1
    wincmd W
  else
    tabprevious
    execute winnr("$") . "wincmd w"
  endif
endfunction

" Force delete current buffer.
function! s:CustomBufferDelete(is_force)
  let current = bufnr('%')

  call s:alternate_buffer()

  if a:is_force
    silent! execute 'bdelete! ' . current
  else
    silent! execute 'bdelete ' . current
  endif
endfunction
function! s:alternate_buffer() "{{{
  let listed_buffer_len = len(filter(range(1, bufnr('$')),
        \ 's:buflisted(v:val) && getbufvar(v:val, "&filetype") !=# "unite"'))
  if listed_buffer_len <= 1
    enew
    return
  endif

  let cnt = 0
  let pos = 1
  let current = 0
  while pos <= bufnr('$')
    if s:buflisted(pos)
      if pos == bufnr('%')
        let current = cnt
      endif

      let cnt += 1
    endif

    let pos += 1
  endwhile

  if current > cnt / 2
    bprevious
  else
    bnext
  endif
endfunction"}}}
function! s:buflisted(bufnr) "{{{
  return exists('t:unite_buffer_dictionary') ?
        \ has_key(t:unite_buffer_dictionary, a:bufnr) && buflisted(a:bufnr) :
        \ buflisted(a:bufnr)
endfunction"}}}

" JunkFile
" nnoremap <silent> [Window]e  :<C-u>JunkfileOpen<CR>
nnoremap <silent> [Window]e  :<C-u>Unite junkfile/new junkfile -start-insert<CR>
command! -nargs=0 JunkfileDiary call junkfile#open_immediately(
      \ strftime('%Y-%m-%d.md'))
"}}}



nnoremap Q  q " Disable Ex-mode.


nnoremap [Quickfix]   <Nop> " q: Quickfix  "{{{

" Toggle quickfix window.
nnoremap <silent> [Quickfix]<Space>
      \ :<C-u>call <SID>toggle_quickfix_window()<CR>
function! s:toggle_quickfix_window()
  let _ = winnr('$')
  cclose
  if _ == winnr('$')
    copen
    setlocal nowrap
    setlocal whichwrap=b,s
  endif
endfunction
"}}}

" Jump mark can restore column."{{{
nnoremap \  `
" Useless command.
nnoremap M  m
"}}}

" Smart <C-f>, <C-b>.
nnoremap <silent> <C-f> <C-f>
nnoremap <silent> <C-b> <C-b>



" Like gv, but select the last changed text.
" nnoremap gc  `[v`]
" Specify the last changed text as {motion}.
" vnoremap <silent> gc  :<C-u>normal gc<CR>
" onoremap <silent> gc  :<C-u>normal gc<CR>

" Auto escape / and ? in search command.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

" Smart }."{{{
nnoremap <silent> } :<C-u>call ForwardParagraph()<CR>
onoremap <silent> } :<C-u>call ForwardParagraph()<CR>
xnoremap <silent> } <Esc>:<C-u>call ForwardParagraph()<CR>mzgv`z
function! ForwardParagraph()
  let cnt = v:count ? v:count : 1
  let i = 0
  while i < cnt
    if !search('^\s*\n.*\S','W')
      normal! G$
      return
    endif
    let i = i + 1
  endwhile
endfunction
"}}}

" Select rectangle.
xnoremap r <C-v>
" Select until end of current line in visual mode.
xnoremap v $h

" Paste next line.
nnoremap <silent> gp o<ESC>p^
nnoremap <silent> gP O<ESC>P^
xnoremap <silent> gp o<ESC>p^
xnoremap <silent> gP O<ESC>P^

" Redraw.
nnoremap <silent> <C-l>    :<C-u>redraw!<CR>

noremap [Space]u :<C-u>Unite outline:foldings<CR>

" Capitalize.
nnoremap gu gUiw`]

" operator-html-escape.vim
nmap <Leader>h <Plug>(operator-html-escape)
xmap <Leader>h <Plug>(operator-html-escape)

" Easily macro.
nnoremap @@ @a

" Improved increment.
nmap <C-a> <SID>(increment)
nmap <C-x> <SID>(decrement)
nnoremap <silent> <SID>(increment)    :AddNumbers 1<CR>
nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
command! -range -nargs=1 AddNumbers
      \ call s:add_numbers((<line2>-<line1>+1) * eval(<args>))
function! s:add_numbers(num)
  let prev_line = getline('.')[: col('.')-1]
  let next_line = getline('.')[col('.') :]
  let prev_num = matchstr(prev_line, '\d\+$')
  if prev_num != ''
    let next_num = matchstr(next_line, '^\d\+')
    let new_line = prev_line[: -len(prev_num)-1] .
          \ printf('%0'.len(prev_num . next_num).'d',
          \    max([0, prev_num . next_num + a:num])) . next_line[len(next_num):]
  else
    let new_line = prev_line . substitute(next_line, '\d\+',
          \ "\\=printf('%0'.len(submatch(0)).'d',
          \         max([0, submatch(0) + a:num]))", '')
  endif

  if getline('.') !=# new_line
    call setline('.', new_line)
  endif
endfunction

" Syntax check.
nnoremap <silent> [Window]y
      \ :<C-u>echo map(synstack(line('.'), col('.')),
      \     'synIDattr(v:val, "name")')<CR>

" Toggle options. "{{{
function! ToggleOption(option_name)
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction  "}}}
" Toggle variables. "{{{
function! ToggleVariable(variable_name)
  if eval(a:variable_name)
    execute 'let' a:variable_name.' = 0'
  else
    execute 'let' a:variable_name.' = 1'
  endif
  " echo printf('%s = %s', a:variable_name, eval(a:variable_name))
endfunction  "}}}


noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Right> <NOP>
nnoremap <Left> :10winc<<CR>
nnoremap <Right> :10winc><CR>
nnoremap <Up> :res +5<CR>
nnoremap <Down> :res -5<CR>
"" nnoremap <Up><Up> :qa<CR>
"" nnoremap <Down><Down> :qa!<CR>
""

nmap <F1> <nop>
map <F1> <Esc>
imap <F1> <Esc>
nnoremap <F1> <Esc>
"
nnoremap <C-o> <C-o>zz
nnoremap <Tab> <Tab>zz
nnoremap zj zjzz
nnoremap zk zkzz
nnoremap } }zz
nnoremap { {zz

" command W w
command! Q q
" command Wq wq
command! WQ wq
command! Wall wall
command! WAll wall

nnoremap <Leader>p "+p
" nnoremap <Leader>f :%s/^$/AB0\.1/g <bar> v/[0-9\-]\./d <bar> %s/AB0\.1//g <bar> %s/^\s\+//g <bar> %s/\v( ){1,10}/ /g <bar> %s/\s\+$//

vnoremap ; <Esc>


nnoremap <Leader>sc :SyntasticToggleMode<CR>

nnoremap <F9> :silent make <bar> redraw!<CR>


" Read pdf
if executable('pdftotext')
  command! -complete=file -nargs=1 Pdf call s:read_pdf(<q-args>)
  function! s:read_pdf(file)
    enew
    execute 'read !pdftotext -nopgbrk -layout' a:file '-'
    setlocal nomodifiable
    setlocal nomodified
  endfunction
endif

vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>
imap jj <Esc>
imap kk <Esc>

nnoremap ;d :<C-u>call <SID>CustomBufferDelete(1)<CR>

" For three-way diffs in fugitive
nnoremap dl :diffget //2<CR>
nnoremap dh :diffget //3<CR>

" 0 will go to beginning of line, ^ goes to first non-space. Much better.
map 0 ^

nnoremap <Esc><Esc> :noh<CR>
" <C-o> is to maintain the position
nnoremap * *<C-o>

" aw tends to include whitespace if the cursor is at the beginning, iw no
nnoremap vaw viw
vnoremap vaw viw


cmap w!! w !sudo tee > /dev/null %

inoremap kke kke
inoremap kk[Space] kk[Space]

:vnoremap s d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>

function! GentooCleanConfig()
    silent! :%s/^#.*//g
    silent! :%s/-\v(\d{1,2}(\.)?){1,4}(-r\d)?//g
    silent! :%s/>=//g
    silent! :g/^$/d
    :sort u<CR>
    :noh<CR>
endfunction

tnoremap jj <C-\><C-n>
tnoremap kk <C-\><C-n>
tnoremap <Esc><Esc> <C-\><C-n>

nnoremap [Space]o :FZFMru<CR>
noremap <c-t>  <Nop>
nnoremap <c-t> :FZFMru<CR>

"---------------------------------------------------------------------------
" Commands:
"

" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>
" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap

"---------------------------------------------------------------------------
" Platform:
"


" Using the mouse on a terminal.
if has('mouse')
  set mouse=a

  " Paste.
  nnoremap <RightMouse> "+p
  xnoremap <RightMouse> "+p
  inoremap <RightMouse> <C-r><C-o>+
  cnoremap <RightMouse> <C-r>+
endif

"---------------------------------------------------------------------------
" Others:
" Default home directory.
let t:cwd = getcwd()

set secure
set autoread

set tags=./tags,tags,../tags

"---------------------------------------------------------------------------
" For neovim:
"

tnoremap   <ESC><ESC>   <C-\><C-n>


"---------------------------------------------------------------------------
" Plugin:
"

" Let everything download - some plugins are heavy
let g:neobundle#install_process_timeout = 9999

" BufOnly.vim  -  Delete all the buffers except the current/named buffer.
"
" Copyright November 2003 by Christian J. Robinson <infynity@onewest.net>
"
" Distributed under the terms of the Vim license.  See ":help license".
"
" Usage:
"
" :Bonly / :BOnly / :Bufonly / :BufOnly [buffer]
"
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.

command! -nargs=? -complete=buffer -bang Bonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BOnly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bufonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BufOnly
    \ :call BufOnly('<args>', '<bang>')

function! BufOnly(buffer, bang)
    if a:buffer == ''
        " No buffer provided, use the current buffer.
        let buffer = bufnr('%')
    elseif (a:buffer + 0) > 0
        " A buffer number was provided.
        let buffer = bufnr(a:buffer + 0)
    else
        " A buffer name was provided.
        let buffer = bufnr(a:buffer)
    endif

    if buffer == -1
        echohl ErrorMsg
        echomsg "No matching buffer for" a:buffer
        echohl None
        return
    endif

    let last_buffer = bufnr('$')

    let delete_count = 0
    let n = 1
    while n <= last_buffer
        if n != buffer && buflisted(n)
            if a:bang == '' && getbufvar(n, '&modified')
                echohl ErrorMsg
                echomsg 'No write since last change for buffer'
                            \ n '(add ! to override)'
                echohl None
            else
                silent exe 'bdel' . a:bang . ' ' . n
                if ! buflisted(n)
                    let delete_count = delete_count+1
                endif
            endif
        endif
        let n = n+1
    endwhile

    if delete_count == 1
        echomsg delete_count "buffer deleted"
    elseif delete_count > 1
        echomsg delete_count "buffers deleted"
    endif

endfunction

" changelog.vim"{{{
autocmd MyAutoCmd BufNewFile,BufRead *.changelog setf changelog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "Shougo "
"}}}

" python.vim
let python_highlight_all = 1

" netrw.vim"{{{
let g:netrw_list_hide= '*.swp'
" Change default directory.
set browsedir=current
"}}}

if neobundle#tap('deoplete.nvim') && has('nvim') "{{{
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#auto_completion_start_length = 1

    inoremap <silent><expr> <s-Tab>
    \ pumvisible() ? "\<C-p>" :
    \ deoplete#mappings#manual_complete()
    inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ "\<TAB>"
    inoremap <expr>;
                \ pumvisible() ? deoplete#mappings#close_popup() :
                \ ";"

  call neobundle#untap()
endif "}}}

if neobundle#tap('neocomplete.vim') && has('lua') "{{{

  call neobundle#untap()
endif "}}}

if neobundle#tap('echodoc.vim') "{{{
  let g:echodoc_enable_at_startup = 1

  call neobundle#untap()
endif "}}}

if neobundle#tap('vinarise.vim') "{{{
  let g:vinarise_enable_auto_detect = 1

  call neobundle#untap()
endif "}}}

if neobundle#tap('unite.vim') "{{{
  " The prefix key.
  nnoremap    [unite]   <Nop>
  xnoremap    [unite]   <Nop>
  nmap    ;u [unite]
  xmap    ;u [unite]


  " nnoremap <silent> ;t
  "       \ :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
  nnoremap [Space]t
        \ :<C-u>Unite -start-insert tag tag/include<CR>
  nnoremap <silent> <C-k>
        \ :<C-u>Unite change jump<CR>
  nnoremap <silent> [Space]r
        \ :<C-u>Unite -buffer-name=register register history/yank<CR>

  " t: tags-and-searches
  " The prefix key.
  nnoremap    [Tag]   <Nop>
  nmap    t [Tag]
  " Jump.
  nnoremap [Tag]t  g<C-]>
  nnoremap <silent><expr> [Tag]t  &filetype == 'help' ?  "g\<C-]>" :
        \ ":\<C-u>UniteWithCursorWord -buffer-name=tag -immediately tag tag/include\<CR>"
  nnoremap <silent><expr> [Tag]p  &filetype == 'help' ?
        \ ":\<C-u>pop\<CR>" : ":\<C-u>Unite jump\<CR>"

  " Search.
  nnoremap <silent><expr> /
        \ ":\<C-u>Unite -buffer-name=search%".bufnr('%')." -start-insert line:forward:wrap\<CR>"
  " nnoremap <silent><expr> *
  "       \ ":\<C-u>UniteWithCursorWord -buffer-name=search%".bufnr('%')." line:forward:wrap\<CR>"
  cnoremap <expr><silent><C-g>        (getcmdtype() == '/') ?
        \ "\<ESC>:Unite -buffer-name=search line:forward:wrap -input=".getcmdline()."\<CR>" : "\<C-g>"

  function! s:smart_search_expr(expr1, expr2)
    return line('$') > 5000 ?  a:expr1 : a:expr2
  endfunction

  nnoremap <silent><expr> n
        \ ":\<C-u>UniteResume search%".bufnr('%')."
        \  -no-start-insert -force-redraw\<CR>"


  call unite#custom#profile('action', 'context', {
          \ 'start_insert' : 1
          \ })

    " migemo.
  call unite#custom#source('line_migemo', 'matchers', 'matcher_migemo')

    " Custom filters."{{{
  call unite#custom#source(
          \ 'buffer,file_rec,file_rec/async,file_rec/git', 'matchers',
          \ ['converter_relative_word', 'matcher_fuzzy',
          \  'matcher_project_ignore_files'])
    call unite#custom#source(
          \ 'file_mru', 'matchers',
          \ ['matcher_project_files', 'matcher_fuzzy',
          \  'matcher_hide_hidden_files', 'matcher_hide_current_file'])
    call unite#custom#source(
          \ 'file_rec,file_rec/async,file_rec/git,file_mru', 'converters',
          \ ['converter_file_directory'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    " call unite#filters#sorter_default#use(['sorter_length'])
    "}}}

    function! s:unite_my_settings() "{{{
      " Directory partial match.
      call unite#custom#alias('file', 'h', 'left')
      call unite#custom#default_action('directory', 'narrow')
      " call unite#custom#default_action('file', 'my_tabopen')

      call unite#custom#default_action('versions/git/status', 'commit')

      " call unite#custom#default_action('directory', 'cd')

      " Overwrite settings.
      imap <buffer>  <BS>      <Plug>(unite_delete_backward_path)
      imap <buffer>  jj        <Plug>(unite_insert_leave)
      imap <buffer>  <Tab>     <Plug>(unite_complete)
      imap <buffer> ;          <Plug>(unite_quick_match_default_action)
      nmap <buffer> ;          <Plug>(unite_quick_match_default_action)
      nmap <buffer> tcd         <Plug>(unite_quick_match_default_action)
      nmap <buffer> cd         <Plug>(unite_quick_match_default_action)
      nmap <buffer> <C-z>      <Plug>(unite_toggle_transpose_window)
      imap <buffer> <C-z>      <Plug>(unite_toggle_transpose_window)
      imap <buffer> <C-w>      <Plug>(unite_delete_backward_path)
      nmap <buffer> <C-j>      <Plug>(unite_toggle_auto_preview)
      "nnoremap <silent><buffer> <Tab>     <C-w>w
      nnoremap <silent><buffer><expr> l
        \ unite#smart_map('l', unite#do_action('default'))

      let unite = unite#get_current_unite()
      if unite.profile_name ==# '^search'
        nnoremap <silent><buffer><expr> r     unite#do_action('replace')
      else
        nnoremap <silent><buffer><expr> r     unite#do_action('rename')
      endif

      " nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
      nnoremap <silent><buffer><expr> !     unite#do_action('start')
      nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
        \ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
    endfunction"}}}

    " Default configuration.
    let default_context = {
          \ 'vertical' : 0,
          \ 'short_source_names' : 1,
          \ }

    " Variables.
    let g:unite_enable_split_vertically = 0
    let g:unite_winheight = 20
    let g:unite_enable_start_insert = 0
    let g:unite_enable_short_source_names = 1

    " let g:unite_abbr_highlight = 'TabLine'

    if IsWindows()
    else
      " Prompt choices.
      " let default_context.prompt = '» '
    endif

    call unite#custom#profile('default', 'context', default_context)

    if executable('ag')
      " Use ag in unite grep source.
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_default_opts =
        \ '-i --ignore-dir "*bin*" -U --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'' --ignore ''tags'' ' .
        \ '--ignore ''.trx'' --ignore ''.xml'' --ignore ''.tt'''
      let g:unite_source_grep_recursive_opt = ''
    endif

    let g:unite_build_error_icon    = '~/.vim/signs/err.'
          \ . (IsWindows() ? 'bmp' : 'png')
    let g:unite_build_warning_icon  = '~/.vim/signs/warn.'
          \ . (IsWindows() ? 'bmp' : 'png')

    let g:unite_source_rec_max_cache_files = -1

    " My custom split action
    let s:my_split = {'is_selectable': 1}
    function! s:my_split.func(candidate)
      let split_action = 'vsplit'
      if winwidth(winnr('#')) <= 2 * (&tw ? &tw : 80)
        let split_action = 'split'
      endif
      call unite#take_action(split_action, a:candidate)
    endfunction
    call unite#custom_action('openable', 'context_split', s:my_split)
    unlet s:my_split

    nnoremap <silent> [Space]n  :UniteNext<CR>
    nnoremap <silent> [Space]p  :UnitePrevious<CR>
    nnoremap <silent> [Space]r  :UniteResume<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('CamelCaseMotion') "{{{
  nmap <silent> W <Plug>CamelCaseMotion_w
  xmap <silent> W <Plug>CamelCaseMotion_w
  omap <silent> W <Plug>CamelCaseMotion_w
  nmap <silent> B <Plug>CamelCaseMotion_b
  xmap <silent> B <Plug>CamelCaseMotion_b
  omap <silent> B <Plug>CamelCaseMotion_b

  call neobundle#untap()
endif "}}}

if neobundle#tap('quickrun.vim') "{{{
  nmap <silent> <Leader>r <Plug>(quickrun)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-ref') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:ref_cache_dir = expand('$CACHE/ref')
    let g:ref_use_vimproc = 1
    if IsWindows()
      let g:ref_refe_encoding = 'cp932'
    endif

    " ref-lynx.
    if IsWindows()
      let lynx = 'C:/lynx/lynx.exe'
      let cfg  = 'C:/lynx/lynx.cfg'
      let g:ref_lynx_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
      let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump %s'
    endif

    let g:ref_lynx_use_cache = 1
    let g:ref_lynx_start_linenumber = 0 " Skip.
    let g:ref_lynx_hide_url_number = 0

    autocmd MyAutoCmd FileType ref call s:ref_my_settings()
    function! s:ref_my_settings() "{{{
      " Overwrite settings.
      " nmap <buffer> [Tag]t  <Plug>(ref-keyword)
      " nmap <buffer> [Tag]p  <Plug>(ref-back)
    endfunction"}}}
  endfunction

  call neobundle#untap()
endif"}}}

if neobundle#tap('vimfiler.vim') "{{{
  nnoremap <silent>   [Space]v   :<C-u>VimFiler -invisible<CR>
  nnoremap    [Space]fe   :<C-u>VimFilerExplorer<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('eskk.vim')
  imap <C-j>     <Plug>(eskk:toggle)

  call neobundle#untap()
endif "}}}

if neobundle#tap('J6uil.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:J6uil_config_dir = expand('$CACHE/J6uil')
    let g:J6uil_no_default_keymappings = 1
    let g:J6uil_display_offline  = 0
    let g:J6uil_display_online   = 0
    let g:J6uil_echo_presence    = 1
    let g:J6uil_display_icon     = 1
    let g:J6uil_display_interval = 0
    let g:J6uil_updatetime       = 1000
    let g:J6uil_align_message    = 0

    silent! delcommand NeoComplCacheCachingBuffer

    autocmd MyAutoCmd FileType J6uil call s:j6uil_settings()
    autocmd MyAutoCmd FileType J6uil_say call s:j6uil_say_settings()

    function! s:j6uil_settings()
      setlocal wrap
      setlocal nofoldenable
      setlocal foldcolumn=0
      nmap <buffer> o <Plug>(J6uil_open_say_buffer)
      nmap <silent> <buffer> <CR> <Plug>(J6uil_action_enter)
      call neocomplete#initialize()
      NeoCompleteBufferMakeCache
    endfunction

    function! s:j6uil_say_settings()
      setlocal wrap
      setlocal nofoldenable
      setlocal foldcolumn=0
    endfunction
  endfunction

  call neobundle#untap()
endif "}}}

"if filereadable("~/.cache/neobundle/tagbar/plugin/tagbar.vim")
"    source "~/.cache/neobundle/vim-operator-surround/plugin/operator/surround.vim"
"endif
"if filereadable("~/.cache/neobundle/vim-operator-surround/plugin/operator/surround.vim")
"    source "~/.cache/neobundle/vim-operator-surround/plugin/operator/surround.vim"
"endif
if neobundle#tap('tagbar')
    nmap <F8> :TagbarToggle<CR>
    call neobundle#untap()
endif

if neobundle#tap('vim-operator-surround') "{{{
  nmap <silent>sa <Plug>(operator-surround-append)a
  nmap <silent>sd <Plug>(operator-surround-delete)a
  nmap <silent>sr <Plug>(operator-surround-replace)a
  nmap <silent>sc <Plug>(operator-surround-replace)a

  call neobundle#untap()
endif "}}}

if neobundle#tap('qfreplace.vim') "{{{
  autocmd MyAutoCmd FileType qf nnoremap <buffer> r :<C-u>Qfreplace<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('open-browser.vim') "{{{
  nmap gs <Plug>(open-browser-wwwsearch)

  function! neobundle#hooks.on_source(bundle)
    nnoremap <Plug>(open-browser-wwwsearch)
          \ :<C-u>call <SID>www_search()<CR>
    function! s:www_search()
      let search_word = input('Please input search word: ')
      if search_word != ''
        execute 'OpenBrowserSearch' escape(search_word, '"')
      endif
    endfunction
  endfunction

  call neobundle#untap()
endif "}}}

"TODO: visual select, yank, paste and comment
" e.g. from
"
" var this = 0
"
" to (using a map like gcy or gcp)
"
" //var this = 0
" var this = 0
if neobundle#tap('caw.vim') "{{{
  autocmd MyAutoCmd FileType * call s:init_caw()
  function! s:init_caw()
    if !&l:modifiable
      silent! nunmap <buffer> gc
      " silent! xunmap <buffer> gc
      " silent! nunmap <buffer> gcc
      silent! xunmap <buffer> gcc
    else
      nmap <buffer> gc <Plug>(caw:prefix)
      xmap <buffer> gc <Plug>(caw:prefix)
      nmap <buffer> gcc <Plug>(caw:tildepos:toggle)
      xmap <buffer> gcc <Plug>(caw:tildepos:toggle)
    endif
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('accelerated-jk') "{{{
  nmap <silent>j <Plug>(accelerated_jk_gj)
  nmap gj j
  nmap <silent>k <Plug>(accelerated_jk_gk)
  nmap gk k

  call neobundle#untap()
endif "}}}

if neobundle#tap('concealedyank.vim') "{{{
  xmap Y <Plug>(operator-concealedyank)

  call neobundle#untap()
endif "}}}


if neobundle#tap('vim-choosewin') "{{{
  nmap <C-w>  <Plug>(choosewin)
  let g:choosewin_overlay_enable = 1
  let g:choosewin_overlay_clear_multibyte = 1
  let g:choosewin_blink_on_land = 0

  call neobundle#untap()
endif "}}}

if neobundle#tap('matchit.zip') "{{{
  function! neobundle#hooks.on_post_source(bundle)
    silent! execute 'doautocmd Filetype' &filetype
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-conque') "{{{
  let g:ConqueTerm_EscKey = '<Esc>'
  let g:ConqueTerm_PyVersion = 3

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-operator-replace') "{{{
  xmap p <Plug>(operator-replace)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-niceblock') "{{{
  xmap I  <Plug>(niceblock-I)
  xmap A  <Plug>(niceblock-A)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-fullscreen') "{{{
  nmap <C-CR> <Plug>(fullscreen-toggle)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-vimlint') "{{{
  let g:vimlint#config = { 'EVL103' : 1  }
  let g:vimlint#config.EVL102 = { 'l:_' : 1 }

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-textobj-user') "{{{
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  xmap ab <Plug>(textobj-multiblock-a)
  xmap ib <Plug>(textobj-multiblock-i)

  call neobundle#untap()
endif "}}}

if neobundle#tap('glowshi-ft.vim') "{{{
  let g:glowshi_ft_no_default_key_mappings = 1
  map f <Plug>(glowshi-ft-f)
  map F <Plug>(glowshi-ft-F)

  let g:glowshi_ft_timeoutlen = 1000
  let g:glowshi_ft_ignorecase = 1

  call neobundle#untap()
endif "}}}

if neobundle#tap('junkfile.vim') "{{{
  nnoremap <silent> [Window]e  :<C-u>Unite junkfile/new junkfile -start-insert<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-jplus') "{{{
  nmap J <Plug>(jplus)
  vmap J <Plug>(jplus)

  call neobundle#untap()
endif "}}}

if neobundle#tap('indentLine') "{{{
  let g:indentLine_faster = 1
  nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>
endif "}}}

if neobundle#tap('vim-easy-align') "{{{
  "vmap <Enter> is by default
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  xmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)
endif "}}}

if neobundle#tap('vim-themis') "{{{
  " Set to $PATH.
  let s:bin = neobundle#get('vim-themis').rtp . 'bin'
  let $PATH = neobundle#util#join_envpath(
        \ neobundle#util#uniq(insert(
        \    neobundle#util#split_envpath($PATH), s:bin)), $PATH, s:bin)
  let $THEMIS_HOME = neobundle#get('vim-themis').rtp
  unlet s:bin
endif "}}}

if neobundle#tap('gitgutter')
    let g:gitgutter_max_signs = 5000
    call neobundle#untap()
endif

if neobundle#tap('omnisharp-vim')
    NeoBundleSource ctrlp.vim

    let g:Omnisharp_start_server = 0
    let g:Omnisharp_stop_server = 0
    let g:omnicomplete_fetch_full_documentation = 1
    let g:OmniSharp_typeLookupInPreview = 1
    let g:OmniSharp_timeout = 100 " hit ctrl+c to abort it.
    " set noshowmatch
    autocmd BufEnter *.cs nnoremap K :OmniSharpDocumentation<CR>

    call neobundle#untap()
endif

if neobundle#tap('syntastic')
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_save = 1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    " let g:syntastic_check_on_wq = 0
    let g:syntastic_auto_jump = 2 " to error, but only if error
    let g:syntastic_quiet_messages = { "type": "style",
                                    \  "level": "warnings" }
    " syntastic is not intelligent enough to read references in c#,
    " generating errors when using 'semantic'
    let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
    " let g:syntastic_cs_checkers = ['syntax', 'issues']
    let g:syntastic_python_checkers = ['flake8'] " so much faster than pylint...
    let g:syntastic_python_flake8_args='--ignore=F401,F402,F403,F404,F811,F841,N8,E127,E2,E3,E5,E701,E702,E703,E704,E731,W1,W2,W3,W6'
    "
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    "
    call neobundle#untap()
endif

if neobundle#tap('dbext.vim')
    let g:dbext_default_type = 'SQLSRV'
    let g:dbext_default_profile_mySQLServer = 'Type=ODBC:Data Source=169.254.244.132;Initial Catalog=estate;User ID=sysco-estate;Password=iamnotputtingthisinmygit;Connect Timeout=120'
    call neobundle#untap()
endif

if neobundle#tap('vim-fugitive')
    call neobundle#untap()
endif

if neobundle#tap('vim-smalls')
    nmap f <Plug>(smalls)
    call neobundle#untap()
endif


if neobundle#tap('gitv')
    let g:Gitv_OpenHorizontal = 'auto'
    let g:Gitv_WipeAllOnClose = 1
    let g:Gitv_DoNotMapCtrlKey = 1

    call neobundle#untap()
endif

" rather, use deoplete and deoplete-jedi
if neobundle#tap('jedi-vim')
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#show_call_signatures = "1"
    let g:jedi#completions_enabled = 0
    let g:jedi#popup_select_first = 0 " dont pop up the first one
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#use_tabs_not_buffers = 0
    let g:jedi#goto_command             = ""
    let g:jedi#goto_assignments_command = ""
    let g:jedi#goto_definitions_command = ""
    let g:jedi#documentation_command    = ""
    let g:jedi#usages_command           = ""
    let g:jedi#completions_command      = ""
    let g:jedi#rename_command           = ""
    " autocmd FileType python setlocal completefunc=jedi#complete
    " autocmd FileType python setlocal omnifunc=jedi#completions
    call neobundle#untap()
endif

if neobundle#tap('ultisnips')
    let g:UltiSnipsExpandTrigger="<C-CR>"
    let g:UltiSnipsJumpForwardTrigger="<C-tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

    noremap <F12> <NOP>
    inoremap <silent> <c-s> <C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
    nnoremap <silent> <c-s> a<C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
    call neobundle#untap()
endif


if neobundle#tap('vim-latex-live-preview')
    let g:livepreview_previewer = 'evince'
    call neobundle#untap()
endif


function! FindCabalSandboxRoot()
    return finddir('.cabal-sandbox', './;')
endfunction

function! FindCabalSandboxRootPackageConf()
    return glob(FindCabalSandboxRoot().'/*-packages.conf.d')
endfunction
if neobundle#tap('neco-ghc')
    autocmd BufEnter *.hs setlocal omnifunc=necoghc#omnifunc

    let g:syntastic_haskell_hdevtools_args = '-g-ilib -g-isrc -g-i. -g-idist/build/autogen -g-Wall -g-package-conf='.FindCabalSandboxRootPackageConf()

    let g:necoghc_enable_detailed_browse=1
    call neobundle#untap()
endif

if neobundle#tap('haskellmode-vim')
    let g:haddock_browser = 'google-chrome-stable'
    au BufEnter *.hs compiler ghc
    call neobundle#untap()
endif

if neobundle#tap('vim-autoformat')
    nnoremap <silent> <Leader>au :Autoformat<CR>
    call neobundle#untap()
endif

if neobundle#tap('fzf')
    call neobundle#untap()
endif

if neobundle#tap('vim-clang')
    " disable auto completion for vim-clang
    let g:clang_auto = 0
    " default 'longest' can not work with neocomplete
    let g:clang_c_completeopt = 'menuone,preview'
    let g:clang_cpp_completeopt = 'menuone,preview'

    " use neocomplete
    " input patterns
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif

    " for c and c++
    let g:neocomplete#force_omni_input_patterns.c =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#force_omni_input_patterns.cpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    call neobundle#untap()
endif

if neobundle#tap('unite-preview')
    let g:vimfiler_preview_action = 'auto_preview'

    call neobundle#untap()
endif

if neobundle#tap('neomake')
    autocmd! BufWritePost * Neomake
    let g:neomake_open_list = 2
    let g:neomake_list_height = 5
    let g:neomake_tex_enabled_makers = ['chktex']
    let g:neomake_python_enabled_makers=['pylint']

    call neobundle#untap()
endif
autocmd FileType c let g:neomake_c_enabled_makers = []
autocmd FileType cpp let g:neomake_cpp_enabled_makers = []
autocmd FileType c nnoremap [Space]w :w \| Neomake!<CR>
autocmd FileType cpp nnoremap [Space]w :w \| Neomake!<CR>
autocmd FileType asm nnoremap [Space]w :w \| Neomake!<CR>
autocmd FileType yacc nnoremap [Space]w :w \| Neomake!<CR>
autocmd FileType lex nnoremap [Space]w :w \| Neomake!<CR>

autocmd FileType pdf Pdf '%'
autocmd FileType pdf :0


if neobundle#tap('vim-grepper')
    nnoremap [Space]/  :Grepper -tool ag  -open -switch<cr>

    call neobundle#untap()
endif


"---------------------------------------------------------------------------
" For UNIX:
"
set shell=bash

"---------------------------------------------------------------------------
" View:
"

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Show line number.
set nonumber
set relativenumber
" Show <TAB> and <CR>
set list
if IsWindows()
  set listchars=tab:>-,extends:>,precedes:<
else
  set listchars=tab:▸\ ,extends:»,precedes:«,nbsp:%

endif
" Do not wrap long line.
set wrap
" Wrap conditions.
set whichwrap+=h,l,<,>,[,],b,s,~
" Always display statusline.
set laststatus=2
" Height of command line.
set cmdheight=2
" Not show command on statusline.
set noshowcmd
" Show title.
set title
" Title length.
set titlelen=95
" Title string.
let &titlestring="
      \ %{expand('%:p:.:~')}%(%m%r%w%)
      \ %<\(%{".s:SID_PREFIX()."strwidthpart(
      \ fnamemodify(&filetype ==# 'vimfiler' ?
      \ substitute(b:vimfiler.current_dir, '.\\zs/$', '', '') : getcwd(), ':~'),
      \ &columns-len(expand('%:p:.:~')))}\) - VIM"

" Set tabline.
" function! s:my_tabline()  "{{{
"   let s = ''
"
"   for i in range(1, tabpagenr('$'))
"     " let bufnrs = tabpagebuflist(i)
"     " let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
"     "
"     " let no = i  " display 0-origin tabpagenr.
"     " let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
"     "
"     " " Use gettabvar().
"     " let title =
"     "       \ !exists('*gettabvar') ?
"     "       \      fnamemodify(bufname(bufnr), ':t') :
"     "       \ gettabvar(i, 'title') != '' ?
"     "       \      gettabvar(i, 'title') :
"     "       \      fnamemodify((i == tabpagenr() ?
"     "       \       getcwd() : gettabvar(i, 'cwd')), ':t')
"     "
"     " let title = '[' . title . ']'
"     "
"     " let s .= '%'.i.'T'
"     " let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
"     " let s .= title
"     " let s .= mod
"     " let s .= '%#TabLineFill#'
"   endfor
"
"   let s .= '%#TabLineFill#%T%=%#TabLine#'
"   return s
" endfunction "}}}
" let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

" Set statusline.
let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
      \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
      \ . "%{(&previewwindow?'[preview] ':'').expand('%:t:.')}"
      \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
      \ . "%{printf(' %4d/%d',line('.'),line('$'))} %c"

" Turn down a long line appointed in 'breakat'
set linebreak
set showbreak=>\
set breakat=\ \ ;:,!?

" Do not display greetings message at the time of Vim start.
set shortmess=aTI

" Don't create backup.
set nowritebackup
set nobackup
set noswapfile
set backupdir-=.

" Disable bell.
set t_vb=
set novisualbell

" Display candidate supplement.
set nowildmenu
set wildmode=list:longest,full
" Increase history amount.
set history=1000
" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag
" Can supplement a tag in a command-line.
set wildoptions=tagfile

" Disable menu
let g:did_install_default_menus = 1

if !&verbose
  " Enable spell check.
  set spelllang=en_us
  " Enable CJK support.
  set spelllang+=cjk
endif

" Completion setting.
" set completeopt=menuone
set completeopt=longest
" Don't complete from other buffer.
set complete=.
"set complete=.,w,b,i,t
" Set popup menu max height.
set pumheight=20

" Report changes.
set report=0

" Maintain a current line at the time of movement as much as possible.
set nostartofline

" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right the current one.
set splitright                                                                                               
" Set minimal width for current window.                                                                      
set winwidth=1                                                                                               
set winminheight=0 " the statusline will still show                                                          
set winminwidth=0 " the statusline will still show                                                           
" Set maximam maximam command line window.                                                                   
set cmdwinheight=5                                                                                           
set noequalalways " resize only happens when explicitly asked for

" Adjust window size of preview and help.
set previewheight=8
set helpheight=12

" Don't redraw while macro executing.
set lazyredraw
set ttyfast
                                  
" When a line is long, do not omit it in @.
set display=lastline                                                                                         
" Display an invisible letter with hex format.                                                               
"set display+=uhex                                                                                           
                                                                                                             
" View setting.                                                                                              
set viewdir=$CACHE/vim_view viewoptions-=options viewoptions+=slash,unix                                     
                                                                                                             
function! s:strwidthpart(str, width) "{{{                                
  if a:width <= 0                
    return ''                     
  endif                           
  let ret = a:str                 
  let width = s:wcswidth(a:str)   
  while width > a:width           
    let char = matchstr(ret, '.$')
    let ret = ret[: -1 - len(char)]
    let width -= s:wcswidth(char)
  endwhile

  return ret
endfunction"}}}

set conceallevel=2 concealcursor=iv
set colorcolumn=79

" Use builtin function.
function! s:wcswidth(str)
    return strwidth(a:str)
endfunction


"---------------------------------------------------------------------------
" For Windows:
"

" In Windows, can't find exe, when $PATH isn't contained $VIM.
if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

" Popup color.
hi Pmenu ctermbg=8
hi PmenuSel ctermbg=1
hi PmenuSbar ctermbg=0


if neobundle#tap("deoplete")
    let g:deoplete#enable_at_startup = 1
    set completeopt+=noinsert,noselect

    let g:deoplete#keyword_patterns = {}
    let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'

    let g:deoplete#sources#go = 'vim-go'

    " Movement within 'ins-completion-menu'
    imap <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
    imap <expr><C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"

    " Scroll pages in menu
    inoremap <expr><C-f> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<Right>"
    inoremap <expr><C-b> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<Left>"
    imap     <expr><C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
    imap     <expr><C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

    " Undo completion
    inoremap <expr><C-g> deoplete#mappings#undo_completion()
    call neobundle#untap()
endif


function! s:is_whitespace() "{{{
    let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~? '\s'
endfunction "}}}

        " vim: set ts=2 sw=2 tw=80 noet :

let g:eskk#directory = expand('$CACHE/eskk')

let g:eskk#large_dictionary = {
      \   'path': expand('$CACHE/SKK-JISYO.L'),
      \   'sorted': 1,
      \   'encoding': 'euc-jp',
      \}

" Server test
let g:eskk#server = {
      \   'host': 'localhost',
      \   'port': 55100,
      \   'type': 'notfound',
      \}

" Disable skk.vim
let g:plugin_skk_disable = 1

let g:eskk#debug = 0

" Don't keep state.
let g:eskk#keep_state = 0

let g:eskk#show_annotation = 1
let g:eskk#rom_input_style = 'msime'
let g:eskk#egg_like_newline = 1
let g:eskk#egg_like_newline_completion = 1
let g:eskk#tab_select_completion = 1
let g:eskk#start_completion_length = 2

" Disable mapping.
"let g:eskk#map_normal_keys = 0

" Toggle debug.
nnoremap <silent> [Space]ed  :<C-u>call ToggleVariable('g:eskk#debug')<CR>

autocmd MyAutoCmd User eskk-initialize-post
      \ EskkMap -remap jj <Plug>(eskk:disable)<Esc>

let g:eskk#dictionary = {
      \   'path': expand('$CACHE/skk-jisyo'),
      \   'sorted': 0,
      \   'encoding': 'utf-8',
      \}

" Define table.
autocmd MyAutoCmd User eskk-initialize-pre call s:eskk_initial_pre()
function! s:eskk_initial_pre() "{{{
  let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
  call t.add_map('z ', '　')
  call t.add_map('~', '〜')
  call t.add_map('zc', '©')
  call t.add_map('zr', '®')
  call t.add_map('z9', '（')
  call t.add_map('z0', '）')
  call eskk#register_mode_table('hira', t)
  unlet t
endfunction "}}}

command! FZFMru call fzf#run({
            \ 'source':  reverse(s:all_files()),
            \ 'sink':    'edit',
            \ 'options': '-m -x +s -e',
            \ 'down':    '40%' })

function! s:all_files()
      let fuckall = split(system('locate "${PWD}/" | sort'), '\n')
      let test = filter(copy(v:oldfiles),
        \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'")
      let omg = extend(test, fuckall)
      let lolzomg = extend(omg,
            \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
      return lolzomg
  endfunction


"---------------------------------------------------------------------------
"---------------------------------------------------------------------------
" vimfiler.vim
"

let g:vimfiler_enable_clipboard = 0
let g:vimfiler_safe_mode_by_default = 0

let g:vimfiler_as_default_explorer = 1
if IsWindows()
  let g:vimfiler_detect_drives = [
        \ 'C:/', 'D:/', 'E:/', 'F:/', 'G:/', 'H:/', 'I:/',
        \ 'J:/', 'K:/', 'L:/', 'M:/', 'N:/']
endif

" %p : full path
" %d : current directory
" %f : filename
" %F : filename removed extensions
" %* : filenames
" %# : filenames fullpath
let g:vimfiler_sendto = {
      \ 'unzip' : 'unzip %f',
      \ 'zip' : 'zip -r %F.zip %*',
      \ 'Inkscape' : 'inkspace',
      \ 'GIMP' : 'gimp %*',
      \ 'gedit' : 'gedit',
      \ }

if IsWindows()
  " Use trashbox.
  let g:unite_kind_file_use_trashbox = 1
else
  " Like Textmate icons.
  let g:vimfiler_tree_leaf_icon = ' '
  let g:vimfiler_tree_opened_icon = '▾'
  let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_file_icon = ' '
  let g:vimfiler_readonly_file_icon = '✗'
  let g:vimfiler_marked_file_icon = '✓'
endif
" let g:vimfiler_readonly_file_icon = '[O]'

let g:vimfiler_quick_look_command =
      \ IsWindows() ? 'maComfort.exe -ql' :
      \ IsMac() ? 'qlmanage -p' : 'gloobus-preview'

autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() "{{{
  call vimfiler#set_execute_file('vim', ['vim', 'notepad'])
  call vimfiler#set_execute_file('txt', 'vim')

  nnoremap <silent><buffer><expr> gy vimfiler#do_action('tabopen')
  nmap <buffer> p <Plug>(vimfiler_quick_look)
  " nmap <buffer> <Tab> <Plug>(vimfiler_switch_to_other_window)

  " Migemo search.
  if !empty(unite#get_filters('matcher_migemo'))
    nnoremap <silent><buffer><expr> /  line('$') > 10000 ?  'g/' :
          \ ":\<C-u>Unite -buffer-name=search -start-insert line_migemo\<CR>"
  endif

endfunction"}}}


"---------------------------------------------------------------------------
" unite.vim
"
" For unite-menu.
let g:unite_source_menu_menus = {}

let g:unite_source_menu_menus.enc = {
      \     'description' : 'Open with a specific character code again.',
      \ }
let g:unite_source_menu_menus.enc.command_candidates = [
      \       ['utf8', 'Utf8'],
      \       ['iso2022jp', 'Iso2022jp'],
      \       ['cp932', 'Cp932'],
      \       ['euc', 'Euc'],
      \       ['utf16', 'Utf16'],
      \       ['utf16-be', 'Utf16be'],
      \       ['jis', 'Jis'],
      \       ['sjis', 'Sjis'],
      \       ['unicode', 'Unicode'],
      \     ]

let g:unite_source_menu_menus.fenc = {
      \     'description' : 'Change file fenc option.',
      \ }
let g:unite_source_menu_menus.fenc.command_candidates = [
      \       ['utf8', 'WUtf8'],
      \       ['iso2022jp', 'WIso2022jp'],
      \       ['cp932', 'WCp932'],
      \       ['euc', 'WEuc'],
      \       ['utf16', 'WUtf16'],
      \       ['utf16-be', 'WUtf16be'],
      \       ['jis', 'WJis'],
      \       ['sjis', 'WSjis'],
      \       ['unicode', 'WUnicode'],
      \     ]

let g:unite_source_menu_menus.ff = {
      \     'description' : 'Change file format option.',
      \ }
let g:unite_source_menu_menus.ff.command_candidates = {
      \       'unix'   : 'WUnix',
      \       'dos'    : 'WDos',
      \       'mac'    : 'WMac',
      \     }

let g:unite_source_menu_menus.unite = {
      \     'description' : 'Start unite sources',
      \ }
let g:unite_source_menu_menus.unite.command_candidates = {
      \       'history'    : 'Unite history/command',
      \       'quickfix'   : 'Unite qflist -no-quit',
      \       'resume'     : 'Unite -buffer-name=resume resume',
      \       'directory'  : 'Unite -buffer-name=files '.
      \             '-default-action=lcd directory_mru',
      \       'mapping'    : 'Unite mapping',
      \       'message'    : 'Unite output:message',
      \       'scriptnames': 'Unite output:scriptnames',
      \     }

let g:unite_source_history_yank_enable = 1

" For unite-alias.
let g:unite_source_alias_aliases = {}
let g:unite_source_alias_aliases.test = {
      \ 'source' : 'file_rec',
      \ 'args'   : '~/',
      \ }
let g:unite_source_alias_aliases.line_migemo = 'line'
let g:unite_source_alias_aliases.calc = 'kawaii-calc'
let g:unite_source_alias_aliases.l = 'launcher'
let g:unite_source_alias_aliases.kill = 'process'
let g:unite_source_alias_aliases.message = {
      \ 'source' : 'output',
      \ 'args'   : 'message',
      \ }
let g:unite_source_alias_aliases.mes = {
      \ 'source' : 'output',
      \ 'args'   : 'message',
      \ }
let g:unite_source_alias_aliases.scriptnames = {
      \ 'source' : 'output',
      \ 'args'   : 'scriptnames',
      \ }

autocmd MyAutoCmd FileType unite call s:unite_my_settings()

let g:unite_ignore_source_files = []



if neobundle#tap('gitv')
    let g:unite_source_menu_menus.git = {
        \ 'description' : '            admin git repositories
            \                                [Space]g',
        \}
    let g:unite_source_menu_menus.git.command_candidates = [
        \['-> viewer             (gitv)                              W ,gv',
            \':Gitv --all'],
        \['-> viewer - buffer    (gitv)                              W ,gV',
            \':Gitv --all'],
        \['-> tig             (unite tig)                              W ,gv',
            \':Unite tig'],
        \['-> status             (fugitive)                          W ,gs',
            \'Gstatus'],
        \['-> diff               (fugitive)                          W ,gd',
            \'Gdiff'],
        \['-> commit             (fugitive)                          W ,gc',
            \'Gcommit'],
        \['-> log                (fugitive)                          W ,gl',
            \'exe "silent Glog | Unite -no-quit quickfix"'],
        \['-> log - all          (fugitive)                          W ,gL',
            \'exe "silent Glog -all | Unite -no-quit quickfix"'],
        \['-> blame              (fugitive)                          W ,gb',
            \'Gblame'],
        \['-> add/stage          (fugitive)                          W ,gw',
            \'Gwrite'],
        \['-> push               (fugitive, buffer output)           W ,gp',
            \'Git! push'],
        \['-> pull               (fugitive, buffer output)           W ,gP',
            \'Git! pull'],
        \['-> command            (fugitive, buffer output)           W ,gi',
            \'exe "Git! " input("comando git: ")'],
        \['-> edit               (fugitive)                          W ,gE',
            \'exe "command Gedit " input(":Gedit ")'],
        \['-> grep               (fugitive)                          W ,gg',
            \'exe "silent Ggrep -i ".input("Pattern: ") | Unite -no-quit quickfix'],
        \['-> grep - text        (fugitive)                          W ,ggt',
            \'exe "silent Glog -S".input("Pattern: ")." | Unite -no-quit quickfix"'],
        \['-> write               (fugitive)                          W ,gg',
            \'Gwrite'],
        \['-> github dashboard       (github-dashboard)                  W ,gD',
            \'exe "GHD! " input("Username: ")'],
        \['-> github activity        (github-dashboard)                  W ,gA',
            \'exe "GHA! " input("Username or repository: ")'],
        \]
    nnoremap <silent>[Space]g :Unite -silent -winheight=29 -start-insert menu:git<CR>

    call neobundle#untap()
endif


if neobundle#tap('Omnisharp')

        let g:unite_source_menu_menus.omnisharp = {
                \ 'description' : '            Omnisharp commands (intellisense)
                    \                                [Space]i',
            \}
        let g:unite_source_menu_menus.omnisharp.command_candidates = [
            \['-> Actions',
                \'OmniSharpGetCodeActions'],
            \['-> Build',
                \'OmniSharpBuildAsync'],
            \['-> Definition',
                \'OmniSharpGotoDefinition'],
            \['-> Format',
                \'OmniSharpCodeFormat'],
            \['-> Organize imports',
                \'OmniSharpFixUsings'],
            \['-> Symbol',
                \'OmniSharpFindSymbol'],
            \['-> Usages',
                \'OmniSharpFindUsages'],
            \['-> Rename',
                \'OmniSharpRename'],
            \['-> Tags (def/usage)',
                \'UniteWithCursorWord tag'],
            \['-> Tests',
                \'OmniSharpRunAllTests'],
            \['-> LastTests',
                \'OmniSharpRunLastTests'],
        \]
    call neobundle#untap()
endif


let g:unite_source_menu_menus.diff = {
        \ 'description' : '            Diff commands
            \                                [Space]d',
    \}
let g:unite_source_menu_menus.diff.command_candidates = [
    \['-> this',
        \'diffthis'],
    \['-> off',
        \'diffoff'],
    \['-> update',
        \'diffupdate'],
\]
nnoremap <silent> [Space]di :Unite menu:diff -silent -start-insert -winheight=10 <CR>


let g:unite_source_menu_menus.openfile = {
        \ 'description' : '            open a file
            \                                [Space]d',
    \}
let g:unite_source_menu_menus.openfile.command_candidates = [
    \['-> Files',
        \'Unite -start-insert file file/new buffer_tab'],
    \['-> Git files',
        \'Unite -start-insert file_rec/git'],
    \['-> Buffers',
        \'Unite -start-insert buffer'],
    \['-> MRU',
        \'Unite -start-insert file_mru'],
\]
nnoremap <silent> [Space]o :Unite -start-insert menu:openfile -silent -winheight=10 <CR>


if neobundle#tap('jedi-vim')
let g:unite_source_menu_menus.jedi = {
        \ 'description' : '            Python intellisense
            \                                [Space]i',
    \}
let g:unite_source_menu_menus.jedi.command_candidates = [
    \['-> Assingments',
        \'call jedi#goto_assignments()'],
   \['-> Call signture',
        \'call jedi#configure_call_signatures()'],
    \['-> Definition',
        \'call jedi#goto_definitions()'],
    \['-> Rename',
        \'call jedi#rename()'],
    \['-> Documentation',
        \'call jedi#show_documentation()'],
    \['-> Import',
        \'call jedi#py_import()'],
    \['-> Usages',
        \'call jedi#usages()'],
\]

    call neobundle#untap()
endif


au Bufenter *.cs nnoremap <silent> [Space]i :Unite menu:omnisharp -silent -winheight=25 -start-insert<CR>
au Bufenter *.py nnoremap <silent> [Space]i :Unite menu:jedi -silent -winheight=25 -start-insert<CR>
colorscheme peskcolor

inoremap <silent> <a-h> <Esc>:call WindowCmd("h")<CR>
inoremap <silent> <a-j> <Esc>:call WindowCmd("j")<CR>
inoremap <silent> <a-k> <Esc>:call WindowCmd("k")<CR>
inoremap <silent> <a-l> <Esc>:call WindowCmd("l")<CR>
vnoremap <silent> <a-h> <Esc>:call WindowCmd("h")<CR>
vnoremap <silent> <a-j> <Esc>:call WindowCmd("j")<CR>
vnoremap <silent> <a-k> <Esc>:call WindowCmd("k")<CR>
vnoremap <silent> <a-l> <Esc>:call WindowCmd("l")<CR>
tnoremap <silent> <a-h> <C-\><C-n>:call WindowCmd("h")<CR>
tnoremap <silent> <a-j> <C-\><C-n>:call WindowCmd("j")<CR>
tnoremap <silent> <a-k> <C-\><C-n>:call WindowCmd("k")<CR>
tnoremap <silent> <a-l> <C-\><C-n>:call WindowCmd("l")<CR>


"From unimpaired
nnoremap =P  <Nop>
nnoremap =p  <Nop>

if neobundle#tap('neoman.vim')

    call neobundle#untap()
endif


if neobundle#tap('finance.vim')
    let g:finance_watchlist = ['NZYM-B.CO']
    let g:finance_format = '{symbol}: {LastTradePriceOnly} ({Change})'
    let g:finance_separator = "\n"
    call neobundle#untap()
endif


tnoremap <C-6> <C-\><C-n><C-6>
