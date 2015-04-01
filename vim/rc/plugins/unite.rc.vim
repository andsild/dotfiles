"---------------------------------------------------------------------------
" unite.vim
"

" When writing custom menus, keep in mind that by choosing the 
" menu-entries (candidates) in a smart way, you also make it easier to quickly
" use the menu. For example, the openfile menu has each entry by their
" own key ([M]RU, [F]iles, [G]it files), making it easy to quickly access
" each entry by only one keystroke

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
" call unite#custom#source(
"       \ 'file', 'matchers',
"       \ ['matcher_fuzzy', 'matcher_hide_hidden_files'])
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
  imap <buffer> '          <Plug>(unite_quick_match_default_action)
  nmap <buffer> '          <Plug>(unite_quick_match_default_action)
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
  let g:unite_source_rec_async_command='ag -m0 -g "" ' . g:unite_source_grep_default_opts
elseif executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('jvgrep')
  " For jvgrep.
  let g:unite_source_grep_command = 'jvgrep'
  let g:unite_source_grep_default_opts = '-i --exclude ''\.(git|svn|hg|bzr)'''
  let g:unite_source_grep_recursive_opt = '-R'
elseif executable('ack-grep')
  " For ack.
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts = '-i --no-heading --no-color -a'
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

" nnoremap <silent> <Leader>st :NeoCompleteIncludeMakeCache<CR>
"             \ :UniteWithCursorWord -immediately -sync
"             \ -default-action=context_split tag/include<CR>
nnoremap <silent> [Space]n  :UniteNext<CR>
nnoremap <silent> [Space]p  :UnitePrevious<CR>
nnoremap <silent> [Space]r  :UniteResume<CR>


if neobundle#tap('gitv')
    let g:unite_source_menu_menus.git = {
        \ 'description' : '            admin git repositories
            \                                [Space]g',
        \}
    let g:unite_source_menu_menus.git.command_candidates = [
        \['-> git viewer             (gitv)                              W ,gv',
            \':Gitv --all'],
        \['-> git viewer - buffer    (gitv)                              W ,gV',
            \':Gitv --all'],
        \['-> git tig             (unite tig)                              W ,gv',
            \':Unite tig'],
        \['-> git status             (fugitive)                          W ,gs',
            \'Gstatus'],
        \['-> git diff               (fugitive)                          W ,gd',
            \'Gdiff'],
        \['-> git commit             (fugitive)                          W ,gc',
            \'Gcommit'],
        \['-> git log                (fugitive)                          W ,gl',
            \'exe "silent Glog | Unite -no-quit quickfix"'],
        \['-> git log - all          (fugitive)                          W ,gL',
            \'exe "silent Glog -all | Unite -no-quit quickfix"'],
        \['-> git blame              (fugitive)                          W ,gb',
            \'Gblame'],
        \['-> git add/stage          (fugitive)                          W ,gw',
            \'Gwrite'],
        \['-> git push               (fugitive, buffer output)           W ,gp',
            \'Git! push'],
        \['-> git pull               (fugitive, buffer output)           W ,gP',
            \'Git! pull'],
        \['-> git command            (fugitive, buffer output)           W ,gi',
            \'exe "Git! " input("comando git: ")'],
        \['-> git edit               (fugitive)                          W ,gE',
            \'exe "command Gedit " input(":Gedit ")'],
        \['-> git grep               (fugitive)                          W ,gg',
            \'exe "silent Ggrep -i ".input("Pattern: ") | Unite -no-quit quickfix'],
        \['-> git grep - text        (fugitive)                          W ,ggt',
            \'exe "silent Glog -S".input("Pattern: ")." | Unite -no-quit quickfix"'],
        \['-> github dashboard       (github-dashboard)                  W ,gD',
            \'exe "GHD! " input("Username: ")'],
        \['-> github activity        (github-dashboard)                  W ,gA',
            \'exe "GHA! " input("Username or repository: ")'],
        \]
    nnoremap <silent>[Space]g :Unite -silent -winheight=29 -start-insert menu:git<CR>

    call neobundle#untap()
endif

if neobundle#tap('dbext.vim')
    let g:unite_source_menu_menus.db = {
        \ 'description' : '             database (SQL)
            \                                        W [space]S',
        \}
    let g:unite_source_menu_menus.db.command_candidates = [
        \['-> Execute SQL',
            \'exe "DBExecSQL" " ".input("SQL?: ")'],
        \['-> Execute SQL (with limit of n rows)',
            \'exe "DBExecSQL" " ".input("SQL?: ")'],
        \['-> SQL SELECT statement',
            \'exe "Select" " ".input("SELECT ")'],
        \['-> SQL UPDATE statement',
            \'exe "Update" " ".input("UPDATE")'],
        \['-> SQL INSERT statement',
            \'exe "Insert" " ".input("INSERT")'],
        \['-> SQL DELETE statement',
            \'exe "Delete" " ".input("DELETE")'],
        \['-> SQL CALL statement',
            \'exe "Call" " ".input("CALL")'],
        \['-> SQL DROP statement',
            \'exe "Drop" " ".input("DROP")'],
        \['-> SQL ALTER statement',
            \'exe "Alter" " ".input("ALTER")'],
        \['-> SQL CREATE statement',
            \'exe "Create" " ".input("CREATE")'],
        \['-> List all Tables                                            W ,Slt',
            \'DBListTable'],
        \['-> List all Procedures                                        W ,Slp',
            \'DBListProcedure'],
        \['-> List all Views                                             W ,Slv',
            \'DBListView'],
        \['-> List all Variables                                         W ,Svr',
            \'DBListVar'],
        \['-> DBext Get Options',
            \'DBGetOption'],
        \['-> DBext Set Option',
            \'exe "DBSetOption" " ".input("Option: ")'],
        \['-> DBext Set Var',
            \'exe "DBSetVar" " ".input("Var: ")'],
        \['-> DBext Set Buffer Parameters',
            \'DBPromptForBufferParameters'],
        \['-> List all Connections       (only DBI/ODBC)',
            \'DBListConnections'],
        \['-> Commit                     (only DBI/ODBC)',
            \'DBCommit'],
        \['-> Rollback                   (only DBI/ODBC)',
            \'DBRollback'],
        \['-> Connect                    (only DBI/ODBC)',
            \'DBConnect'],
        \['-> Disconnect                 (only DBI/ODBC)',
            \'DBDisconnect'],
        \]

        nnoremap [Space]S :Unite menu:db -silent -winheight=25 -start-insert<CR>

        call neobundle#untap()
    endif

if neobundle#tap('Omnisharp')

        let g:unite_source_menu_menus.omnisharp = {
                \ 'description' : '            Omnisharp commands (intellisense)
                    \                                [Space]i',
            \}
        let g:unite_source_menu_menus.omnisharp.command_candidates = [
            \['-> Actions',
                \'exe "OmniSharpGetCodeActions"'],
            \['-> Build',
                \'exe "OmniSharpBuildAsync"'],
            \['-> Definition',
                \'exe "OmniSharpGotoDefinition"'],
            \['-> Format',
                \'exe "OmniSharpCodeFormat"'],
            \['-> Implementations',
                \'exe "OmniSharpFindImplementations"'],
            \['-> Organize imports',
                \'exe "OmniSharpFixUsings"'],
            \['-> Symbol',
                \'exe "OmniSharpFindSymbol"'],
            \['-> Usages',
                \'exe "OmniSharpFindUsages"'],
            \['-> Rename',
                \'exe "OmniSharpRename"'],
            \['-> Tests',
                \'exe "OmniSharpRunAllTests"'],
            \['-> LastTests',
                \'exe "OmniSharpRunLastTests"'],
        \]
        nnoremap <silent> [Space]i :Unite menu:omnisharp -silent -winheight=25 -start-insert<CR>

    call neobundle#untap()
endif


let g:unite_source_menu_menus.diff = {
        \ 'description' : '            Diff commands
            \                                [Space]d',
    \}
let g:unite_source_menu_menus.diff.command_candidates = [
    \['-> Diffthis',
        \'exe "diffthis"'],
    \['-> Diffoff',
        \'exe "diffoff"'],
    \['-> Diffupdate',
        \'exe "diffupdate"'],
\]
nnoremap <silent> [Space]di :Unite menu:diff -silent -winheight=10 <CR>


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
