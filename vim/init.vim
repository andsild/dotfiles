set termencoding=utf-8
" vimrc Anders Sildnes - great respect to Shougo, who I based this vimrc from
"

let g:neomake_haskell_ghcmodlint_maker = {
        \ 'exe': 'ghc-mod',
        \ 'args': ['lint'],
        \ 'mapexpr': 'substitute(v:val, "\n", "", "g")',
        \ 'errorformat':
            \ '%-G%\s%#,' .
            \ '%f:%l:%c:%trror: %m,' .
            \ '%f:%l:%c:%tarning: %m,'.
            \ '%f:%l:%c: %trror: %m,' .
            \ '%f:%l:%c: %tarning: %m,' .
            \ '%E%f:%l:%c:%m,' .
            \ '%E%f:%l:%c:,' .
            \ '%Z%m'
            \ }

function! s:isWindows()
    return has('win64') || has('win32')
endfunction

function! s:IsMac()
    let l:sysout=system('uname')
    return has('unix') && match(l:sysout, '\cDarwin') == 0
endfunction

if s:isWindows()
    set shellslash
    let s:winpythonpath='C:\Users\andesil\AppData\Local\Programs\Python\Python35-32;C:\Users\andesil\AppData\Local\Programs\Python\Python35-32\Scripts\' .
    	\	';C:\Program Files (x86)\Python35-32;C:\Program Files (x86)\Python35-32\Scripts'
    let $PATH = s:winpythonpath . ';' . $VIM . ';' . $PATH
    let g:haddock_docdir='C:\Program Files\Haskell Platform\8.0.1\doc\html'
elseif s:IsMac()
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

    set shell=bash
else
    set shell=bash
endif


let g:path = expand($XDG_CONFIG_HOME)
if len(g:path) == 0
    if s:isWindows()
        let g:path = $USERPROFILE . expand('/AppData/Local')
    else
        let g:path = expand('~/.config/')
    endif
endif
let g:toml_path = g:path . '/nvim/plugins.toml'
let $MYVIMRC=g:path . '/nvim/init.vim' " normally set by default, but I use
    " a custom script to invoke vim. When invoking from the command line with
    " -u flag, MYVIMRC is not set. This also means that the file ".-rplugin" 
    " is not written
if ! filereadable(g:toml_path)
    echom 'Could not find plugins.toml file at ' . g:toml_path
    echom 'Aborting init.vim loading'
    finish
endif
let g:default_colorscheme = 'mayansmoke'  " installed from plugin
set background=light
let g:mapleader = ','

if &compatible
  " vint: -ProhibitSetNoCompatible
  set nocompatible
endif

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

if has('vim_starting')
    set encoding=utf-8
    scriptencoding utf8

    filetype plugin indent on


    let $CACHE = expand('~/.cache')
    let s:dein_dir = finddir('dein.vim', '.;')
    let g:dein_firsttime = 0
    if s:dein_dir !=? '' || &runtimepath !~# '/dein.vim'
    if s:dein_dir ==? '' && &runtimepath !~# '/dein.vim'
        let s:dein_dir = expand('$CACHE/dein')
            \. '/repos/github.com/Shougo/dein.vim'
        if !isdirectory(s:dein_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
        let g:dein_firsttime = 1
        endif
    endif
    execute ' set runtimepath^=' . substitute(
            \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
    endif

    let g:dein#install_progress_type = 'title'
    let g:dein#install_message_type = 'none'
    let g:dein#enable_notification = 1

    let s:path = expand('$CACHE/dein')
    call dein#begin(s:path, [expand('<sfile>')])


    if has('nvim')
        call dein#load_toml(g:toml_path, {'lazy': 0})
    endif

    call dein#add('Shougo/vimproc.vim', {'build' : 'make'})


    call dein#end()
    call dein#save_state()

    if g:dein_firsttime
        " call dein#install()
        echom 'Please restart nvim and do: call dein#install()'
        finish
    endif

    exe 'silent! colorscheme ' . g:default_colorscheme
endif

if !has('vim_starting') && dein#check_install()
  call dein#install()
endif

" Disable netrw.vim
let g:loaded_netrwPlugin = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1
let t:cwd = getcwd()

augroup DefaultAuGroup
    autocmd!

    autocmd BufEnter,BufWinEnter,FileType,Syntax * call s:my_on_filetype()
    autocmd BufWritePost,FileWritePost *.vim if &autoread | source <afile> | echo 'source ' . bufname('%') | endif
    autocmd BufWritePre * call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
    autocmd Bufenter *.py nnoremap <silent><buffer> [Space]i :Unite -winheight=25 menu:jedi -silent  -start-insert<CR>
    autocmd FileType apache setlocal path+=./;/
    autocmd FileType c,cpp set formatprg=astyle 
    "autocmd FileType c,cpp set keywordprg=:Man
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType gitcommit,qfreplace setlocal nofoldenable
    autocmd FileType go highlight default link goErr WarningMsg | match goErr /\<err\>/
    autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=./;/
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType javascript,javascript.jsx nmap <buffer> <s-k> :TernDoc<CR>
    autocmd FileType javascript,javascript.jsx nnoremap <buffer> [Space]i :Unite menu:tern -silent -winheight=25 -start-insert<CR>
    autocmd FileType markdown nnoremap <buffer> [Space]i :Unite menu:markdown -silent -winheight=25 -start-insert<CR>
    autocmd FileType pdf Pdf '%'
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType python setlocal formatprg=autopep8\ --aggressive\ --ignore=E309\ -
    autocmd FileType qf nnoremap <buffer> r :<C-u>Qfreplace<CR>
    autocmd FileType unite call s:unite_my_settings()
    autocmd FileType vimfiler call s:vimfiler_my_settings()
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd InsertLeave * if &l:diff | diffupdate | endif " Update diff.
    autocmd InsertLeave * if &paste | set nopaste mouse=a | echo 'nopaste' | endif | if &l:diff | diffupdate | endif
    autocmd WinEnter * checktime " Check timestamp more for 'autoread'.
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc  | setlocal formatprg=stylish-haskell | nnoremap <buffer> gqa gggqG:silent %!hindent --style johan-tibell<CR><c-o><c-o>zz
    autocmd FileType haskell nnoremap <silent><buffer>K :GhcModInfoPreview<CR>
    autocmd BufLeave unite source /tmp/layout.vim

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


set autoindent 
set smartindent
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
set completeopt+=noinsert,noselect,preview,menu
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
"set keywordprg=:help " Set keyword help.
set laststatus=2
set lazyredraw
set linebreak
set list
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
set sessionoptions="blank,curdir,folds,help,winsize"
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
set wildmode=list:longest
set wildoptions=tagfile
set fileignorecase
set wildignorecase
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

nmap S <Plug>(smalls)
cmap <C-o>          <Plug>(unite_cmdmatch_complete)
cmap w!! w !sudo tee > /dev/null %
cnoremap <C-a>          <Home>
cnoremap <C-b>          <Left>
cnoremap <C-d>          <Del>
cnoremap <C-e>          <End>
cnoremap <C-f>          <Right>
cnoremap <C-n>          <Down>
cnoremap <C-p>          <Up>
cnoremap <C-y>          <C-r>*
cnoremap <expr><silent><C-g>        (getcmdtype() == '/') ? '\<ESC>:Unite -buffer-name=search line:forward:wrap -input='.getcmdline().'\<CR>' : '\<C-g>'
imap <F1> <Esc>
imap <silent><expr> <TAB> pumvisible() ? "<C-n>" : <SID>check_back_space() ? "<TAB>" : deoplete#mappings#manual_complete()
imap jj <Esc>
imap kk <Esc>
inoremap <C-d>  <Del>
inoremap <C-6> <Esc><C-6>zz
nmap <C-6> <C-6>zz
inoremap <C-u>  <C-g>u<C-u>
inoremap <C-w>  <C-g>u<C-w>
inoremap <expr>; pumvisible() ? deoplete#mappings#close_popup() : ";"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><C-g> deoplete#mappings#undo_completion()
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><C-l>       deoplete#mappings#refresh()
inoremap <silent><expr> <s-Tab> pumvisible() ? '<C-p>' : deoplete#mappings#manual_complete()
inoremap kk[Space] kk[Space]
inoremap kke kke
map 0 ^
map <F1> <Esc>
nmap    s [Window]
nmap    t [Tag]
nmap  <Space>   [Space]
nmap <C-a> <SID>(increment)
nmap <C-w>  <Plug>(choosewin)
nmap <C-x> <SID>(decrement)
nmap <F1> <nop>
nmap gc <Plug>(caw:prefix)
nmap gcc <Plug>(caw:hatpos:toggle)
vmap gcc <Plug>(caw:hatpos:toggle)
nmap <buffer> tcd         <Plug>(unite_quick_match_default_action)
nmap <silent> <F7> :call ToggleSpell()<CR>
nmap <silent> B <Plug>CamelCaseMotion_b
nmap <silent> W <Plug>CamelCaseMotion_w
nmap <silent>j <Plug>(accelerated_jk_gj)
nmap <silent>k <Plug>(accelerated_jk_gk)
nmap <silent>sa <Plug>(operator-surround-append)a
nmap <silent>sc <Plug>(operator-surround-replace)a
nmap <silent>sd <Plug>(operator-surround-delete)a
nmap <silent>sr <Plug>(operator-surround-replace)a
nmap gj j
nmap gk k
nmap gs <Plug>(open-browser-wwwsearch)
nnoremap    ;u [unite]
nnoremap <leader>u :diffupdate<CR>
nnoremap    [Space]fe   :<C-u>VimFilerExplorer<CR>
nnoremap    [Tag]   <Nop>
nnoremap <leader>hs :call <C-u>call ToggleOption('hlsearch')<CR>
nnoremap <leader>hi :call <SID>SynStack()<CR>
nnoremap <leader>lc :call <SID>ToggleShowListChars()<CR>
nnoremap    [Window]   <Nop>
nnoremap    [unite]   <Nop>
nnoremap  [Space]   <Nop>
nnoremap * :silent set hlsearch<CR>*<C-o>
nnoremap ,  <Nop>
nnoremap ;  <Nop>
nnoremap ;d :<C-u>call <SID>CustomBufferDelete(1)<CR>
nnoremap ;s :split<CR>
nnoremap ;t :tabe<CR>
nnoremap ;v :vsplit<CR>
nnoremap <C-o> <C-o>zz
nnoremap <Down> :res -5<CR>
nnoremap <Esc><Esc> :noh<CR>
nnoremap <F1> <Esc>
nnoremap <F9> :silent make <bar> redraw!<CR>
nnoremap <Leader>w :<C-u>call ToggleOption('wrap')<CR>
nnoremap <Left> :10winc<<CR>
nnoremap <Plug>(open-browser-wwwsearch) :<C-u>call <SID>www_search()<CR>
nnoremap <Right> :10winc><CR>
nnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>
nnoremap <Tab> <Tab>zz
nnoremap <Up> :res +5<CR>
nnoremap <c-t> :FZFMru<CR>
nnoremap <leader>sp :<C-u>call ToggleOption('spell')<CR>
nnoremap <silent>   [Space]v   :<C-u>VimFiler -invisible<CR>
nnoremap <silent> ;o  :<C-u>only<CR>
nnoremap <silent> <C-b> <C-b>
nnoremap <silent> <C-f> <C-f>
nnoremap <silent> <C-k> :<C-u>Unite change jump<CR>
nnoremap <silent> <C-l>    :<C-u>redraw!<CR>
nnoremap <silent> <Leader>. :<C-u>call ToggleOption('number')<CR>
nnoremap <silent> <Leader><C-m> mmHmt:<C-u>%s/\r$//ge<CR>'tzt'm:echo 'Took away c-m'<CR>
nnoremap <silent> <Leader>au :Autoformat<CR>
nnoremap <silent> <Leader>cl :<C-u>call ToggleOption('cursorline')<CR>
nnoremap <silent> <Leader>cs :call ToggleColorScheme()<CR>
nnoremap <silent> [Space]1 :QuickRun<CR>
nnoremap <silent> <Leader>ss mm:%s/\s\+$//g<CR>`mmmzzmm:echo 'Took away whitespace'<CR>
nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
nnoremap <silent> <SID>(increment)    :AddNumbers 1<CR>
nnoremap <silent> [Space]t :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
nnoremap <silent> [Quickfix]<Space> :<C-u>call <SID>toggle_quickfix_window()<CR>
nnoremap <silent> [Space]di :Unite menu:diff -silent -start-insert -winheight=10 <CR>
nnoremap <silent> [Space]en :<C-u>setlocal encoding? fenc? fencs?<CR>
nnoremap <silent> [Space]ft :<C-u>Unite -start-insert filetype<CR>
nnoremap <silent> [Space]l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> n  :UniteNext<CR>
nnoremap <silent> [Space]p  :UnitePrevious<CR>
nnoremap <silent> [Space]q :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> [Space]r  :UniteResume<CR>
nnoremap <silent> [Space]r :<C-u>Unite -buffer-name=register register history/yank<CR>
nnoremap <silent> [Window]e  :<C-u>Unite junkfile/new junkfile -start-insert<CR>
nnoremap <silent> } :<C-u>call ForwardParagraph()<CR>
nnoremap <silent><buffer><expr> gy vimfiler#do_action('tabopen')
nnoremap <silent><expr> / ":\<C-u>Unite -buffer-name=search%".bufnr('%')." -start-insert line:forward:wrap\<CR>"
nnoremap <silent><expr> [Space]n ":\<C-u>UniteResume search%".bufnr('%')."  -no-start-insert -force-redraw\<CR>"
nnoremap <silent>[Space]g :Unite -silent -winheight=29 -start-insert menu:git<CR>
nnoremap > >>
nnoremap M  m
nnoremap Q  q " Disable Ex-mode.
nnoremap [Quickfix]   <Nop> " q: Quickfix  
nnoremap [Space]/  :Ag<CR>
nnoremap [Space]ar :<C-u>setlocal autoread<CR>
nnoremap [Space]h :Unite history/unite <CR>
nnoremap [Space]<s-o> :FZFGit<CR>
nnoremap [Space]w :silent Neomake<CR>
nnoremap \  `
nnoremap dh :diffget //3<CR>
nnoremap dl :diffget //2<CR>
nnoremap vaw viw
nnoremap zj zjzz
nnoremap zk zkzz
nnoremap { {zz
nnoremap } }zz
noremap <F12> <NOP>
noremap [Space]u :<C-u>Unite outline:foldings<CR>
omap <silent> B <Plug>CamelCaseMotion_b
omap <silent> W <Plug>CamelCaseMotion_w
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
onoremap <silent> } :<C-u>call ForwardParagraph()<CR>
silent! nnoremap < <<
tnoremap <ESC><ESC> <C-\><C-n>
tnoremap <C-6> <C-\><C-n><C-6>zz
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>
tnoremap kk <C-\><C-n>
vmap <silent> gs <Plug>(openbrowser-search)
vnoremap ; <Esc>
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>
vnoremap s d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>
vnoremap vaw viw
xmap    ;u [unite]
xmap  <Space>   [Space]
xmap <Enter> <Plug>(EasyAlign)
xmap <silent> B <Plug>CamelCaseMotion_b
xmap <silent> W <Plug>CamelCaseMotion_w
xmap A  <Plug>(niceblock-A)
xmap I  <Plug>(niceblock-I)
xmap Y <Plug>(operator-concealedyank)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)
xmap p <Plug>(operator-replace)
xnoremap    [unite]   <Nop>
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
 
if s:isWindows()
    let g:unite_source_rec_async_command = ['git', 'ls-files']
    nnoremap [Space]o :Unite file_mru file_rec/neovim  file/new -start-insert<CR>
else
    nnoremap [Space]o :FZFMru<CR>
endif

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
 
let g:auto_save = 1
let g:maplocalleader = 'm' " Use <LocalLeader> in filetype plugin.
let g:formatters_javascript = ['jscs']
let g:myLang=0
let g:UltiSnipsExpandTrigger='<c-s>'
let g:UltiSnipsJumpForwardTrigger='zl'
let g:UltiSnipsJumpBackwardTrigger='zh'
let g:myLangList=['nospell','en_us', 'nb']
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.python = ''
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#omni#functions = {}
let g:jsx_ext_required = 0
let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'
let g:unite#default_context = {
        \ 'vertical' : 0,
        \ 'short_source_names' : 1,
        \ }
let g:unite_enable_split_vertically = 0
let g:unite_winheight = 20
let g:unite_enable_start_insert = 0
let g:unite_enable_short_source_names = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#sources#clang#flags = ['-x', 'c++', '-std=c++11']
let g:unite_source_rec_max_cache_files = -1
let s:my_split = {'is_selectable': 1}
let g:choosewin_overlay_enable = 1
let g:choosewin_overlay_clear_multibyte = 1
let g:choosewin_blink_on_land = 0
let g:necoghc_enable_detailed_browse=1
let g:haddock_browser = 'google-chrome-stable'
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:gitgutter_max_signs = 5000
let g:Gitv_OpenHorizontal = 'auto'
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_DoNotMapCtrlKey = 1
let g:livepreview_previewer = 'zathura'
let g:vimfiler_preview_action = 'auto_preview'
let g:neomake_open_list = 2
let g:neomake_list_height = 5
let g:neomake_tex_enabled_makers = ['chktex']
let g:neomake_haskell_enabled_makers = ['ghcmodlint']
let g:neomake_python_enabled_makers=['pylint']
let g:neomake_javascript_enabled_makers=['eslint', 'jscs']
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
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
      \ 'wav' : 'setsid mplayer %f &',
      \ 'Inkscape' : 'inkspace',
      \ 'GIMP' : 'gimp %*',
      \ 'gedit' : 'gedit',
      \ }
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = ' '
let g:vimfiler_ignore_pattern=['^\%(\.git\|\.DS_Store\)$']
let g:vimfiler_readonly_file_icon = '✗'
let &undodir=&directory
let g:vimfiler_marked_file_icon = '✓'
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
let g:unite_source_menu_menus.markdown = {
        \ 'description' : ' Open preview
        \   [space]i',
\}
let g:unite_source_menu_menus.markdown.command_candidates = [
    \['-> Preview',
        \'PrevimOpen'],
\]
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

let g:unite_source_menu_menus.tern = {
        \ 'description' : '            Javascript intellisense
            \                                [Space]i',
    \}
let g:unite_source_menu_menus.tern.command_candidates = [
    \['-> Browse docs',
        \'TernDocBrowse'],
   \['-> Type lookup',
        \'TernType'],
    \['-> Definition',
        \'TernDef'],
    \['-> References',
        \'TernRefs'],
    \['-> Rename',
        \'TernRename'],
\]
let g:finance_watchlist = ['NZYM-B.CO']
let g:finance_format = '{symbol}: {LastTradePriceOnly} ({Change})'
let g:finance_separator = "\n"
let g:python_highlight_all = 1
let g:vimsyntax_noerror = 1
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1
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

if s:IsMac()
   let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
   let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/include'
else
	let g:deoplete#sources#clang#libclang_path=system(
		\ 'paths=$(clang --print-search-dirs | tail -n1 | cut -d= -f2) ;' 
		\ . 'IFS=":" ; for dir in ${paths} ; do '
		\ . 'test -e ${dir}/libclang.so && echo -n $(readlink -f ${dir}/libclang.so) && break ;'
		\ . 'done ; unset IFS')
   let g:deoplete#sources#clang#clang_header = system(
	        \ 'paths=$(clang --print-search-dirs | tail -n1 | cut -d= -f2) ;' 
		\ . 'IFS=":" ; for dir in ${paths} ; do '
		\ . 'test -e ${dir}/../include/clang && echo -n $(readlink -f ${dir}/../include/clang) && break; '
		\ . 'done ; unset IFS')
"   let g:deoplete#sources#clang#libclang_path = '/usr/lib64/llvm/libclang.so'
   "let g:deoplete#sources#clang#clang_header = '/usr/include/clang'
endif


if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
    \ '-i --ignore-dir "*bin*" -U --line-numbers --nocolor --nogroup --hidden --ignore ' .
    \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'' --ignore ''tags'' ' .
    \ '--ignore ''.trx'' --ignore ''.xml'' --ignore ''.tt'''
    let g:unite_source_grep_recursive_opt = ''
endif


" Command group opening with a specific character code again.
command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Utf16 edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? Utf16be edit<bang> ++enc=ucs-2 <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>
command! WUtf8 setlocal fenc=utf-8
command! WUnicode WUtf16

command! FZFGit call fzf#run({
            \ 'source':  'git ls-files',
            \ 'sink':    'edit',
            \ 'options': '-m -x +s -e',
            \ 'down':    '40%' })
command! FZFMru call fzf#run({
            \ 'source':  reverse(s:all_files()),
            \ 'sink':    'edit',
            \ 'options': '-m -x +s -e',
            \ 'down':    '40%' })
command! -bang -complete=file -nargs=? WUnix write<bang> ++fileformat=unix <args> | edit <args>
" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>
" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap
command! -nargs=0 JunkfileDiary call junkfile#open_immediately(
      \ strftime('%Y-%m-%d.md'))
command! -range -nargs=1 AddNumbers
      \ call s:add_numbers((<line2>-<line1>+1) * eval(<args>))
command! FZFLines mksession! /tmp/layout.vim | call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})
command! Wa wa
command! W w

function! s:mkdir_as_necessary(dir, force)
  if !isdirectory(a:dir) && &l:buftype ==? '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! ToggleSpell()
  let b:myLang=g:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
  else
    execute 'setlocal spell spelllang='.get(g:myLangList, b:myLang)
  endif
  echo 'spell checking language:' g:myLangList[b:myLang]
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

function! s:my_on_filetype() 
  " Disable automatically insert comment.
  "setl formatoptions-=ro | setl formatoptions+=mMBl

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

function! s:PreviousWindowOrTab()
  if winnr() > 1
    wincmd W
  else
    tabprevious
    execute winnr('$') . 'wincmd w'
  endif
endfunction

function! s:CustomBufferDelete(is_force)
  let l:current = bufnr('%')

  call s:alternate_buffer()

  if a:is_force
    silent! execute 'bdelete! ' . l:current
  else
    silent! execute 'bdelete ' . l:current
  endif
endfunction

function! s:alternate_buffer() 
  let l:listed_buffer_len = len(filter(range(1, bufnr('$')),
        \ 's:buflisted(v:val) && getbufvar(v:val, ''&filetype'') !=# ''unite'''))
  if l:listed_buffer_len <= 1
    enew
    return
  endif

  let l:cnt = 0
  let l:pos = 1
  let l:current = 0
  while l:pos <= bufnr('$')
    if s:buflisted(l:pos)
      if l:pos == bufnr('%')
        let l:current = l:cnt
      endif

      let l:cnt += 1
    endif

    let l:pos += 1
  endwhile

  if l:current > l:cnt / 2
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

function! s:check_back_space() abort
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1]  =~? '\s'
endfunction


function! s:smart_search_expr(expr1, expr2)
    return line('$') > 5000 ?  a:expr1 : a:expr2
endfunction

function! s:unite_my_settings() 
    mksession! /tmp/layout.vim
    " Directory partial match.
    call unite#custom#alias('file', 'h', 'left')
    call unite#custom#default_action('directory', 'narrow')
    " call unite#custom#default_action('file', 'my_tabopen')

    call unite#custom#default_action('versions/git/status', 'commit')
    imap <buffer>  jj        <Plug>(unite_insert_leave)
    imap <buffer> ;          <Plug>(unite_quick_match_default_action)
    imap <buffer> <C-w>      <Plug>(unite_delete_backward_path)
    imap <buffer> <C-z>      <Plug>(unite_toggle_transpose_window)
    nmap <buffer> ;          <Plug>(unite_quick_match_default_action)
    nmap <buffer> <C-j>      <Plug>(unite_toggle_auto_preview)
    nmap <buffer> <C-z>      <Plug>(unite_toggle_transpose_window)
    nmap <buffer> ZQ      ZQ:wincmd p<CR>
    nmap <buffer> cd         <Plug>(unite_quick_match_default_action)
    nnoremap <silent><buffer><expr> l unite#smart_map('l', unite#do_action('default'))


    let l:unite = unite#get_current_unite()
    if l:unite.profile_name ==# '^search'
        nnoremap <silent><buffer><expr> r     unite#do_action('replace')
    else
        nnoremap <silent><buffer><expr> r     unite#do_action('rename')
    endif
    nnoremap <silent><buffer><expr> !     unite#do_action('start')
    nnoremap <buffer><expr> S      unite#mappings#set_current_filters(empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
endfunction

" My custom split action
function! s:my_split.func(candidate)
    let l:split_action = 'vsplit'
    if winwidth(winnr('#')) <= 2 * (&textwidth ? &textwidth : 80)
        let l:split_action = 'split'
    endif
    call unite#take_action(l:split_action, a:candidate)
endfunction

function! s:www_search()
    let l:search_word = input('Please input search word: ')
    if l:search_word !=? ''
    execute 'OpenBrowserSearch' escape(l:search_word, '"')
    endif
endfunction


function! FindCabalSandboxRoot()
    return finddir('.cabal-sandbox', './;')
endfunction

function! FindCabalSandboxRootPackageConf()
    return glob(FindCabalSandboxRoot().'/*-packages.conf.d'))
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
        \        "v:val !~# 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'")
      let l:indexedFileList = extend(l:oldfilesFiltered,
            \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
      return l:indexedFileList
  endfunction


function! s:vimfiler_my_settings() 
  call vimfiler#set_execute_file('vim', ['vim', 'notepad'])
  call vimfiler#set_execute_file('txt', 'vim')

  nmap <buffer> f <Plug>(vimfiler_new_file)
  nmap <buffer> n <Plug>(vimfiler_make_directory)
  nmap <buffer> <F2> <Plug>(vimfiler_rename_file)
  nmap <buffer> yy <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_copy_file)

  " Migemo search.
  if !empty(unite#get_filters('matcher_migemo'))
    nnoremap <silent><buffer><expr> /  line('$') > 10000 ?  'g/' :
          \ ":\<C-u>Unite -buffer-name=search -start-insert line_migemo\<CR>"
  endif

endfunction

function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction


"call deoplete#enable()
"call deoplete#custom#set('ghc', 'sorters', ['sorter_word'])
"call deoplete#custom#set('_', 'converters', [
"    \ 'converter_remove_paren',
"    \ 'converter_remove_overlap',
"    \ 'converter_truncate_abbr',
"    \ 'converter_truncate_menu',
"    \ 'converter_auto_delimiter',
"    \ ])

call unite#custom_action('openable', 'context_split', s:my_split)
call unite#custom#profile('default', 'context', g:unite#default_context)
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
call unite#custom#profile('action', 'context', {
        \ 'start_insert' : 1
        \ })

call unite#custom#source('line_migemo', 'matchers', 'matcher_migemo')

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
  "I get a bug related to: https://github.com/neovim/neovim/issues/4895
  " Therefore the nasty for loop and checks
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

nnoremap <silent> <Space>m :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>
 
command! -nargs=* Ag mksession! /tmp/layout.vim | call fzf#run({
\ 'source':  printf('ag --nogroup --column --nocolor --ignore %s --ignore %s "%s"',
\                   'bundle.js', 'bundle.js.map',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

let &titlestring="
      \ %{expand('%:p:.:~')}%(%m%r%w%)
      \ %<\(%{".s:SID_PREFIX()."strwidthpart(
      \ fnamemodify(&filetype ==# 'vimfiler' ?
      \ substitute(b:vimfiler.current_dir, '.\\zs/$', '', '') : getcwd(), ':~'),
      \ &columns-len(expand('%:p:.:~')))}\) - VIM"
let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
      \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
      \ . "%{(&previewwindow?'[preview] ':'').expand('%')}"
      \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
      \ . "%{printf(' %4d/%d',line('.'),line('$'))} %c"


" Show which highlight group is active under cursor
" (doesn't work with SpecialKey)
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
    endif
endfunction

call s:ApplyCustomColorScheme()

" this has to be on the bottom
if s:isWindows()
    set noshellslash
endif

