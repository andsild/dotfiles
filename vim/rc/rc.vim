" vimrc Anders Sildnes - great respect to Shougo, whom I based this vimrc from

" I have no idea on how to structurize this. Shougo separates everything in
" in different files. I found this annoying - I couldn't quickly edit my rc
" anymore, I had to find the right file and folder...

" Clustering rc-code  together based on alphabetical sorting or type would
" be neat, but it also destroys context. I want some mappings close to their
" plugin code, I want some options close to their functions, etc.
" Also, I typically want some "nmap" close to their "xmap" equivalent

" Also, commenting some code would make the rc file much easier to share 
" and review, but it adds a lot of noise. I prefer having
" lines without comments.  Any good vimmer should know to fix annoying 
" behaviour. A Google search should yield the necessary attributes...
" Yet I see difficulty in reading vimscript. But I dont what is best.

" TODO: EDIT THE PATH BEFORE USING THIS RC FILE (to your vim install path)
let g:install_path = '/home/andesil/dotfiles/vim/'

exe 'set runtimepath+=' . expand(g:install_path)

if &compatible
  set nocompatible
endif

function! IsWindows()
  return has('win16') || has('win32') || has('win64')
endfunction

let g:mapleader = ','
let g:maplocalleader = 'm' " Use <LocalLeader> in filetype plugin.

nnoremap ;  <Nop>
xnoremap ;  <Nop>
xnoremap m  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>

let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

augroup MyAutoCmd
  autocmd!
augroup END

if has('vim_starting') 
  set encoding=utf-8
  set termencoding=utf-8

    let s:dein_dir = finddir('dein.vim', '.;')
    if s:dein_dir !=? '' || &runtimepath !~# '/dein.vim'
    if s:dein_dir ==? '' && &runtimepath !~# '/dein.vim'
        let s:dein_dir = expand('$CACHE/dein')
            \. '/repos/github.com/Shougo/dein.vim'
        if !isdirectory(s:dein_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
        endif
    endif
    execute ' set runtimepath^=' . substitute(
            \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
    endif

    let g:dein#install_progress_type = 'title'
    let g:dein#install_message_type = 'none'
    let g:dein#enable_notification = 1

    let s:path = expand('$CACHE/dein')
    call dein#begin(s:path, [expand('<sfile>')]
        \ + split(glob('~/.vim/rc/*.toml'), '\n'))

    if has('nvim')
        call dein#load_toml(expand(g:install_path) . 'rc/plugins.toml', {})
    endif

    let s:vimrc_local = findfile('vimrc_local.vim', '.;')
    if s:vimrc_local !=# ''
    if has('nvim')
        call dein#local(fnamemodify(s:vimrc_local, ':h'),
            \ {'frozen': 1, 'merged': 0},
            \ ['deoplete-*', '*.nvim'])
        endif
    endif

    if dein#tap('deoplete.nvim') && has('nvim')
        call dein#disable('neocomplete.vim')
    endif

    call dein#end()
    call dein#save_state()
endif

if !has('vim_starting') && dein#check_install()
  call dein#install()
endif

" Disable netrw.vim
let g:loaded_netrwPlugin = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1


filetype plugin indent on
syntax enable

set fileformat=unix

" Command group opening with a specific character code again.
command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Utf16 edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? Utf16be edit<bang> ++enc=ucs-2 <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>
command! WUtf8 setlocal fenc=utf-8
command! WUnicode WUtf16

command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif
if $GOROOT !=? ''
  set runtimepath+=$GOROOT/misc/vim
endif
if !&verbose
  set spelllang=en_us
endif
let &undodir=&directory
set autoindent smartindent
set autoread " Auto reload if file is changed.
set backspace=indent,eol,start
set backupdir-=.
set breakat=\ \ ;:,!?
set clipboard& clipboard+=unnamed
set cmdheight=2
set cmdwinheight=5                                                                                           
set colorcolumn=79
set commentstring=%s
set complete=.
set completeopt=longest
set completeopt+=noinsert,noselect
set conceallevel=2 concealcursor=iv
set cpoptions-=m " Highlight when CursorMoved.
set directory-=. " Set swap directory.
set display=lastline                                                                                         
set expandtab " Exchange tab to spaces.
set fillchars=vert:\|
set foldcolumn=0 " Show folding level.
set foldenable " Enable folding.
set foldlevel=99 " Auto unfold all
set foldmethod=indent
set grepprg=grep\ -inH " Use grep.
set helpheight=12
set hidden " Display another buffer when current buffer isn't saved.
set history=1000
set ignorecase " Ignore the case of normal letters.
set incsearch " Enable incremental search.
set infercase " Ignore case on insert completion.
set isfname-== " Exclude = from isfilename.
set keywordprg=:help " Set keyword help.
set laststatus=2
set lazyredraw
set linebreak
set list
set listchars=tab:▸\ ,extends:»,precedes:«,nbsp:%
set matchpairs+=<:> " Highlight <>.
set matchtime=3
set modeline " Enable modeline.
set nobackup
set noequalalways 
set nohlsearch " Don't highlight search result.
set nonumber
set noshowcmd
set noshowmode
set nosmartcase " not good with dragon naturally speaking
set nostartofline
set noswapfile
set novisualbell
set nowildmenu
set nowritebackup
set previewheight=8
set pumheight=20
set relativenumber
set report=0
set secure
set shell=bash
set shiftround
set shiftwidth=4 " Round indent by shiftwidth.
set shortmess=aTI
set showbreak=>\
set showfulltag
set showmatch " Highlight parenthesis.
set showtabline=2
set smarttab " Smart insert tab setting.
set softtabstop=4 " Spaces instead <Tab>.
set splitbelow
set splitright                                                                                               
set t_vb=
set tabstop=4 " Substitute <Tab> with blanks.
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
set wildmode=list:longest,full
set wildoptions=tagfile
set winminheight=0 
set winminwidth=0 
set winwidth=1                                                                                               
set wrapscan " Searches wrap around the end of the file.



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

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Right> <NOP>
nnoremap <Left> :10winc<<CR>
nnoremap <Right> :10winc><CR>
nnoremap <Up> :res +5<CR>
nnoremap <Down> :res -5<CR>

nmap <F1> <nop>
map <F1> <Esc>
imap <F1> <Esc>
nnoremap <F1> <Esc>

nnoremap <C-o> <C-o>zz
nnoremap <Tab> <Tab>zz
nnoremap zj zjzz
nnoremap zk zkzz
nnoremap } }zz
nnoremap { {zz

command! Q q
command! WQ wq
command! Wall wall
command! WAll wall

nnoremap <Leader>p "+p
vnoremap ; <Esc>

nnoremap <F9> :silent make <bar> redraw!<CR>


xnoremap <TAB>  >
xnoremap <S-TAB>  <

nnoremap > >>
silent! nnoremap < <<
xnoremap > >gv
xnoremap < <gv


vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>
imap jj <Esc>
imap kk <Esc>

nnoremap ;d :<C-u>call <SID>CustomBufferDelete(1)<CR>

nnoremap dl :diffget //2<CR>
nnoremap dh :diffget //3<CR>
map 0 ^

nnoremap <Esc><Esc> :noh<CR>
nnoremap * *<C-o>
nnoremap vaw viw
vnoremap vaw viw

cmap w!! w !sudo tee > /dev/null %

inoremap kke kke
inoremap kk[Space] kk[Space]

vnoremap s d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>

  xmap p <Plug>(operator-replace)
  xmap I  <Plug>(niceblock-I)
  xmap A  <Plug>(niceblock-A)
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  xmap ab <Plug>(textobj-multiblock-a)
  xmap ib <Plug>(textobj-multiblock-i)
  nnoremap <silent> [Window]e  :<C-u>Unite junkfile/new junkfile -start-insert<CR>
  nmap J <Plug>(jplus)
  vmap J <Plug>(jplus)
  "vmap <Enter> is by default
  xmap <Enter> <Plug>(EasyAlign)
  nmap <Leader>a <Plug>(EasyAlign)

if has('clipboard')
  xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
endif

inoremap <C-d>  <Del>
inoremap <C-w>  <C-g>u<C-w>
inoremap <C-u>  <C-g>u<C-u>

cnoremap <C-a>          <Home>
cnoremap <C-b>          <Left>
cnoremap <C-d>          <Del>
cnoremap <C-e>          <End>
cnoremap <C-f>          <Right>
cnoremap <C-n>          <Down>
cnoremap <C-p>          <Up>
cnoremap <C-y>          <C-r>*
cmap <C-o>          <Plug>(unite_cmdmatch_complete)

nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>

nmap  <Space>   [Space]
xmap  <Space>   [Space]
nnoremap  [Space]   <Nop>
xnoremap  [Space]   <Nop>

nnoremap <silent> <Leader>.
      \ :<C-u>call ToggleOption('number')<CR>

nnoremap ;t :tabe<CR>
nnoremap ;v :vsplit<CR>
nnoremap ;s :split<CR>
nnoremap ;n :call SplitVim()<CR>

nnoremap [Space]h
    \ :Unite history/unite <CR>



nnoremap <silent> [Space]q
      \ :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> [Space]l
      \ :call ToggleList("Location List", 'l')<CR>
" Toggle cursorline.
nnoremap <silent> <Leader>cl
      \ :<C-u>call ToggleOption('cursorline')<CR>


nnoremap <silent> <Leader>cs
      \ :silent call ToggleColorScheme()<CR>
nnoremap [Space]ar
      \ :<C-u>setlocal autoread<CR>
nnoremap <silent> [Space]en
      \ :<C-u>setlocal encoding? fenc? fencs?<CR>
nnoremap ,sp
      \ :<C-u>call ToggleOption('spell')<CR>
nnoremap <Leader>w
      \ :<C-u>call ToggleOption('wrap')<CR>
nnoremap [Space]w :w<CR>
nnoremap <silent> <Leader><C-m> mmHmt:<C-u>%s/\r$//ge<CR>'tzt'm:echo 'Took away c-m'<CR>

nnoremap <silent> <Leader>ss mm:%s/\s\+$//g<CR>`mmmzzmm:echo 'Took away whitespace'<CR>

nnoremap <silent> [Space]ft :<C-u>Unite -start-insert filetype<CR>

nnoremap    [Window]   <Nop>
nmap    s [Window]
nnoremap <silent> ;o  :<C-u>only<CR>


    noremap <F12> <NOP>
    inoremap <silent> <c-s> <C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
    nnoremap <silent> <c-s> a<C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>


  nmap <silent>j <Plug>(accelerated_jk_gj)
  nmap gj j
  nmap <silent>k <Plug>(accelerated_jk_gk)
  nmap gk k

  xmap Y <Plug>(operator-concealedyank)

  nmap <C-w>  <Plug>(choosewin)

nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Jump.
nnoremap [Tag]t  g<C-]>
nnoremap <silent><expr> [Tag]t  &filetype == 'help' ?  "g\<C-]>" :
    \ ":\<C-u>UniteWithCursorWord -buffer-name=tag -immediately tag tag/include\<CR>"
nnoremap <silent><expr> [Tag]p  &filetype == 'help' ?
    \ ":\<C-u>pop\<CR>" : ":\<C-u>Unite jump\<CR>"

nnoremap <silent><expr> /
    \ ":\<C-u>Unite -buffer-name=search%".bufnr('%')." -start-insert line:forward:wrap\<CR>"
" nnoremap <silent><expr> *
"       \ ":\<C-u>UniteWithCursorWord -buffer-name=search%".bufnr('%')." line:forward:wrap\<CR>"
cnoremap <expr><silent><C-g>        (getcmdtype() == '/') ?
    \ "\<ESC>:Unite -buffer-name=search line:forward:wrap -input=".getcmdline()."\<CR>" : "\<C-g>"

nnoremap <silent><expr> n
    \ ":\<C-u>UniteResume search%".bufnr('%')."
    \  -no-start-insert -force-redraw\<CR>"

tnoremap jj <C-\><C-n>
tnoremap kk <C-\><C-n>
tnoremap <Esc><Esc> <C-\><C-n>

nnoremap [Space]o :FZFMru<CR>
noremap <c-t>  <Nop>
nnoremap <c-t> :FZFMru<CR>

nnoremap <silent> [Window]e  :<C-u>Unite junkfile/new junkfile -start-insert<CR>
nnoremap Q  q " Disable Ex-mode.
nnoremap [Quickfix]   <Nop> " q: Quickfix  

nnoremap <silent> [Quickfix]<Space>
      \ :<C-u>call <SID>toggle_quickfix_window()<CR>

xnoremap r <C-v> " Select rectangle.
xnoremap v $h

nnoremap <silent> <C-l>    :<C-u>redraw!<CR>

noremap [Space]u :<C-u>Unite outline:foldings<CR>

nmap <C-a> <SID>(increment)
nmap <C-x> <SID>(decrement)
nnoremap <silent> <SID>(increment)    :AddNumbers 1<CR>
nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
nnoremap \  `
nnoremap M  m

nnoremap <silent> <C-f> <C-f>
nnoremap <silent> <C-b> <C-b>

nnoremap <silent> } :<C-u>call ForwardParagraph()<CR>
onoremap <silent> } :<C-u>call ForwardParagraph()<CR>
xnoremap <silent> } <Esc>:<C-u>call ForwardParagraph()<CR>mzgv`z
                                                                                                            
function! s:mkdir_as_necessary(dir, force)
  if !isdirectory(a:dir) && &l:buftype ==? '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

let s:myLang=0
let s:myLangList=['nospell','en_us', 'nb']
function! ToggleSpell()
  let b:myLang=g:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
  else
    execute 'setlocal spell spelllang='.get(g:myLangList, b:myLang)
  endif
  echo 'spell checking language:' s:myLangList[b:myLang]
endfunction
nmap <silent> <F7> :call ToggleSpell()<CR>
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction


augroup MyAutoCmd
  autocmd FileType,Syntax,BufEnter,BufWinEnter * call s:my_on_filetype()
  autocmd FileType c,cpp set formatprg=astyle
  autocmd BufReadPost fugitive://* set bufhidden=delete

    autocmd WinEnter * checktime " Check timestamp more for 'autoread'.
    autocmd InsertLeave *
        \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
        \ if &l:diff | diffupdate | endif
    autocmd InsertLeave * if &l:diff | diffupdate | endif " Update diff.
    autocmd BufWritePre *
        \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)


  " Auto reload VimScript.
  autocmd BufWritePost,FileWritePost *.vim if &autoread
        \ | source <afile> | echo 'source ' . bufname('%') | endif

  autocmd FileType gitcommit,qfreplace setlocal nofoldenable

  " Enable omni completion.
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
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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

  autocmd FileType go highlight default link goErr WarningMsg |
        \ match goErr /\<err\>/
augroup END

let g:python_highlight_all = 1
let g:vimsyntax_noerror = 1
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

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

function! s:set_syntax_of_user_defined_commands() 
  redir => _
  silent! command
  redir END

  let command_names = join(map(split(_, '\n')[1:],
        \ "matchstr(v:val, '[!\"b]*\\s\\+\\zs\\u\\w*\\ze')"))

  if command_names ==? '' | return | endif

  execute 'syntax keyword vimCommand ' . command_names
endfunction

function! s:my_on_filetype() 
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
endfunction 

" Do not display completion messages
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
try
  set shortmess+=c
catch /^Vim\%((\a\+)\)\=:E539: Illegal character/
  autocmd MyAutoCmd VimEnter *
        \ highlight ModeMsg guifg=bg guibg=bg |
        \ highlight Question guifg=bg guibg=bg
endtry

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
  if a:pfx ==# 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo 'Location List is Empty.'
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! ToggleColorScheme()
  if exists('g:syntax_on')
    syntax off
  else
    colorscheme peskcolor
    syntax enable
  endif
endfunction


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
  elseif winnr() < winnr('$')
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
    execute winnr('$') . 'wincmd w'
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
function! s:alternate_buffer() 
  let listed_buffer_len = len(filter(range(1, bufnr('$')),
        \ 's:buflisted(v:val) && getbufvar(v:val, ''&filetype'') !=# ''unite'''))
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
endfunction
function! s:buflisted(bufnr) 
  return exists('t:unite_buffer_dictionary') ?
        \ has_key(t:unite_buffer_dictionary, a:bufnr) && buflisted(a:bufnr) :
        \ buflisted(a:bufnr)
endfunction

command! -nargs=0 JunkfileDiary call junkfile#open_immediately(
      \ strftime('%Y-%m-%d.md'))

function! s:toggle_quickfix_window()
  let _ = winnr('$')
  cclose
  if _ == winnr('$')
    copen
    setlocal nowrap
    setlocal whichwrap=b,s
  endif
endfunction


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


command! -range -nargs=1 AddNumbers
      \ call s:add_numbers((<line2>-<line1>+1) * eval(<args>))
function! s:add_numbers(num)
  let prev_line = getline('.')[: col('.')-1]
  let next_line = getline('.')[col('.') :]
  let prev_num = matchstr(prev_line, '\d\+$')
  if prev_num !=? ''
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
  " echo printf('%s = %s', a:variable_name, eval(a:variable_name))
endfunction  


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


function! GentooCleanConfig()
    " vint: -ProhibitCommandRelyOnUser
    silent! normal :%s/^#.*//g
    silent! normal :%s/-\v(\d{1,2}(\.)?){1,4}(-r\d)?//g
    silent! normal %s/>=//g
    silent! normal :g/^$/d
    " vint: +ProhibitCommandRelyOnUser
    :sort u<CR>
    :noh<CR>
endfunction


" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>
" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap

" Using the mouse on a terminal.
if has('mouse')
  set mouse=a

  " Paste.
  nnoremap <RightMouse> "+p
  xnoremap <RightMouse> "+p
  inoremap <RightMouse> <C-r><C-o>+
  cnoremap <RightMouse> <C-r>+
endif

let t:cwd = getcwd()
tnoremap   <ESC><ESC>   <C-\><C-n>

let python_highlight_all = 1

  let g:deoplete#enable_at_startup = 1
  let g:deoplete#auto_completion_start_length = 1

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~? '\s'
    endfunction

    inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

    inoremap <expr><C-g> deoplete#mappings#undo_completion()
    " <C-l>: redraw candidates
    inoremap <expr><C-l>       deoplete#mappings#refresh()

    inoremap <silent><expr> <s-Tab>
    \ pumvisible() ? '<C-p>' :
    \ deoplete#mappings#manual_complete()
    imap <expr><Tab> 
    \ pumvisible() ? '<C-n>' : <SID>check_back_space() ? '<Esc>' :  deoplete#mappings#manual_complete() 

    inoremap <expr>;
                \ pumvisible() ? deoplete#mappings#close_popup() :
                \ ";"
call deoplete#custom#set('ghc', 'sorters', ['sorter_word'])
call deoplete#custom#set('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.python = ''
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'

let g:deoplete#enable_camel_case = 1
" let g:deoplete#auto_complete_start_length = 3

let g:deoplete#sources#clang#libclang_path = '/usr/lib64/llvm/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'
let g:deoplete#sources#clang#flags = ['-x', 'c++', '-std=c++11']

nnoremap    [unite]   <Nop>
xnoremap    [unite]   <Nop>
nmap    ;u [unite]
xmap    ;u [unite]


nnoremap <silent> ;t
    \ :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
nnoremap [Space]t
    \ :<C-u>Unite -start-insert tag tag/include<CR>
nnoremap <silent> <C-k>
    \ :<C-u>Unite change jump<CR>
nnoremap <silent> [Space]r
    \ :<C-u>Unite -buffer-name=register register history/yank<CR>

function! s:smart_search_expr(expr1, expr2)
    return line('$') > 5000 ?  a:expr1 : a:expr2
endfunction

call unite#custom#profile('action', 'context', {
        \ 'start_insert' : 1
        \ })

" migemo.
call unite#custom#source('line_migemo', 'matchers', 'matcher_migemo')

" Custom filters.
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


function! s:unite_my_settings() 
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

    nnoremap <silent><buffer><expr> !     unite#do_action('start')
    nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
    \ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
endfunction

let default_context = {
        \ 'vertical' : 0,
        \ 'short_source_names' : 1,
        \ }

let g:unite_enable_split_vertically = 0
let g:unite_winheight = 20
let g:unite_enable_start_insert = 0
let g:unite_enable_short_source_names = 1

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

let g:unite_source_rec_max_cache_files = -1

" My custom split action
let s:my_split = {'is_selectable': 1}
function! s:my_split.func(candidate)
    let split_action = 'vsplit'
    if winwidth(winnr('#')) <= 2 * (&textwidth ? &textwidth : 80)
    let split_action = 'split'
    endif
    call unite#take_action(split_action, a:candidate)
endfunction
call unite#custom_action('openable', 'context_split', s:my_split)
unlet s:my_split

nnoremap <silent> [Space]n  :UniteNext<CR>
nnoremap <silent> [Space]p  :UnitePrevious<CR>
nnoremap <silent> [Space]r  :UniteResume<CR>

nmap <silent> W <Plug>CamelCaseMotion_w
xmap <silent> W <Plug>CamelCaseMotion_w
omap <silent> W <Plug>CamelCaseMotion_w
nmap <silent> B <Plug>CamelCaseMotion_b
xmap <silent> B <Plug>CamelCaseMotion_b
omap <silent> B <Plug>CamelCaseMotion_b

nmap <silent> <Leader>r <Plug>(quickrun)

nnoremap <silent>   [Space]v   :<C-u>VimFiler -invisible<CR>
nnoremap    [Space]fe   :<C-u>VimFilerExplorer<CR>

    nmap <F8> :TagbarToggle<CR>
  nmap <silent>sa <Plug>(operator-surround-append)a
  nmap <silent>sd <Plug>(operator-surround-delete)a
  nmap <silent>sr <Plug>(operator-surround-replace)a
  nmap <silent>sc <Plug>(operator-surround-replace)a

  autocmd MyAutoCmd FileType qf nnoremap <buffer> r :<C-u>Qfreplace<CR>

  nmap gs <Plug>(open-browser-wwwsearch)

    nnoremap <Plug>(open-browser-wwwsearch)
          \ :<C-u>call <SID>www_search()<CR>
    function! s:www_search()
      let search_word = input('Please input search word: ')
      if search_word !=? ''
        execute 'OpenBrowserSearch' escape(search_word, '"')
      endif
    endfunction

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

  let g:choosewin_overlay_enable = 1
  let g:choosewin_overlay_clear_multibyte = 1
  let g:choosewin_blink_on_land = 0


    let g:gitgutter_max_signs = 5000

"     " nmap f <Plug>(smalls)

    let g:Gitv_OpenHorizontal = 'auto'
    let g:Gitv_WipeAllOnClose = 1
    let g:Gitv_DoNotMapCtrlKey = 1

    let g:UltiSnipsExpandTrigger='<C-CR>'
    let g:UltiSnipsJumpForwardTrigger='<C-tab>'
    let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

    let g:livepreview_previewer = 'evince'


function! FindCabalSandboxRoot()
    return finddir('.cabal-sandbox', './;')
endfunction

function! FindCabalSandboxRootPackageConf()
    return glob(FindCabalSandboxRoot().'/*-packages.conf.d')
endfunction

    augroup MyAutoCmd BufEnter *.hs setlocal omnifunc=necoghc#omnifunc

    let g:necoghc_enable_detailed_browse=1

    let g:haddock_browser = 'google-chrome-stable'
    augroup MyAutoCmd BufEnter *.hs compiler ghc

     nnoremap <silent> <Leader>au :Autoformat<CR>

let g:vimfiler_preview_action = 'auto_preview'

    let g:neomake_open_list = 2
    let g:neomake_list_height = 5
    let g:neomake_tex_enabled_makers = ['chktex']
    let g:neomake_python_enabled_makers=['pylint']

augroup MyAutoCmd
    autocmd FileType c let g:neomake_c_enabled_makers = []
    autocmd FileType cpp let g:neomake_cpp_enabled_makers = []
    autocmd FileType c nnoremap [Space]w :w \| Neomake!<CR>
    autocmd FileType cpp nnoremap [Space]w :w \| Neomake!<CR>
    autocmd FileType asm nnoremap [Space]w :w \| Neomake!<CR>
    autocmd FileType yacc nnoremap [Space]w :w \| Neomake!<CR>
    autocmd FileType lex nnoremap [Space]w :w \| Neomake!<CR>
    autocmd! BufWritePost * Neomake

    autocmd FileType pdf Pdf '%'
    autocmd FileType pdf :0
augroup END


    nnoremap [Space]/  :Grepper -tool ag  -open -switch<cr>

let &titlestring="
      \ %{expand('%:p:.:~')}%(%m%r%w%)
      \ %<\(%{".s:SID_PREFIX()."strwidthpart(
      \ fnamemodify(&filetype ==# 'vimfiler' ?
      \ substitute(b:vimfiler.current_dir, '.\\zs/$', '', '') : getcwd(), ':~'),
      \ &columns-len(expand('%:p:.:~')))}\) - VIM"
" Set statusline.
let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
      \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
      \ . "%{(&previewwindow?'[preview] ':'').expand('%:t:.')}"
      \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
      \ . "%{printf(' %4d/%d',line('.'),line('$'))} %c"


function! s:strwidthpart(str, width)                                 
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
endfunction

" Use builtin function.
function! s:wcswidth(str)
    return strwidth(a:str)
endfunction

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'


command! FZFMru call fzf#run({
            \ 'source':  reverse(s:all_files()),
            \ 'sink':    'edit',
            \ 'options': '-m -x +s -e',
            \ 'down':    '40%' })

function! s:all_files()
      let fuckall = split(system('locate "${PWD}/" | sort'), '\n')
      let test = filter(copy(v:oldfiles),
        \        "v:val !~# 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'")
      let omg = extend(test, fuckall)
      let lolzomg = extend(omg,
            \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
      return lolzomg
  endfunction


let g:vimfiler_enable_clipboard = 0
let g:vimfiler_safe_mode_by_default = 0

let g:vimfiler_as_default_explorer = 1
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

  let g:vimfiler_tree_leaf_icon = ' '
  let g:vimfiler_tree_opened_icon = '▾'
  let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_file_icon = ' '
  let g:vimfiler_readonly_file_icon = '✗'
  let g:vimfiler_marked_file_icon = '✓'

autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() 
  call vimfiler#set_execute_file('vim', ['vim', 'notepad'])
  call vimfiler#set_execute_file('txt', 'vim')

  nnoremap <silent><buffer><expr> gy vimfiler#do_action('tabopen')
  " nmap <buffer> <Tab> <Plug>(vimfiler_switch_to_other_window)

  " Migemo search.
  if !empty(unite#get_filters('matcher_migemo'))
    nnoremap <silent><buffer><expr> /  line('$') > 10000 ?  'g/' :
          \ ":\<C-u>Unite -buffer-name=search -start-insert line_migemo\<CR>"
  endif

endfunction

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

au MyAutoCmd Bufenter *.py nnoremap <silent> [Space]i :Unite menu:jedi -silent -winheight=25 -start-insert<CR>
colorscheme peskcolor


    let g:finance_watchlist = ['NZYM-B.CO']
    let g:finance_format = '{symbol}: {LastTradePriceOnly} ({Change})'
    let g:finance_separator = "\n"

tnoremap <C-6> <C-\><C-n><C-6>


" The BufOnly is under copyright 
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
    if a:buffer ==? ''
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
        echomsg 'No matching buffer for' a:buffer
        echohl None
        return
    endif

    let last_buffer = bufnr('$')

    let delete_count = 0
    let n = 1
    while n <= last_buffer
        if n != buffer && buflisted(n)
            if a:bang ==? '' && getbufvar(n, '&modified')
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
        echomsg delete_count 'buffer deleted'
    elseif delete_count > 1
        echomsg delete_count 'buffers deleted'
    endif

endfunction

""" end of copyrighted code block
