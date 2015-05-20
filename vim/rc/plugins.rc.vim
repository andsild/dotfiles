"---------------------------------------------------------------------------
" Plugin:
"

source ~/.vim/rc/plugins/BufOnly.vim

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

if neobundle#tap('neocomplete.vim') "{{{
  let g:neocomplete#enable_at_startup = 1
  " see also vim/rc/plugins/neocomplete.rc.vim
  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/neocomplete.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('neocomplcache.vim') "{{{
  let g:neocomplcache_enable_at_startup = 0
  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/neocomplcache.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('neosnippet.vim') "{{{
  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/neosnippet.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('echodoc.vim') "{{{
  let g:echodoc_enable_at_startup = 0

  call neobundle#untap()
endif "}}}

if neobundle#tap('vimshell.vim') "{{{
  " <C-Space>: switch to vimshell.
  nmap <C-@>  <Plug>(vimshell_switch)
  nnoremap !  q:VimShellExecute<Space>


 let g:vimshell_no_default_keymappings=0


"  nnoremap [Space]i  q:VimShellInteractive<Space>
"  nnoremap [Space]t  q:VimShellTerminal<Space>

  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/vimshell.rc.vim'

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

  " nnoremap <silent> [Space]ou
  "       \ :<C-u>Unite outline -no-start-insert -resume<CR>
  " nnoremap <silent> ;t
  "       \ :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
  nnoremap [Space]t
        \ :<C-u>Unite -start-insert tag tag tag/include<CR>
  nnoremap <silent> <C-k>
        \ :<C-u>Unite change jump<CR>
  nnoremap <silent> [Space]r
        \ :<C-u>Unite -buffer-name=register register history/yank<CR>

  " t: tags-and-searches "{{{
  " The prefix key.
  " nnoremap    [Tag]   <Nop>
  " nmap    t [Tag]
  " Jump.
  " nnoremap [Tag]t  g<C-]>
  " nnoremap <silent><expr> [Tag]t  &filetype == 'help' ?  "g\<C-]>" :
  "       \ ":\<C-u>UniteWithCursorWord -buffer-name=tag -immediately tag tag/include\<CR>"
  " nnoremap <silent><expr> [Tag]p  &filetype == 'help' ?
  "       \ ":\<C-u>pop\<CR>" : ":\<C-u>Unite jump\<CR>"
  "}}}

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

  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/unite.rc.vim'

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
  nnoremap    [Space]ff   :<C-u>VimFilerExplorer<CR>

  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/vimfiler.rc.vim'

  call neobundle#untap()
endif "}}}

if neobundle#tap('eskk.vim')
  imap <C-j>     <Plug>(eskk:toggle)

  let neobundle#hooks.on_source =
        \ '~/.vim/rc/plugins/eskk.rc.vim'

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
      silent! xunmap <buffer> gc
      silent! nunmap <buffer> gcc
      silent! xunmap <buffer> gcc
    else
      nmap <buffer> gc <Plug>(caw:prefix)
      xmap <buffer> gc <Plug>(caw:prefix)
      nmap <buffer> gcc <Plug>(caw:i:toggle)
      xmap <buffer> gcc <Plug>(caw:i:toggle)
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

" if neobundle#tap('glowshi-ft.vim') "{{{
"   let g:glowshi_ft_no_default_key_mappings = 1
"   map f <Plug>(glowshi-ft-f)
"   map F <Plug>(glowshi-ft-F)
"
"   let g:glowshi_ft_timeoutlen = 1000
"
"   call neobundle#untap()
" endif "}}}

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

if neobundle#tap('vim-signature')
      let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "m<Space>",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "]`",
        \ 'GotoPrevSpotByPos'  :  "[`",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "m/",
        \ 'ListLocalMarkers'   :  "m?"
        \ }
    call neobundle#untap()
endif
" Omnisharp does not work for me :(
" It loads a solution and all its files, but registers all of my *buffers*
" under something called OrphanProject. Therefore I have omnisharp only for
" buffered files.
" Therefore, I created a .vim/omnifuck.py that
" loads all cs files and manually adds it to the OrphanProject.

" Beware, there is also a au BufEnter cs in my ~/.vim/filetype.vim
" to automatically source the ftplugin in .cache/omnnisharp/ 
" (required for function calls like :OmniSharpFindUsages, etc)
if neobundle#tap('Omnisharp')
    NeoBundleSource ctrlp.vim

    let g:Omnisharp_start_server = 0
    let g:Omnisharp_stop_server = 0
    let g:omnicomplete_fetch_full_documentation = 0
    let g:OmniSharp_typeLookupInPreview = 0
    let g:OmniSharp_timeout = 100 " hit ctrl+c to abort it.
    set noshowmatch
    call neobundle#untap()
endif

if neobundle#tap('syntastic')
    let g:syntastic_check_on_open = 0 
    let g:syntastic_check_on_save = 1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    " let g:syntastic_check_on_wq = 0
    let g:syntastic_quiet_messages = { "type": "style",
                                    \  "level": "warnings" }
    let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
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
    let g:dbext_default_profile_mySQLServer = 'type=SQLSRV:integratedlogin=1:srvname=172.22.200.103:dbname=myDB' 
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

if neobundle#tap('jedi-vim')
    autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
    let g:jedi#popup_select_first = 0 " dont pop up the first one
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#use_tabs_not_buffers = 0
    call neobundle#untap()
endif

if neobundle#tap('ultisnips')
    let g:UltiSnipsExpandTrigger="<C-CR>"
    let g:UltiSnipsJumpForwardTrigger="<C-tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    call neobundle#untap()
endif


if neobundle#tap('vim-latex-live-preview')
    let g:livepreview_previewer = 'zathura'
    call neobundle#untap()
endif

if neobundle#tap('vim-autoformat')
    nnoremap <silent> <Leader>au :Autoformat<CR>
    call neobundle#untap()
endif
