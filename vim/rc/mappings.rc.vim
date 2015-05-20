"---------------------------------------------------------------------------
" Key-mappings:
"

" Use <C-Space>.
nmap <C-Space>  <C-@>
cmap <C-Space>  <C-@>

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
" <C-t>: insert tab.
inoremap <C-t>  <C-v><TAB>
" <C-d>: delete char.
inoremap <C-d>  <Del>
" <C-a>: move to head.
" inoremap <silent><C-a>  <C-o>^
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
    if strlen(expand("%:p"))
        silent exe ' !setsid gvim ' . expand("%:p") . ' +' . x[1] .
                    \ ' -c "cd ' . getcwd() .
                    \ ' | normal 0 ' . x[2] . 'lzz " '
    else
        echo 'nnooo  '
    endif
endfunction

nnoremap [Space]h
    \ :Unite history/unite <CR>

" nnoremap <silent> [Space]aa \
"     \ :Unite -start-insert -default-action=cd directory_mru <CR>
" nnoremap <silent> [Space]dc \
"     \ :Unite -default-action=tabnew_lcd directory_mru <CR>

"Open files
" windows doesn't (per this config) have all the features (such as file_rec/async)
"
" ...actually; the one in linux isnt that good either. The display lags and you
" to wait. The mru will have to do..
" if has('win16') || has('win32') || has('win64')
"     nnoremap <silent> [Space]of
"         \ :Unite -start-insert file file/new buffer_tab <CR>
" else
"     nnoremap <silent> [Space]of
"         \ :Unite -start-insert file file/new buffer_tab <CR>
"         " \ :Unite -start-insert buffer file_rec/async file/new file_mru<CR>
" endif
" nnoremap <silent> [Space]og
"     \ :Unite -start-insert file_rec/git<CR>
"     " \ :Unite -start-insert buffer file_rec/async file/new file_mru<CR>
" nnoremap <silent> [Space]m
"         \ :Unite file_mru <CR>
"

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
" Do async search
nnoremap <silent> [Space]/
      \ :Unite grep:.<CR>
" Do async search
nnoremap <silent> [Space]*
      \ :UniteWithCursorWord grep<CR>
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
      \ :call ToggleColorScheme()<CR>
" Set autoread.
nnoremap [Space]ar
      \ :<C-u>setlocal autoread<CR>
" Output encoding information.
nnoremap <silent> [Space]en
      \ :<C-u>setlocal encoding? termencoding? fenc? fencs?<CR>
" Set spell check.
nnoremap [Leader]sp
      \ :<C-u>call ToggleOption('spell')<CR>
nnoremap <Leader>w
      \ :<C-u>call ToggleOption('wrap')<CR>
nnoremap [Space]w :w<CR>

" Change current directory.
" nnoremap <silent> [Space]cd :<C-u>call <SID>cd_buffer_dir()<CR>
" function! s:cd_buffer_dir() "{{{
"   let filetype = getbufvar(bufnr('%'), '&filetype')
"   if filetype ==# 'vimfiler'
"     let dir = getbufvar(bufnr('%'), 'vimfiler').current_dir
"   elseif filetype ==# 'vimshell'
"     let dir = getbufvar(bufnr('%'), 'vimshell').save_dir
"   else
"     let dir = isdirectory(bufname('%')) ? bufname('%') : fnamemodify(bufname('%'), ':p:h')
"   endif
"
"   cd `=dir`
" endfunction"}}}

" Delete windows ^M codes.
nnoremap <silent> <Leader><C-m> mmHmt:<C-u>%s/\r$//ge<CR>'tzt'm

" Delete spaces before newline.
" nnoremap <silent> <Leader>ss mmHmt:<C-u>%s/<Space>$//ge<CR>`tzt`m

"Clear excess whitespace. mm is to center back to original pos
nnoremap <silent> <Leader>ss mm:%s/\s\+$//g<CR>`mmmzz


" Easily syntax change.
nnoremap <silent> [Space]ft :<C-u>Unite -start-insert filetype<CR>


" Change tab width. "{{{
" nnoremap <silent> [Space]t2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
" nnoremap <silent> [Space]t4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
" nnoremap <silent> [Space]t8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>
"}}}
"}}}

" s: Windows and buffers(High priority) "{{{
" The prefix key.
nnoremap    [Window]   <Nop>
nmap    s [Window]
" nnoremap <silent> [Window]p  :<C-u>call <SID>split_nicely()<CR>
" nnoremap <silent> [Window]v  :<C-u>vsplit<CR>
" nnoremap <silent> [Window]c  :<C-u>call <SID>smart_close()<CR>
" nnoremap <silent> -  :<C-u>call <SID>smart_close()<CR>
nnoremap <silent> ;o  :<C-u>only<CR>
" nnoremap <silent> q :<C-u>call <SID>smart_close()<CR>

" A .vimrc snippet that allows you to move around windows beyond tabs
" nnoremap <silent> <Tab> :call <SID>NextWindow()<CR>
" nnoremap <silent> <S-Tab> :call <SID>PreviousWindowOrTab()<CR>

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

" Split nicely."{{{
command! SplitNicely call s:split_nicely()
function! s:split_nicely()
  " Split nicely.
  if winwidth(0) > 2 * &winwidth
    vsplit
  else
    split
  endif
  wincmd p
endfunction
"}}}
" Delete current buffer."{{{
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
"}}}
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

" e: Change basic commands "{{{
" The prefix key.

" Disable Ex-mode.
nnoremap Q  q

" q: Quickfix  "{{{
" The prefix key.
nnoremap [Quickfix]   <Nop>

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
nnoremap <Leader>f :%s/^$/AB0\.1/g <bar> v/[0-9\-]\./d <bar> %s/AB0\.1//g <bar> %s/^\s\+//g <bar> %s/\v( ){1,10}/ /g <bar> %s/\s\+$//

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
nnoremap * *<C-o> "stay right where you are

cmap w!! w !sudo tee > /dev/null %
